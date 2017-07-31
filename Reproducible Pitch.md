Reproducible Pitch
========================================================
author: Farhan Atiq
date: 7/31/2017
autosize: true

Goal of this presentation 
========================================================

  For this project we are trying to examine the GDP per capita of each country to consolidate at a regional level
  Data is transformed and taken from world bank repositories. Source : data.worldbank.org/
  The Shiny app is uploaded here https://farhanatiq.shinyapps.io/data_product_assigment
  The Source code can be found at github here https://github.com/farhanatiq/ShinyApp
  
  The data set consists of GDP per capita by country from 2000 - 2015
  
  


Code Explaination - Global.r
========================================================

The code below is loading the data which would be common to both server and UI


```r
data <- read.csv(file='GDP.csv', header=TRUE)
data$Region <- as.factor(data$Region)
```

UI.R
========================================================


```r
library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("GDP per capita by Region"),

  # Sidebar with a slider input year
  sidebarLayout(
    sidebarPanel(
      selectInput("Region","Please select region",
                  choices=c("South Asia","Europe & Central Asia","Middle East & North Africa","East Asia & Pacific","Sub-Saharan Africa"
                            ,"Latin America & Caribbean","North America"))
                  
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
    
  )
  ))
```

<!--html_preserve--><div class="container-fluid">
<h2>GDP per capita by Region</h2>
<div class="row">
<div class="col-sm-4">
<form class="well">
<div class="form-group shiny-input-container">
<label class="control-label" for="Region">Please select region</label>
<div>
<select id="Region"><option value="South Asia" selected>South Asia</option>
<option value="Europe &amp; Central Asia">Europe &amp; Central Asia</option>
<option value="Middle East &amp; North Africa">Middle East &amp; North Africa</option>
<option value="East Asia &amp; Pacific">East Asia &amp; Pacific</option>
<option value="Sub-Saharan Africa">Sub-Saharan Africa</option>
<option value="Latin America &amp; Caribbean">Latin America &amp; Caribbean</option>
<option value="North America">North America</option></select>
<script type="application/json" data-for="Region" data-nonempty="">{}</script>
</div>
</div>
</form>
</div>
<div class="col-sm-8">
<div id="distPlot" class="shiny-plot-output" style="width: 100% ; height: 400px"></div>
</div>
</div>
</div><!--/html_preserve-->

Server.R
========================================================

Making use of ggplot to plot the graph,
sqldf to group and sum at a regional level


```r
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
```
