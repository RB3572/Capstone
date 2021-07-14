server <- function(input, output) {
    output$ReturnPlot <- renderPlot({
        source("../Scripts/src/returns-rnn.R")
        returnsRNN(ticker = input$ReturnTicker, epochs = input$ReturnEpochs, scriptsPath = "../Scripts", scalingFactor = input$ReturnScaling)
    })
    
    output$PricePlot <- renderPlot({
        source("../Scripts/src/price-rnn.R")
        priceRNN(ticker = input$PriceTicker, epochs = input$PriceEpochs, scriptsPath = "../Scripts")
    })
}