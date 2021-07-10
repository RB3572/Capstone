findIndex <- function(
    stockArray,
    colOrder,
    col,
    ticker
) {
    return(length(stockArray) * (which(colOrder == col) - 1) + which(stockArray == ticker))
}