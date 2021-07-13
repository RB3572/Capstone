server <- function(input, output) {
    library(keras)
    library(quantmod)
    library(TTR)
    library(devtools)
    #install_github("Ferryistaken/ezstocks")
    library(ezstocks)
    library(xts)
    minmax_normalize <- function(x, na.rm = TRUE) {
        return((x- min(x)) /(max(x)-min(x)))
    }
    stockArray <- c("AMZN") #TODO: replace with ticker variable later reactive(input$ticker)
    cutoff <- 0.7
    stockData <- getStockData(stockArray)
    startYear <- "2015"
    startMonth <- "01"
    startDay <- "01"
    allData = ezstocks::getStockData(stocks = stockArray, startYear = startYear, startMonth = startMonth,  startDay = startDay)
    closeData <- ezstocks::getCloseData(allData)
    returnsList <- apply(as.xts(closeData), 2, quantmod::Delt) + 1
    returnsList = returnsList[-1,]
    data = cbind(returnsList,lag(returnsList, 1),lag(returnsList, 2),lag(returnsList, 3),lag(returnsList, 5),lag(returnsList, 10),lag(returnsList, 25),lag(returnsList, 50))
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
    output$plot <- renderPlot({
        plot(model$Training.Plot)
        
        
    })
    
}


