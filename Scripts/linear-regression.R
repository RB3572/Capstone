rm(list = ls())
gc()

library(quantmod)
library(TTR)
library(devtools)
# install_github("Ferryistaken/ezstocks")
library(ezstocks)


stockArray <- c("AAPL", "MSFT")
# Get data
stockData <- getStockData(stockArray)

# Manipulate data
sortedStockData <- cbind(getHighData(stockData), getOpenData(stockData), getCloseData(stockData), getLowData(stockData), getVolume(stockData), getAdjustedData(stockData))

for (i in 1:(length(stockArray)*6)) {
    sortedStockData <- cbind(sortedStockData, SMA(sortedStockData[, i], 50))
    
    colnames(sortedStockData)[length(stockArray) * 6 + i] <- paste0(colnames(sortedStockData)[i], ".SMA50")
}

for (i in 1:(length(stockArray)*6)) {
    sortedStockData <- cbind(sortedStockData, SMA(sortedStockData[, i], 200))
    
    colnames(sortedStockData)[(length(stockArray) * 6)*2 + i] <- paste0(colnames(sortedStockData)[i], ".SMA200")
}