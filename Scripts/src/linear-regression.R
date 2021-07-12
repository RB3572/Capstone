rm(list = ls())
gc()

library(quantmod)
library(TTR)
library(devtools)
library(ezstocks)
library(xts)
library(dygraphs)

source("src/get-correct-data.R")

startYear <- "2010"
startMonth <- "01"
startDay <- "01"

stocks <- c("GS")

stockData = getStockData(stocks,
                         startYear = startYear,
                         startMonth = startMonth,
                         startDay = startDay)

close = getCloseData(stockData)

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
     col = "grey",
 lwd = 0.1,
     main = paste0("Real price of ", stocks[1], " vs prediction"),
     xlab = "Time (Days)",
     ylab = "Price (USD)")

lines(close[, 1], col = "blue")