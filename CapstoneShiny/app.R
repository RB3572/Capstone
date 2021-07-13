#install.packages("shiny")
library(shiny)
source("ui.R")
source("server.R")
shinyApp(ui = ui, server = server)

library(rsconnect)
deployApp()
