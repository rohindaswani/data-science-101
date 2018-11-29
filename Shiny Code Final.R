# Build data into Shiny plot


library(ggplot2)
library(shiny)
library(plotly)


cancer = cancer

View(cancer)

data(cancer)
nms <- names(cancer)

ui <- fluidPage(
  
  headerPanel("Cancer"),
  sidebarPanel(
    sliderInput('sampleSize', 'Sample Size', min = 1, max = nrow(cancer),
                value = 5000, step = 1000, round = 0),
    selectInput('x', 'X', choices = nms, selected = "clumpThickness"),
    selectInput('y', 'Y', choices = nms, selected = "class"),
    selectInput('color', 'Color', choices = nms, selected = "cellSize"),
    
    selectInput('facet_row', 'Facet Row', c(None = '.', nms), selected = "cellSize"),
    selectInput('facet_col', 'Facet Column', c(None = '.', nms)),
    sliderInput('plotHeight', 'Height of plot (in pixels)', 
                min = 100, max = 2000, value = 1000)
  ),
  mainPanel(
    plotlyOutput('trendPlot', height = "900px")
  )
)

server <- function(input, output) {
  
  #add reactive data information. Dataset = built in supply data
  dataset <- reactive({
    cancer[sample(nrow(cancer), input$sampleSize),]
  })
  
  output$trendPlot <- renderPlotly({
    
    # build graph with ggplot syntax
    
    
    #fac <- with(supply, reorder(supply$name, supply$dollar, mean, order = TRUE))
    #supply$name <- factor(supply$name, levels = levels(fac))
    
    #p <- ggplot(dataset(), aes_string(x = input$x, y = input$y, color = input$color)) + 
    #geom_boxplot() + theme(axis.text.x=element_text(size=6,angle=90))

    p <- ggplot(cancer, aes_string(input$x, input$y, color = input$color)) + 
      geom_boxplot() + xlab(input$x) + ylab(input$y)
    
    #p <- ggplot(dataset(), aes_string(x = input$x, y = input$y, color = input$color)) + 
    #geom_boxplot() + theme(axis.text.x=element_text(size=6,angle=90))
    
    
    # if at least one facet column/row is specified, add it
    facets <- paste(input$facet_row, '~', input$facet_col)
    if (facets != '. ~ .') p <- p + facet_grid(facets)
    
    ggplotly(p) %>% 
      layout(height = input$plotHeight)
    
  })
  
}

shinyApp(ui, server)
