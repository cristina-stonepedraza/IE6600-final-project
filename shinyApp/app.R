library(DT)
library(shiny)
library(tidyverse)

# call out functions
source("/Users/cherryj./Desktop/IE6600-Computation and Visualization for Analytics/Project/IE6600-final-project/shinyApp/www/functions/AgeGroup.R")
source("/Users/cherryj./Desktop/IE6600-Computation and Visualization for Analytics/Project/IE6600-final-project/shinyApp/www/functions/statePlot.R")
source("/Users/cherryj./Desktop/IE6600-Computation and Visualization for Analytics/Project/IE6600-final-project/shinyApp/www/functions/MapFunction.R")
source("/Users/cherryj./Desktop/IE6600-Computation and Visualization for Analytics/Project/IE6600-final-project/shinyApp/www/functions/PieChart.R")
source("/Users/cherryj./Desktop/IE6600-Computation and Visualization for Analytics/Project/IE6600-final-project/shinyApp/www/functions/subsetFunction.R")

# ui design ----
ui <- fluidPage(titlePanel("IE6600-Final Project-Team2"),
                sidebarLayout(
                  sidebarPanel(
                    # set up the width of sidebar panel ----
                    width = 2,
                    
                    # dropdown widget ----
                    selectInput(
                      width = "100%",
                      inputId = "dbList1",
                      label = "Default Dataset List",
                      choices = c(choose = "List of data frame...",
                                  "mpg", "diamonds", "msleep"),
                      selectize = FALSE
                    ),
                    
                    # dropdown widget ----
                    uiOutput("obs1"),
                    
                    # reset button ----
                    actionButton(
                      inputId = "reset",
                      label = "Reset Data",
                      icon = icon("refresh"),
                      width = "100%"
                    ),
                    # test ----
                    verbatimTextOutput("aaa")
                  ),
                  mainPanel(fluidPage(fluidRow(
                    column(6,
                           # output the data table ----
                           DT::dataTableOutput("dataSet")),
                    column(6,
                           # output the plot ----
                           plotOutput(
                             "plotChart",
                             width = "100%",
                             height = "300px"
                           ))
                  )))
                ))

server <- function(input, output) {
  # create reactive values ----
  values <- reactiveValues(tbl = NULL,
                           obsList = NULL,
                           plot.df = NULL)
  
  # reactive event ----
  observeEvent(input$dbList1, {
    if (!NA %in% match(input$dbList1, c("mpg", "diamonds", "msleep"))) {
      values$tbl <- as.data.frame(get(input$dbList1))
      values$obsList <- colnames(values$tbl)
      
      output$obs1 <- renderUI({
        selectInput(
          inputId = "observationInput1",
          label = "1st observation",
          choices =  values$obsList
        )
      })
    }
  })
  
  # reactive event ----
  observeEvent(input$observationInput1, {
    values$plot.df <-
      as.data.frame(values$tbl[, input$observationInput1])
    colnames(values$plot.df) <- input$observationInput1
    output$dataSet <- DT::renderDataTable({
      values$tbl
    },
    extensions = c('Scroller', 'FixedColumns'),
    options = list(
      deferRender = TRUE,
      scrollX = TRUE,
      scrollY = 200,
      scroller = TRUE,
      dom = 'Bfrtip',
      fixedColumns = TRUE
    ))
  })
  
  observe({
    output$plotChart <- renderPlot({
      shiny::validate(need(values$tbl, ""))
      chartCol(values$plot.df, colnames(values$plot.df))
    })
  })
  
  observeEvent(input$reset, {
    values$tbl <- NULL
    output$obs1 <- NULL
  })
  
  output$aaa <- renderPrint({
    values$obsList
  })
}

shinyApp(ui, server)

#################################
# Problem 3

# Source helper functions -----
source("www/functions/switch_chart.R")


ui <- fluidPage(titlePanel("hw5 - IE6600"),
                sidebarLayout(
                  sidebarPanel(
                    width = 2,
                    selectInput(
                      width = "100%",
                      inputId = "dbList1",
                      label = "Default Dataset List",
                      choices = c(choose = "List of data frame...",
                                  "mpg", "diamonds", "msleep"),
                      selectize = FALSE
                    ),
                    uiOutput("obs1"),
                    uiOutput("bins"),
                    actionButton(
                      inputId = "reset",
                      label = "Reset Data",
                      icon = icon("refresh"),
                      width = "100%"
                    ),
                    verbatimTextOutput("aaa")
                  ),
                  mainPanel(fluidPage(fluidRow(
                    column(6,
                           DT::dataTableOutput("dataSet")),
                    column(6,
                           plotOutput(
                             "plotChart",
                             width = "100%",
                             height = "300px"
                           ))
                  )))
                ))

server <- function(input, output) {
  values <- reactiveValues(
    tbl = NULL,
    obsList = NULL,
    plot.df = NULL,
    bins = NULL
  )
  
  observeEvent(input$dbList1, {
    if (!NA %in% match(input$dbList1, c("mpg", "diamonds", "msleep"))) {
      values$tbl <- as.data.frame(get(input$dbList1))
      values$obsList <- colnames(values$tbl)
      output$obs1 <- renderUI({
        selectInput(
          inputId = "observationInput1",
          label = "1st observation",
          choices =  values$obsList
        )
      })
    }
  })
  
  observeEvent(input$observationInput1, {
    values$plot.df <-
      as.data.frame(values$tbl[, input$observationInput1])
    colnames(values$plot.df) <- input$observationInput1
    output$dataSet <- DT::renderDataTable({
      values$tbl
    },
    extensions = c('Scroller', 'FixedColumns'),
    options = list(
      deferRender = TRUE,
      scrollX = TRUE,
      scrollY = 200,
      scroller = TRUE,
      dom = 'Bfrtip',
      fixedColumns = TRUE
    ))
    
    if (is.numeric(values$tbl[, input$observationInput1])) {
      output$bins <- renderUI({
        sliderInput(
          inputId = "bins",
          label = "Number of bins:",
          min = 1,
          max = 50,
          value = 30
        )
      })
    } else{
      output$bins <- NULL
    }
    
  })
  observe({
    values$bins <- input$bins
    output$plotChart <- renderPlot({
      shiny::validate(need(values$tbl, ""))
      switch_chart(values$plot.df , colnames(values$plot.df), b = values$bins)
    })
  })
  
  observeEvent(input$reset, {
    values$tbl <- NULL
    output$obs1 <- NULL
  })
  
  output$aaa <- renderPrint({
    values$bins
  })
}

shinyApp(ui, server)