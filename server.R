#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  chartData <- reactive({
    dat <- data.frame(Country = data[,"Country"], value = data[,input$source])
    merge(countryData, dat, by.x="name_long", by.y="Country")
  })
  
  output$chartData <- renderLeaflet({
    data <- chartData()
    
    if(input$mode == 1){
      pal <- colorBin(palette = input$pal, domain = data$value, n=9)
    }
    else {
      pal <- colorQuantile(palette = input$pal, domain = data$value, n=9)
    }
    
    withProgress(
      message = "Generating Map", value=0,
      leaflet(data = data) %>%
        setView(lat=25, lng=0, zoom = 1.82) %>%
        addTiles() %>% 
        addPolygons(fillColor = ~pal(value), weight = 1, color="white", fillOpacity = 0.7, opacity = 1) %>%
        addLegend(pal = pal, values = ~value, opacity = 0.7, title = NULL,  position = "bottomleft"))
  })
  
  output$dataTable <- renderTable({
    dat <- data.frame(Country = data[,"Country"], data[,input$source])
    title <- names(statisticList)[which(statisticList == input$source)[[1]]]
    names(dat)[2] <- input$source
    ordered <- dat[order(-dat[,input$source]),]
    names(ordered)[2] <- title
    last <- nrow(ordered) - c(9:0)
    cbind('#' = 1:10, ordered[1:10,],
          '#' = 11:20, ordered[11:20,],
          '#' = last, ordered[last,])
    
    }, 
    width="100%", digits=0, striped = T)
})
