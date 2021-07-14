avgDiffRNN <- function(ticker, epochs, modelPath = "../Scripts/src/keras-nn-regressor.R") {
    library(keras)
    library(quantmod)
    library(TTR)
    library(devtools)
    #install_github("Ferryistaken/ezstocks")
    library(ezstocks)
    library(xts)
    source(modelPath)
    minmax_normalize <- function(x, na.rm = TRUE) {
        return((x - min(x)) /(max(x)-min(x)))
    }
    
    source("src/MovingAvgDiff.R")
    source("src/get-correct-data.R")
    
    cutoff <- 0.7
    stockData <- getStockData(c(ticker))
    startYear <- "2015"
    startMonth <- "01"
    startDay <- "01"
    allData = ezstocks::getStockData(stocks = c(ticker), startYear = startYear, startMonth = startMonth,  startDay = startDay)
    closeData <- ezstocks::getCloseData(allData)
    
    correctData <- getCorrectData(c(ticker))
    smas <- as.data.frame(cbind(correctData$sortedStockData[, 9], correctData$sortedStockData[, 15]))
    colnames(smas) <- c("50", "200")
    
    avgDiff <- MovingAvgDiff(smas[, 1], smas[, 2])
    
    minX <- min(closeData)
    maxX <- max(closeData)
    closeData <- minmax_normalize(closeData)
    data = cbind(closeData ,lag(closeData, 1),lag(closeData, 2),lag(closeData, 3),lag(closeData, 5),lag(closeData, 10),lag(closeData, 25),lag(closeData, 50), avgDiff)
    data = data.frame(na.omit(data))
    colnames(data) = c("Y", paste0("Lag", c(1, 2, 3, 5, 10, 25, 50)))
    x <- data[, -1]
    y <- as.data.frame(data[, 1])
    colnames(y) = "Y"
    x_train <- x[1:(nrow(x) * cutoff), ]
    y_train <- as.data.frame(y[1:(nrow(y) * cutoff), ])
    x_test <- x[1:(nrow(x) * (1 - cutoff)), ]
    y_test <- as.data.frame(y[1:(nrow(y) * (1 - cutoff)), ])
    
    model = KerasNNRegressor(
        x = x,
        y = y,
        cutoff = 0.80,
        numberOfHiddenLayers = 4,
        activation = "relu",
        useBias = TRUE,
        dropoutRate = 0.25,
        epochs = epochs)
    
    minmax_reverse <- function(x) {
        return(x * (maxX - minX) + minX)
    }
    
    plotData <- cbind(minmax_reverse(model$y_test), minmax_reverse(model$y_test_hat))
    
    matplot(plotData, type = "l", main = paste0("Real price of ", ticker, " vs predicted price"), ylab = "Price in USD", xlab = "Time(Days)")
    
}

avgDiffRNN(ticker = "AAPL", epochs = 115)