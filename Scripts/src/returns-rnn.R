rm(list = ls())
gc()

library(keras)
library(quantmod)
library(TTR)
library(devtools)
library(ezstocks)
library(xts)

stockArray <- c("AMZN")
cutoff <- 0.7

# Get data
stockData <- getStockData(stockArray)
##### We should use return since stocks only go up


startYear <- "2015"
startMonth <- "01"
startDay <- "01"

########### CHOOSE STOCKS AND TIME FRAME ######
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
y <- as.data.frame(data[, 1])
colnames(y) = "Y"
 
# dim(x)
# dim(y)

x_train <- x[1:(nrow(x) * cutoff), ]
y_train <- as.data.frame(y[1:(nrow(y) * cutoff), ])

x_test <- x[1:(nrow(x) * (1 - cutoff)), ]
y_test <- as.data.frame(y[1:(nrow(y) * (1 - cutoff)), ])

# dim(x_train)
# dim(y_train)
# 
# dim(x_test)
# dim(y_test)

# New column should be difference in price between 50MA and 200MA

######### MODEL #############
source("src/keras-nn-regressor.R")

model = KerasNNRegressor(
    x = x,
    y = y,
    cutoff = 0.97,
    numberOfHiddenLayers = 4,
    activation = "relu",
    useBias = TRUE,
    dropoutRate = 0.3,
    epochs = 200)