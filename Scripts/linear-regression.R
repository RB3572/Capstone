rm(list = ls())
gc()

library(quantmod)
library(TTR)
library(devtools)
# install_github("Ferryistaken/ezstocks")
library(ezstocks)
library(xts)
library(dygraphs)

source("get-correct-data.R")

library(TimeWarp)

startYear = "2010"
startMonth = "01"
startDay = "01"

stocks = c("RTX")

stockData = getStockData(stocks,
                         startYear = startYear,
                         startMonth = startMonth,
                         startDay = startDay)

close = getCloseData(stockData)

# Subset to your desired 3-year date range
# end = as.character(last(index(AAPL)))
# start = as.character(TimeWarp::dateWarp(last(index(AAPL)),"-3 years"))
# subset = AAPL[paste(start,end,sep="/")]

# Work with subset from now on. Chart subset (note I removed
# subset argument from call to chartSeries)
# chartSeries(subset, TA = NULL, theme = "white", up.col = "green", dn.col = "red")

# Linear model on same range as your chart
indices = 1:nrow(close)
model = lm(close[, 1]~indices)


nPredictions <- 5000
predictions <- predict(model, newdata = data.frame(indices = 1:nPredictions))

for (i in 1:(nPredictions - nrow(close))) {
    close[nrow(close)+1,] <- NA
}

out <- cbind(close, predictions)

# TODO: Make this line thinner
plot(y = out$predictions,
     x = 1:nrow(out),
     xlim = c(1, 5000),
     col = "black",
     lwd = 0.2,
     main = paste0("Real price of ", stocks[1], " vs prediction"),
     xlab = "Time (Days)",
     ylab = "Price (USD)")
lines(close[, 1], col = "grey")