list.of.packages <- c("shiny", "leaflet", "shinythemes", "rgdal")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
lapply(list.of.packages,function(x){library(x,character.only=TRUE)}) 

library(rgdal)

countryData <- readOGR(dsn = "countries", layer = "ne_50m_admin_0_countries", encoding = "UTF-8")
data <- read.csv("data/gdp.csv", header=TRUE, quote = "", stringsAsFactors = F)
names(data)[1] <- "Country"

statisticList <- list("GDP" = "GDP", 
                      "GDP Per Capita" = "GDP.Per.Capita", 
                      "GDP Share" = "GDP.Share", 
                      "GDP Rank" = "GDP.Rank", 
                      "GDP PPP" = "GDP.PPP", 
                      "GDP PPP Share" = "GDP.PPP.Share", 
                      "GDP PPP Rank" = "GDP.PPP.Rank")