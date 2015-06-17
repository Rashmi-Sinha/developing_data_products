
library(shiny)
<<<<<<< HEAD
library(datasets)

# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {
  
  # By declaring databaseInput as a reactive expression we ensure that:
  #
  #  1) It is only called when the inputs it depends on changes
  #  2) The computation and result are shared by all the callers (it 
  #     only executes a single time)
  #
  datasetInput <- reactive({
    switch(input$dataset,
           "faithful" = faithful,
           "trees" = trees,
           "iris" = iris)
  })
  
  # The output$caption is computed based on a reactive expression that
  # returns input$caption. When the user changes the "caption" field:
  #
  #  1) This function is automatically called to recompute the output 
  #  2) The new caption is pushed back to the browser for re-display
  # 
  # Note that because the data-oriented reactive expressions below don't 
  # depend on input$caption, those expressions are NOT called when 
  # input$caption changes.
  output$caption <- renderText({
    input$caption
  })
  
  # The output$summary depends on the datasetInput reactive expression, 
  # so will be re-executed whenever datasetInput is invalidated
  # (i.e. whenever the input$dataset changes)
  output$summary <- renderPrint({
    dataset <- datasetInput()
    summary(dataset)
  })
  
  
  # The output$pairplot depends on the datasetInput reactive expression, 
  # so will be re-executed whenever datasetInput is invalidated
  # (i.e. whenever the input$dataset changes)
  output$pairplot <- renderPlot({
    dataset <- datasetInput()
    pairs(dataset)
  })
  
  
  # The output$view depends on both the databaseInput reactive expression
  # and input$obs, so will be re-executed whenever input$dataset or 
  # input$obs is changed. 
     output$view <- renderTable({
    head(datasetInput(), n = input$obs)
    
    })
  })
=======
library(ggplot2)
library(lubridate)
library(dplyr)
source("helpers.R")
load("data/genre_data.Rdata")

shinyServer(function(input, output) {
  output$plot <- renderPlot({
    validate(need(input$genres > 0, "Please select at least one genre"))
    start <- as.Date(input$daterange[1])
    end <- as.Date(input$daterange[2])
    selected.data <- subset(genre.data, 
                            genre %in% input$genres & dateadded <= end & dateadded >= start)
    if (MonthsInRange(input$daterange) > 12) {
      selected.data$usedates <- selected.data$monthadded
    } else {
      selected.data$usedates <- selected.data$dateadded
    }
    
    by_genre_and_date <- selected.data %.%
      group_by(genre, usedates) %.%
      summarise(counts=n())
    p <- ggplot(by_genre_and_date, aes(x=usedates, y=counts, color=genre, group=genre))
    l <- p + xlab("Date Added")+ylab("Number Added")+ggtitle("Genre Popularity Over Time")
    t <- l + theme(plot.title = element_text(lineheight=40, size=20, face="bold", vjust=1),
                   axis.title = element_text(size=17),
                   axis.text = element_text(size=15))
    print(t + geom_line())
  }, height=600, width=950)  
})
>>>>>>> origin/master
