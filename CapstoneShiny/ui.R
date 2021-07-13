intro_panel <- tabPanel(
    "Golden Cross RNN",
    titlePanel("Graphs"),
)

main_content <- mainPanel(
    plotOutput("plot")
)

sidebar_content <- sidebarPanel(
    selectInput(
        "ticker",
        label = "Stocks",
        choices = c("AAPL","AMZN","RTX"),
        selected = "Speed"
    )
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
