library(shiny)
shinyUI(fluidPage(
  headerPanel("plot the airqualitydata set"),
  sidebarPanel(selectInput("X_axis", "X axis:",list("Ozone"="Ozone","Solar.R"="Solar.R"))),
  plotOutput("airPlot")
  ))