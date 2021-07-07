library(quantmod)
library(TTR)

#getting data
tickers = "AMZN"

getSymbols(tickers)
head(AMZN)
dim(AMZN)
AMZN[3651,1]
s = 1
x = 3650
plot(AMZN[s:(s+x), 1], type = "l", col = 7, pch="o",
     main = "AMZN Opening, High, Low, Closing, and Adjusted Prices",
     ylab = " Price",
     xlab = "Date", 
     lty=1)
lines(AMZN[s:(s+x), 2], type = "l", col = 2, lty=1)
lines(AMZN[s:(s+x), 3], type = "l", col = 3, lty=1)
lines(AMZN[s:(s+x), 4], type = "l", col = 4, lty=1)
lines(AMZN[s:(s+x), 5], type = "l", col = 5, lty=1)
lines(AMZN[s:(s+x), 6], type = "l", col = 6, lty=1)
