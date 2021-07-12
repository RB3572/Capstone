rm(list = ls())
gc()

library(keras)
library(quantmod)
library(TTR)
library(devtools)
# install_github("Ferryistaken/ezstocks")
library(ezstocks)
library(xts)

minmax_normalize <- function(x, na.rm = TRUE) {
    return((x- min(x)) /(max(x)-min(x)))
}

stockArray <- c("AAPL")

# Get data
stockData <- getStockData(stockArray)
##### We should use return since stocks only go up


startYear <- "2015"
startMonth <- "01"
startDay <- "01"

########### CHOOSE STOCKS AND TIME FRAME ######
stockArray <- c("AAPL")

########### GET STOCK DATA ####################
allData = ezstocks::getStockData(stocks = stockArray,
                                 startYear = startYear,
                                 startMonth = startMonth,
                                 startDay = startDay)

########## MANIPULATE DATA ###################
closeData <- ezstocks::getCloseData(allData)

returnsList <- apply(as.xts(closeData), 2, quantmod::Delt) + 1
returnsList = returnsList[-1,]


data = cbind(returnsList,
             lag(returnsList, 1),
             lag(returnsList, 2),
             lag(returnsList, 3),
             lag(returnsList, 5),
             lag(returnsList, 10),
             lag(returnsList, 25),
             lag(returnsList, 50)
)

data = data.frame(na.omit(data))
colnames(data) = c("Y", paste0("Lag", c(1, 2, 3, 5, 10, 25, 50)))

x <- data[, -1]
y <- data[, 1]







    