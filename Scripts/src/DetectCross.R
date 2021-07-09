install.packages("devtools")
library(devtools)
install_github("Ferryistaken/ezstocks", force = TRUE)
library(ezstocks)
install.packages("dplyr")
source("Scripts/src/get-correct-data.R")


data = getCorrectData(c("AAPL"))
c1 = test(data)
data = cbind(data, c1)



test <- function(data){
    
    is50Higher = FALSE
    crosses = c()
    for(i in 1:(nrow(data)-1)){
        
        print(i)
        if(is.na(data$AAPL.Close.SMA50[i]) || is.na(data$AAPL.Close.SMA200[i])){
            crosses = append(crosses, NA)
        } 
        else{
            if(is50Higher){
                if(data$AAPL.Close.SMA50[i] < data$AAPL.Close.SMA200[i]){
                    is50Higher = FALSE
                    #death cross
                    crosses = append(crosses, 'd')
                }
                else{
                    crosses = append(crosses, NA)
                }
            }
            
            if(is50Higher == FALSE){
                if(data$AAPL.Close.SMA50[i] > data$AAPL.Close.SMA200[i]){
                    is50Higher = TRUE
                    #golden cross
                    crosses = append(crosses,'g')
                }
                else{
                    crosses= append(crosses, NA)
                }
            }
        }
    }
return (crosses)
}





















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
    
    return(sortedStockData)
}
