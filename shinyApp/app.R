# app.R

library(shiny)
library(shinydashboard)

#source("www/figures/gallonChartUS.R")
source("www/functions/MapFunction.R")
source("www/functions/PieChart.R")
source("www/functions/subsetFunctions.R")


ui <- dashboardPage(
  dashboardHeader(title = "Alcohol Use"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home", tabName = "home"),
      menuItem("US & Regional", tabName = "maps"), 
      menuItem("Demographics", tabName = "demographics"), 
      menuItem("Effects & Outcomes", tabName = "effects")
    )
  ),
  dashboardBody(
    tabItems(
      # First tab content
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
      
      # Second tab content
      tabItem(tabName = "maps",
              h2("use map and regional data"), 
        fluidRow(
              box(
                title = "Gallons Consumed per Person per Year", status = "primary", solidHeader = TRUE,
                collapsible = TRUE,
                plotOutput("usPlot", height = 300))
              ),
        fluidRow(
          selectInput("category", "Select a category: Region", c("West", "Midwest", "South", "Northeast")), 
          box(
            title = "Region", status = "primary", solidHeader = TRUE,
            collapsible = TRUE,
            plotOutput("regionChart", height = 300))
        )
      ), # End
      #3
      tabItem(tabName = "demographics",
        h2("use subset data"),
        fluidRow(
          selectInput("category1", "Select a category: Education", c("Less than a high school diploma", "High school or GED", "Some college", "Bachelors degree or higher")), 
          box(
            title = "Education", status = "primary", solidHeader = TRUE,
            collapsible = TRUE,
            plotOutput("EducationChart", height = 300))
        )
      ), 
      #4
      tabItem(tabName = "effects", 
        h2("use ARDI data"),
        fluidRow(
          selectInput("category2", "Select a category: Age", c("18-44", "45-64", "65-74", "75+")), 
          box(
            title = "Age", status = "primary", solidHeader = TRUE,
            collapsible = TRUE,
            plotOutput("AgeChart", height = 300))
        ),#Emp
        fluidRow(
          selectInput("category3", "Select a category", c("Employed", "Full-time", "Part-time", "Not employed but has worked previously","Not employed and has never worked")), 
          box(
            title = "Region", status = "primary", solidHeader = TRUE,
            collapsible = TRUE,
            plotOutput("Employee", height = 300))
         )
      )
    )
  )
)

server <- function(input, output, session) {

  output$usPlot <- renderPlot({
    choropleth_map(alcoholByStateGallons, "alcoholConsumptionGallons", "darkgreen")
  })
  
  output$regionChart <- renderPlot({
    createPieChart(subsetRegion, input$category)
  })
  
  output$EducationChart <- renderPlot({
    createPieChart(subsetEdu, input$category1)
  })
  output$AgeChart <- renderPlot({
    createPieChart(subsetAge, input$category2)
  })
  output$Employee <- renderPlot({
    chooseSub(subsetEmp, input$category3)
  })
}

shinyApp(ui, server)