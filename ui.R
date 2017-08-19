#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
library(shinythemes)


# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = shinytheme("flatly"), title = "Country GDP Stats", 
  verticalLayout(
  wellPanel(
    fluidRow(
      column(width=4,
             selectInput("source", label=h4("Statistic"),
                         choices = statisticList, 
                         selected = "GDP.Per.Capita"), 
             helpText(paste("Select a statistic to display on the map. The countries on the map will be colored by that statistic. ",
                            "Please allow some time for the map to render."))),
      column(width=4,
             selectInput("pal", label=h4("Map Colors"), 
                           choices = list("Brown/Green" = "BrBG", 
                                          "Pink/Yellow/Green" =  "PiYG", 
                                          "Purple/Red/Green" = "PRGn", 
                                          "Purple/Orange" = "PuOr", 
                                          "Red/Blue" = "RdBu",
                                          "Red/Gray" = "RdGy", 
                                          "Red/Yellow/Blue" = "RdYlBu",
                                          "Red/Yellow/Green" = "RdYlGn", 
                                          "Spectral", 
                                          "Blues", 
                                          "Blue/Green" = "BuGn", 
                                          "Blue/Purple" = "BuPu", 
                                          "Green/Blue" = "GnBu", 
                                          "Greens", 
                                          "Greys", 
                                          "Oranges", 
                                          "Orange/Red" = "OrRd", 
                                          "Purple/Blue" = "PuBu", 
                                          "Purple/Blue/Green" = "PuBuGn", 
                                          "Purple/Red" = "PuRd", 
                                          "Red/Purple" = "RdPu", 
                                          "Reds", 
                                          "Yellow/Green" = "YlGn", 
                                          "Yellow/Green/Blue" = "YlGnBu", 
                                          "Yellow/Orange/Brown" = "YlOrBr", 
                                          "Yellow/Red" = "YlOrRd"
                           ),
                           selected = "Spectral"),
             helpText("The color schema to use for the map")),
      column(width=4,
             radioButtons("mode", label = h4("Mode"),
                          choices = list("Absolute" = 1, "Quantile" = 2),
                          selected = 2),
             helpText("Absolute - uses the actual values of the statistic. Quantile - colors the countries by which quantile they are in for that statistic.")))),
  fluidRow(
    column(12, 
           leafletOutput("chartData"))),
  fluidRow(
    column(12, 
           tableOutput("dataTable"))))))
