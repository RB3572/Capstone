rm(list = ls())
gc()

source("src/get-correct-data.R")
source("src/find-index-attribute-ticker.R")

colOrder <- c("Open", "High", "Low", "Close", "Volume", "Adjusted", "SMA50", "SMA200")

tickerName <- c("AAPL")

# TODO: Softcode all the indexing
detectCross <- function(data){
    
    is50Higher = FALSE
    crosses = c()
    for(i in 1:(nrow(data)-1)){
        
        if(is.na(data$AAPL.Close.SMA50[i]) || is.na(data$AAPL.Close.SMA200[i])){
            crosses = append(crosses, NA)
        } 
        else{
            if(is50Higher){
                if(data$AAPL.Close.SMA50[i] < data$AAPL.Close.SMA200[i]){
                    is50Higher = FALSE
                    #death cross
                    crosses = append(crosses, 'd')
                    print(paste0("death cross at", i))
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
                    print(paste0("golden cross at", i))
                }
                else{
                    crosses= append(crosses, NA)
                }
            }
        }
    }
return (crosses)
}

data = getCorrectData(tickerName)
c1 = detectCross(data)
data = cbind(data, c1)

dataClose = data$sortedStockData[, findIndex(stockArray = tickerName, colOrder = data$colOrder, col = "Close", ticker = "AAPL")]
