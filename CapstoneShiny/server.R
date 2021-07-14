server <- function(input, output) {
    output$ReturnPlot <- renderPlot({
        source("../Scripts/src/keras-nn-regressor.R")
        plot(y = c(input$ReturnEpochs, input$ReturnEpochs, input$ReturnEpochs), x = c(1,2,3), ylim = c(0,1000), main = input$ReturnTicker)
        #keras-nn-regressor(ticker = input$ReturnTicker, epochs = input$ReturnEpochs)
        #modelFunction(ticker = input$ReturnTicker, epochs = input$ReturnEpochs)
    })
    output$GoldenCrossPlot <-renderPlot({
        source("../Scripts/src/keras-nn-regressor.R")
        plot(y = c(input$GoldenEpochs, input$GoldenEpochs, input$GoldenEpochs), x = c(1,2,3), ylim = c(0,1000), main = input$GoldenTicker)
        #keras-nn-regressor(ticker = input$GoldenTicker, epochs = input$GoldenEpochs)
        #modelFunction(ticker = input$GoldenTicker, epochs = input$GoldenEpochs)
    })
    output$plot <- renderPlot({
        source("../Scripts/src/returns-rnn.R")
        returnsRNN(ticker = input$ticker, epochs = input$epochs, modelPath = "../Scripts/src/keras-nn-regressor.R")
    })
    
}





# modelFunction <- function(ticker, epochs) {
#     library(keras)
#     library(quantmod)
#     library(TTR)
#     library(devtools)
#     #install_github("Ferryistaken/ezstocks")
#     library(ezstocks)
#     library(xts)
#     source("../Scripts/src/keras-nn-regressor.R")
#     minmax_normalize <- function(x, na.rm = TRUE) {
#         return((x - min(x)) /(max(x)-min(x)))
#     }
#     
#     # output$bugcheck <- renderText(
#     #     {print(input$ticker)}
#     # )
#     # tickerName <- input$ticker
#     # stockArray <- c(tickerName) #TODO: replace with ticker variable later reactive(input$ticker)
#     cutoff <- 0.7
#     stockData <- getStockData(c(ticker))
#     # output$bugcheck <- renderText(
#     #     {print(getStockData(c(input$ticker)))[1, 1]}
#     # )
#     startYear <- "2015"
#     startMonth <- "01"
#     startDay <- "01"
#     # output$bugcheck <- renderText(
#     #     {print(stockData[1, 1])}
#     # )
#     allData = ezstocks::getStockData(stocks = c(ticker), startYear = startYear, startMonth = startMonth,  startDay = startDay)
#     # output$bugcheck <- renderText(
#     #     {print()}
#     # )
#     closeData <- ezstocks::getCloseData(allData)
#     minX <- min(closeData)
#     maxX <- max(closeData)
#     # returnsList <- apply(as.xts(closeData), 2, quantmod::Delt) + 1
#     # returnsList = returnsList[-1,]
#     closeData <- minmax_normalize(closeData)
#     data = cbind(closeData ,lag(closeData, 1),lag(closeData, 2),lag(closeData, 3),lag(closeData, 5),lag(closeData, 10),lag(closeData, 25),lag(closeData, 50))
#     data = data.frame(na.omit(data))
#     colnames(data) = c("Y", paste0("Lag", c(1, 2, 3, 5, 10, 25, 50)))
#     x <- data[, -1]
#     y <- as.data.frame(data[, 1])
#     colnames(y) = "Y"
#     x_train <- x[1:(nrow(x) * cutoff), ]
#     y_train <- as.data.frame(y[1:(nrow(y) * cutoff), ])
#     x_test <- x[1:(nrow(x) * (1 - cutoff)), ]
#     y_test <- as.data.frame(y[1:(nrow(y) * (1 - cutoff)), ])
#     source = ("KerasNNRegressor.R")
#     model = KerasNNRegressor(
#         x = x,
#         y = y,
#         cutoff = 0.97,
#         numberOfHiddenLayers = 4,
#         activation = "relu",
#         useBias = TRUE,
#         dropoutRate = 0.3,
#         epochs = epochs)
#     
#     minmax_reverse <- function(x) {
#         return(x * (maxX - minX) + minX)
#     }
#     
#     plotData <- cbind(minmax_reverse(model$y_test), minmax_reverse(model$y_test_hat))
#     
#     matplot(plotData, type = "l")
# }





