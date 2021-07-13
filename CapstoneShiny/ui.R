intro_panel <- tabPanel(
    "Golden Cross RNN",
    
    titlePanel("Graphs"),
    
    
)
second_panel <- tabPanel(
    "[Tab Title]",
    titlePanel("[Page Title]"),
    sidebarLayout(
        sidebar_content, main_content
    )
)
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
