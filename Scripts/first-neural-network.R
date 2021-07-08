rm(list = ls())
gc()

library(keras)
library(quantmod)
library(TTR)
library(devtools)
# install_github("Ferryistaken/ezstocks")
library(ezstocks)

# Get data
stockData <- getStockData(c("AAPL", "MSFT", "RTX", "AMZN", "JPM"))

# Manipulate data
sortedStockData <- cbind(getHighData(stockData), getOpenData(stockData), getCloseData(stockData), getLowData(stockData), getVolume(stockData), getAdjustedData(stockData))