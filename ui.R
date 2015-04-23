<<<<<<< HEAD
#server.R

library(plyr)
library(ggplot2)
source("helper_functions.R")
source("data/example_frequencies.R")

shinyServer(function(input, output) {
  
  output$text <- renderText({
    paste("Original text:", input$text1)
  })
  
  output$freqplot <- renderPlot({
    ref <- switch(input$ref,"English literature classics" = classics,
                  "Oxford dictionary" = oxford,
                  "None" = "None")
    
    fplot(input$text1,ref)
  })
  
  
})
=======
library(shiny)
library(ggplot2)
load("data/genre_data.Rdata")

CheckBoxButton <- function(inputId, class, text) {
  tagList(
    singleton(tags$head(tags$script(src = "js/checkall.js"))),
    singleton(tags$head(tags$script(src = "js/uncheckall.js"))),
    tags$button(id = inputId,
                class = paste(class,"btn"),
                type = "button",
                text)
  )
}

shinyUI(
  fluidPage(
    titlePanel("Books Analysis"),
    sidebarPanel(
      dateRangeInput('daterange',
                     label = 'Select Dates To Analyze:',
                     start = "2006-10-02", end = "2014-02-05"),
      CheckBoxButton("CheckAllBtn", "checkall", "Check All"),
      CheckBoxButton("UnCheckAllBtn", "uncheckall", "Uncheck All"),
      checkboxGroupInput("genres", "Genres:", 
                         sort(unique(genre.data$genre)), 
                         selected=c("science fiction","fantasy","horror"))
    ),
    mainPanel(
      width=9,
      plotOutput("plot")
    )
  ))
>>>>>>> origin/master
