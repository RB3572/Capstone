modelFunction <- function(input) {
    library(keras)
    library(quantmod)
    library(TTR)
    library(devtools)
    #install_github("Ferryistaken/ezstocks")
    library(ezstocks)
    library(xts)
    source("KerasNNRegressor.R")
    minmax_normalize <- function(x, na.rm = TRUE) {
        return((x - min(x)) /(max(x)-min(x)))
    }
    
    # output$bugcheck <- renderText(
    #     {print(input$ticker)}
    # )
    # tickerName <- input$ticker
    # stockArray <- c(tickerName) #TODO: replace with ticker variable later reactive(input$ticker)
    cutoff <- 0.7
    stockData <- getStockData(c(input))
    # output$bugcheck <- renderText(
    #     {print(getStockData(c(input$ticker)))[1, 1]}
    # )
    startYear <- "2015"
    startMonth <- "01"
    startDay <- "01"
    # output$bugcheck <- renderText(
    #     {print(stockData[1, 1])}
    # )
    allData = ezstocks::getStockData(stocks = c(input), startYear = startYear, startMonth = startMonth,  startDay = startDay)
    # output$bugcheck <- renderText(
    #     {print()}
    # )
    closeData <- ezstocks::getCloseData(allData)
    minX <- min(closeData)
    maxX <- max(closeData)
    # returnsList <- apply(as.xts(closeData), 2, quantmod::Delt) + 1
    # returnsList = returnsList[-1,]
    closeData <- minmax_normalize(closeData)
    data = cbind(closeData ,lag(closeData, 1),lag(closeData, 2),lag(closeData, 3),lag(closeData, 5),lag(closeData, 10),lag(closeData, 25),lag(closeData, 50))
    data = data.frame(na.omit(data))
    colnames(data) = c("Y", paste0("Lag", c(1, 2, 3, 5, 10, 25, 50)))
    x <- data[, -1]
    y <- as.data.frame(data[, 1])
    colnames(y) = "Y"
    x_train <- x[1:(nrow(x) * cutoff), ]
    y_train <- as.data.frame(y[1:(nrow(y) * cutoff), ])
    x_test <- x[1:(nrow(x) * (1 - cutoff)), ]
    y_test <- as.data.frame(y[1:(nrow(y) * (1 - cutoff)), ])
    source = ("KerasNNRegressor.R")
    model = KerasNNRegressor(
        x = x,
        y = y,
        cutoff = 0.97,
        numberOfHiddenLayers = 3,
        activation = "relu",
        useBias = TRUE,
        dropoutRate = 0.2,
        epochs = 100)
    
    minmax_reverse <- function(x) {
        return(x * (maxX - minX) + minX)
    }
    
    plotData <- cbind(minmax_reverse(model$y_test), minmax_reverse(model$y_test_hat))
    
    matplot(plotData, type = "l")
}


server <- function(input, output) {
    output$plot <- renderPlot({
        modelFunction(input$ticker)
    })
    
}


