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
rawData <- as.data.frame(stock)

openData <- select(rawData, contains("Open"))
highData <- select(rawData, contains("High"))
lowData <- select(rawData, contains("Low"))
closeData <- select(rawData, contains("Close"))
volumeData <- select(rawData, contains("Volume"))
adjustedData <- select(rawData, contains("Adjusted"))

allData <- data.frame()
allData <- rbind(openData, highData)

ma50 = SMA(closeData[1], 50)
ma200 = SMA(closeData[1], 200)

for (i in 1:length(stockArray)) {
    print(paste0(stockArray[i], "$", stockArray[i], ".Close"))
}