
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(dplyr)
library(sqldf)
library(ggplot2)


shinyServer(function(input, output) {

  output$distPlot <- renderPlot({
    
  R  <- input$Region
  Y  <- input$Year
    
  df <- sqldf('SELECT Region,Year, SUM(cast(GDP as numeric(18,2))) AS GDP, SUM(Life) AS Life FROM data 
              GROUP BY Region,Year')
  
  GRP <- df %>%
    filter(Region == input$Region) %>%
    select(Year,GDP,Life) 

  ggplot(data = GRP, aes(x = Year, y = GDP )) + geom_line() + geom_point()
#  ggplot(data = GRP, aes(x = Year, y = Life )) + geom_line() + geom_point()
  

  })

  
})
