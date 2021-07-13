
sidebar_content <- sidebarPanel(
    selectInput(
        "ticker",
        label = "Stocks",
        choices = c("AAPL","AMZN","RTX"),
        selected = "Speed"
    )
)

main_content <- mainPanel(
    plotOutput("plot")
)

ui <- navbarPage(
    "Stock Prediction Using RNN and Return Prices",
    
    second_panel
)
