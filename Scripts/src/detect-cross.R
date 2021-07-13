source("src/get-correct-data.R")
source("src/find-index-attribute-ticker.R")

# tickerName <- c("AAPL")

detectCross <- function(sma50, sma200){
    
    is50Higher = FALSE
    crosses = c()
    for(i in 1:(length(sma50) - 1)){
        
        if(is.na(sma50[i]) || is.na(sma200[i])){
            crosses = append(crosses, NA)
        } 
        else{
            if(is50Higher){
                if(sma50[i] < sma200[i]){
                    is50Higher = FALSE
                    #death cross
                    crosses = append(crosses, 'd')
                    print(paste0("death cross at ", i))
                }
                else{
                    crosses = append(crosses, NA)
                }
            }
            
            if(is50Higher == FALSE){
                if(sma50[i] > sma200[i]){
                    is50Higher = TRUE
                    #golden cross
                    crosses = append(crosses,'g')
                    print(paste0("golden cross at ", i))
                }
                else{
                    crosses= append(crosses, NA)
                }
            }
        }
    }
    return (crosses)
}
# 
# data = getCorrectData(tickerName)
# crosses = detectCross(data$sortedStockData$AAPL.Close.SMA50, data$sortedStockData$AAPL.Close.SMA200)
# newdata = cbind(data$sortedStockData, crosses)