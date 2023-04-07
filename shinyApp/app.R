# app.R

library(shiny)
library(shinydashboard)

#source("www/figures/gallonChartUS.R")
source("www/functions/MapFunction.R")
source("www/functions/PieChart.R")
source("www/functions/subsetFunctions.R")
source("www/functions/Radar.R")


#ui
ui <- dashboardPage(skin = "red",
 
  dashboardHeader(title = "Alcohol Use"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home", tabName = "home"),
      menuItem("US & Regional", tabName = "maps"), 
      menuItem("Demographics", tabName = "demographics"), 
      menuItem("Effects & Outcomes", tabName = "effects"),
      menuItem("TEST", tabName = "test")
    )
  ),
  dashboardBody(
    tabItems(
      
####### First tab content###################################################
      
      tabItem(tabName = "home",
        h2("intro to dataset and problem"),
              #fluidRow(
                #box(plotOutput("plot1", height = 250)),
                
                #box(
                  #title = "Controls",
                  #sliderInput("slider", "Number of observations:", 1, 100, 50)
                #)
              #)
      ),
      
######## Second tab content################################################

      tabItem(tabName = "maps",
              h2("use map and regional data"), 
              
        # alcohol gallon consumption map
        fluidRow(
              box(
                title = "Gallons Consumed per Person per Year", status = "primary", solidHeader = TRUE,
                collapsible = TRUE,
                plotOutput("usPlot", height = 300))
              ),
        
        # region 
        fluidRow(
          selectInput("category", "Select a category: Region", c("West", "Midwest", "South", "Northeast")), 
          box(
            title = "Region", status = "primary", solidHeader = TRUE,
            collapsible = TRUE,
            plotOutput("regionChart", height = 300))
        )
      ), # Second page end
      
######## Third page##########################################################################
      tabItem(tabName = "demographics",
        h2("use subset data"),
        
        # education status
        fluidRow(
          selectInput("category1", "Select a category: Education", c("Less than a high school diploma", "High school or GED", "Some college", "Bachelors degree or higher")), 
          box(
            title = "Education", status = "primary", solidHeader = TRUE,
            collapsible = TRUE,
            plotOutput("EducationChart", height = 300))
        ),
        #Family income
        fluidRow(
          selectInput("category5", "Select a category: Family income", c("Less than $35,000", "$35,000–$49,999", "$50,000–$74,999", "$75,000–$99,999","$100,000 or more")), 
          box(
            title = "Family Income", status = "primary", solidHeader = TRUE,
            collapsible = TRUE,
            plotOutput("FamIncome", height = 300))
        ),
        #Marital
        fluidRow(
          selectInput("category6", "Select a category: Marital", c("Married", "Widowed", "Divorced or separated", "Never married","Living with a partner")), 
          box(
            title = "Marital", status = "primary", solidHeader = TRUE,
            collapsible = TRUE,
            plotOutput("Marital", height = 300))
        )
      ), 
      
######## Fouth page##########################################################################
      tabItem(tabName = "effects", 
        h2("use ARDI data"),
        
        # Create age pie chart
        fluidRow(
          selectInput("category2", "Select a category: Age", c("18-44", "45-64", "65-74", "75+")), 
          box(
            title = "Age", status = "primary", solidHeader = TRUE,
            collapsible = TRUE,
            plotOutput("AgeChart", height = 300))
        ),#Emp
        
        # Create employment status bar chart
        fluidRow(
          selectInput("category3", "Select a category", c("Employed", "Full-time", "Part-time", "Not employed but has worked previously","Not employed and has never worked")), 
          box(
            title = "Region", status = "primary", solidHeader = TRUE,
            collapsible = TRUE,
            plotOutput("Employee", height = 300))
          )
         ),
        
        # Create death cause pie chart
        #fluidRow(
         # selectInput("category4", "Select a category", c("Cause of Death", "Full-time", "Part-time", "Not employed but has worked previously","Not employed and has never worked")), 
          #box(
           # title = "Region", status = "primary", solidHeader = TRUE,
         #   collapsible = TRUE,
          #  plotOutput("Employee", height = 300))
        
######## TEST################################################################################################
        
        tabItem(tabName = "test", 
              h2("TEST"),
              
              # Radar
              fluidRow(
                column(width = 6,
                       selectInput("category_row1", "Alcohol Consumption", c("Current Regular", "Lifetime Abstainer", "Current Infrequent","Former Infrequent","Former Regular"), selected = "Current Regular")
                ),
                column(width = 6,
                       selectizeInput("category_col1", "Marital Status:", choices = c("Married", "Widowed", "Never married","Divorced or separated","Living with a partner"), multiple = TRUE, selected =c("Married", "Widowed", "Never married","Divorced or separated","Living with a partner"))
                ),
                column(width = 12,
                       plotOutput("MaritalR", height = 700)
                )
              )
        )# TEST tabItem

    ) # tabItems
  ) # dashboardBody
) # dashboardPage
######## Server ##########################################################

# Define server input and output
server <- function(input, output, session) {

  # Second page alcohol consumption map
  output$usPlot <- renderPlot({
    choropleth_map(alcoholByStateGallons, "alcoholConsumptionGallons", "darkgreen")
  })
  
  # Second page region pie chart
  output$regionChart <- renderPlot({
    createPieChart(subsetRegion, input$category)
  })
  
  # Third page education status pie chart
  output$EducationChart <- renderPlot({
    createPieChart(subsetEdu, input$category1)
  })
  
  # Third page Family income pie chart
  output$FamIncome <- renderPlot({
    chooseSub(subsetFamIncome, input$category5)
  })
  
  # Third page Marital pie chart
  output$Marital <- renderPlot({
    chooseSub(subsetMarital, input$category6)
  })
  

  # Fourth page age pie chart 
  output$AgeChart <- renderPlot({
    createPieChart(subsetAge, input$category2)
  })
  
  # Fourth page employment pie chart
  output$Employee <- renderPlot({
    chooseSub(subsetEmp, input$category3)
  })
  
  # Fourth page death cause
  #output$Employee <- renderPlot({
   # chooseSub(stateSubset, input$category4)
 ## })
  
  # Test page Marital radar
  output$MaritalR <- renderPlot({
    # Check if at least one row is selected
    if (length(input$category_row1) < 1) {
      return(validate(need("Select at least one row.", type = "error")))
    }
    
    # Check if at least three columns are selected
    if (length(input$category_col1) < 3) {
      return(validate(need("Select at least three columns.", type = "error")))
    }
    create_radarchart(
      subsetMarital, max_value = 72000, min_value = 500, 
      selected_rows = input$category_row1,
      selected_columns = input$category_col1
    )
  })
  
}

shinyApp(ui, server)