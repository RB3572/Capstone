StockReturn_content <- mainPanel(
    plotOutput("ReturnPlot"),
    textOutput("bugcheck")
)

ReturnSelector_content <- sidebarPanel(
    # selectInput(
    #     "ticker",
    #     label = "Stocks",
    #     choices = c("AAPL","AMZN","RTX"),
    #     selected = "Speed"
    # )
    textInput(
        inputId = "ReturnTicker",
        label = "Ticker to analyze",
        placeholder = "Input a ticker",
        value = "AAPL"
    ),
    sliderInput("ReturnEpochs",
                "Epochs",
                min = 5,
                max = 100,
                value = 50),
    sliderInput("ReturnScaling",
                "Scaling Factor",
                min = 1,
                max = 25,
                value = 10)
)

StockReturn_panel <- tabPanel(
    "Stock Return RNN",
    titlePanel("Graphs"),
    sidebarLayout(
        StockReturn_content, ReturnSelector_content
    )
)

Price_content <- mainPanel(
    plotOutput("PricePlot"),
)

PriceSelector_content <- sidebarPanel(
    # selectInput(
    #     "ticker",
    #     label = "Stocks",
    #     choices = c("AAPL","AMZN","RTX"),
    #     selected = "Speed"
    # )
    textInput(
        inputId = "PriceTicker",
        label = "Ticker to analyze",
        placeholder = "Input a ticker",
        value = "AAPL"
    ),
    sliderInput("PriceEpochs",
                "Epochs",
                min = 50,
                max = 1000,
                value = 100)
)

Price_panel <- tabPanel(
    "Price RNN",
    titlePanel("Graphs"),
    sidebarLayout(
        Price_content, PriceSelector_content
    )
)

ui <- navbarPage(
    "Stock Prediction Using RNN and Return Prices",
    
    StockReturn_panel,
    Price_panel
)
