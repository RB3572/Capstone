

MovingAvgDiff <- function(sma50, sma200){
    
    is50Higher = FALSE
    crosses = c()
    priceDiffs = c()
    for(i in 1:(length(sma50) - 1)){
        
        if(is.na(sma50[i]) || is.na(sma200[i])){
            crosses = append(crosses, NA)
            priceDiffs = append(priceDiffs, sma200[i]-sma50[i])
            
        } 
        else{
            if(is50Higher){
                if(sma50[i] < sma200[i]){
                    is50Higher = FALSE
                    #death cross
                    crosses = append(crosses, 'd')
                    print(paste0("death cross at ", i))
                    priceDiffs = append(priceDiffs, 0)
                }
                else{
                    crosses = append(crosses, NA)
                    priceDiffs = append(priceDiffs, sma200[i]-sma50[i])
                    
                }
            }
            
            if(is50Higher == FALSE){
                if(sma50[i] > sma200[i]){
                    is50Higher = TRUE
                    #golden cross
                    crosses = append(crosses,'g')
                    print(paste0("golden cross at ", i))
                    priceDiffs = append(priceDiffs, 0)
                }
                else{
                    crosses= append(crosses, NA)
                    priceDiffs = append(priceDiffs, sma200[i]-sma50[i])
                }
            }
        }
    }
    return (priceDiffs)
}
# source("../Scripts/src/get-correct-data.R")
# source("../Scripts/src/find-index-attribute-ticker.R")
# tickerName <- c("AAPL")
# data = getCorrectData(tickerName)
# crosses = MovingAvgDiff(data$sortedStockData$AAPL.Close.SMA50, data$sortedStockData$AAPL.Close.SMA200)
# newdata = cbind(data$sortedStockData, crosses)
