library(shiny)
library(ggplot2)
library(datasets)
shinyServer(function(input, output) {output$airPlot<-reactivePlot(function() {# body of the function# print(plot)})})