library(quantmod)
library(dplyr)
library(dygraphs)
library(TTR)

rm(list = ls())
gc()

startYear <- "2010"
startMonth <- "01"
startDay <- "01"

stockArray <- c("AAPL", "MSFT", "RTX")
startDate <- paste0(startYear, "-", startMonth, "-", startDay)

########### GET STOCK DATA ####################
stock <- lapply(as.list(stockArray), function(x) {
    tmp <- try(getSymbols(x, from=startDate,   auto.assign = FALSE))
    if(!inherits(tmp, 'try-error'))
        tmp})

########## MANIPULATE DATA ###################
allData <- as.data.frame(stock)

closeData <- select(allData, contains("Close"))

ma50 = SMA(closeData[1])

for (i in 1:length(stockArray)) {
    print(paste0(stockArray[i], "$", stockArray[i], ".Close"))
}