server <- function(input, output) {
    output$ReturnPlot <- renderPlot({
        source("../Scripts/src/returns-rnn.R")
        returnsRNN(ticker = input$ReturnTicker, epochs = input$ReturnEpochs, modelPath = "../Scripts/src/keras-nn-regressor.R")
    })
    
    output$PricePlot <- renderPlot({
        source("../Scripts/src/price-rnn.R")
        priceRNN(ticker = input$PriceTicker, epochs = input$PriceEpochs, modelPath = "../Scripts/src/keras-nn-regressor.R")
    })
}