intro_panel <- tabPanel(
    "Golden Cross RNN",
    titlePanel("Graphs"),
)

main_content <- mainPanel(
    plotOutput("plot"),
    textOutput("bugcheck")
)

sidebar_content <- sidebarPanel(
    # selectInput(
    #     "ticker",
    #     label = "Stocks",
    #     choices = c("AAPL","AMZN","RTX"),
    #     selected = "Speed"
    # )
    textInput(
        inputId = "ticker",
        label = "Ticker to analyze",
        placeholder = "Input a ticker",
        value = "AAPL"
    ),
    sliderInput("epochs",
                "Epochs",
                min = 5,
                max = 100,
                value = 50)
)

second_panel <- tabPanel(
    "Stock Return RNN",
    titlePanel("Graphs"),
    sidebarLayout(
        sidebar_content, main_content
    )
)

ui <- navbarPage(
    "Stock Prediction Using RNN and Return Prices",
    
    second_panel
)
