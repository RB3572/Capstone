library(quantmod)

startYear <- "2010"
startMonth <- "01"
startDay <- "01"

stockArray <- c("AAPL", "MSFT", "RTX", "GOOGL", "V", "AMZN", "NVDA", "KO", "STT", "ROK", "BA", "GWW", "TJX", "WBA", "MCD", "QCOM", "AMD")
startDate <- paste0(startYear, "-", startMonth, "-", startDay)

########### GET STOCK DATA ####################
stock <- lapply(as.list(stockArray), function(x) {
    tmp <- try(getSymbols(x, from=startDate,   auto.assign = FALSE))
    if(!inherits(tmp, 'try-error'))
        tmp})

########## MANIPULATE DATA ###################
allData <- as.data.frame(stock)

closeDat <- select(allData, contains("Close"))