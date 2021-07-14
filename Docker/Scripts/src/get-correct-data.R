getCorrectData = function(stockArray) {
    library(quantmod)
    library(TTR)
    library(ezstocks)
    
    # Get data
    stockData <- getStockData(stocks = stockArray, startYear = "2015", startMonth = "01", startDay = "01")
    
    # Manipulate data
    sortedStockData <- cbind(getHighData(stockData), getOpenData(stockData), getCloseData(stockData), getLowData(stockData), getVolume(stockData), getAdjustedData(stockData))
    
    for (i in 1:(length(stockArray)*6)) {
        sortedStockData <- cbind(sortedStockData, SMA(sortedStockData[, i], 50))
        
        colnames(sortedStockData)[length(stockArray) * 6 + i] <- paste0(colnames(sortedStockData)[i], ".SMA50")
    }
    
    for (i in 1:(length(stockArray)*6)) {
        sortedStockData <- cbind(sortedStockData, SMA(sortedStockData[, i], 200))
        
        colnames(sortedStockData)[((length(stockArray) * 6) * 2) + i] <- paste0(colnames(sortedStockData)[i], ".SMA200")
    }
    
    colOrder <- c("High", "Open", "Close", "Low", "Volume", "Adjusted", "SMA50", "SMA200")
    return(list(sortedStockData = sortedStockData, colOrder = colOrder))
}