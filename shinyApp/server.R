server <- function(input, output) {
  # Reactive values ----
  values <- reactiveValues(tbl = NULL,
                           obsList = NULL,
                           plot.df = NULL,
                           # For feature BIN ----
                           bins = NULL)
  
  # Observe any updates from the dataset selection ----
  observeEvent(input$dbList1, {
    # Function IF will prevent to show error/warning messages on the blank screen ----
    if (!NA %in% match(input$dbList1, c("mpg", "diamonds", "msleep"))) {
      # Make selected dataset data.frame ---- 
      values$tbl <- as.data.frame(get(input$dbList1))
      # Save column names to obsList ----
      values$obsList <- colnames(values$tbl)
      # UI output for 1st observation ----
      output$obs1 <- renderUI({
        selectInput(
          inputId = "observationInput1",
          label = "1st observation",
          choices =  values$obsList
        )
      })
    }
  })
  
  # Observe the updates of the selected columns ----
  observeEvent(input$observationInput1, {
    # Save the selected column/s to values$plot.df ----
    values$plot.df <-
      as.data.frame(values$tbl[, input$observationInput1])
    # Save column names ----
    colnames(values$plot.df) <- input$observationInput1
    # Render output data table ----
    output$dataSet <- DT::renderDataTable({
      values$tbl
    },
    # Default settings for DT::renderDataTable{()} ----
    extensions = c('Scroller', 'FixedColumns'),
    options = list(
      deferRender = TRUE,
      scrollX = TRUE,
      scrollY = 200,
      scroller = TRUE,
      dom = 'Bfrtip',
      fixedColumns = TRUE
    ))
    
    # TODO 
    # Problem 3: You may insert an if else statement to control 
    # if the BIN widget should be appeared
    ## your code here ##
    
    
    
  })
  
  # Output chart types using created function switch_chart()
  observe({
    # TODO 
    # Problem 3: Store input$bins to reactive value
    # You may ignore this for Problem 2
    ## your code here ##
    
    # TODO 
    # Problem 2: Complete the output settings with switch_chart() here
    # hint: values$plot.df is the data frame should be processed in switch_chart()
    output$plotChart <- 
      ## your code here ##
      
  })
  
  
  
  # Widget RESET ----
  # hint: set widget to NULL, then widget will disappear ----
  observeEvent(input$reset, {
    values$tbl <- NULL
    output$obs1 <- NULL
  })
  
  # Widget for DEBUG any specific values, default is the obs1 ----
  # You may comment it up ----
  output$aaa <- renderPrint({
    values$obs1
  })
}