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
                value = 50)
)

StockReturn_panel <- tabPanel(
    "Stock Return RNN",
    titlePanel("Graphs"),
    sidebarLayout(
        StockReturn_content, ReturnSelector_content
    )
)
GoldenCross_content <- mainPanel(
    plotOutput("GoldenCrossPlot"),
)

GoldenSelector_content <- sidebarPanel(
    # selectInput(
    #     "ticker",
    #     label = "Stocks",
    #     choices = c("AAPL","AMZN","RTX"),
    #     selected = "Speed"
    # )
    textInput(
        inputId = "GoldenTicker",
        label = "Ticker to analyze",
        placeholder = "Input a ticker",
        value = "AAPL"
    ),
    sliderInput("GoldenEpochs",
                "Epochs",
                min = 50,
                max = 1000,
                value = 100)
)
goldenCross_panel <- tabPanel(
    "Golden Cross RNN",
    titlePanel("Graphs"),
    sidebarLayout(
        GoldenCross_content, GoldenSelector_content
    )
)

ui <- navbarPage(
    "Stock Prediction Using RNN and Return Prices",
    
    StockReturn_panel,
    goldenCross_panel
)
