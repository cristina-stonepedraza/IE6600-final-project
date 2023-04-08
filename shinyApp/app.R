# app.R

library(shiny)
library(shinydashboard)

#source("www/figures/gallonChartUS.R")
source("www/functions/MapFunction.R")
source("www/functions/PieChart.R")
source("www/functions/subsetFunctions.R")
#source("www/functions/Radar.R")


#ui
ui <- dashboardPage(skin = "red",
 
  dashboardHeader(title = "Alcohol Use"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("US & Regional", tabName = "maps"), 
      menuItem("Demographics", tabName = "demographics"), 
      menuItem("Effects & Outcomes", tabName = "effects"),
      menuItem("TEST", tabName = "test")
    )
  ),
  dashboardBody(
    tabItems(
      
######## First tab content################################################

      tabItem(tabName = "maps",
              h2("U.S. Drinking Habits Overall and by Region 2"), 
              
        # alcohol gallon consumption map, region
        fluidRow(
              box(
                title = "Gallons Consumed per Person per Year", status = "danger", solidHeader = TRUE,
                collapsible = TRUE,
                plotOutput("usPlot", height = 300)), 
              
              # region pie chart
              selectInput("category", "Select a category: Region", c("West", "Midwest", "South", "Northeast")), 
              box(
                title = "Drinking Habits by U.S. Region", status = "warning", solidHeader = TRUE,
                collapsible = TRUE,
                plotOutput("regionChart", height = 300))
              ),
        
        fluidRow(     
               # region bar chart with frequency
              selectInput("category8", "Select a category: Drinking Frequency", c("Lifetime.Abstainer", "Former.Infrequent", "Former.Regular", "Current.Infrequent","Current.Regular")), 
              box(
                title = "Drinking Habits by U.S. Region", status = "warning", solidHeader = TRUE,
                collapsible = TRUE,
                plotOutput("regionChart2", height = 300))
              ),
        
        # region 
        #fluidRow(
          #selectInput("category", "Select a category: Region", c("West", "Midwest", "South", "Northeast")), 
          #box(
            #title = "Region", status = "warning", solidHeader = TRUE,
            #collapsible = TRUE,
            #plotOutput("regionChart", height = 300))
        #)
      ), # First page end
      
######## Second page##########################################################################
      tabItem(tabName = "demographics",
        h2("Drinking Habit Data by Demographic"),
        
        # Education bar chart
        fluidRow(
          selectInput("category1", "Select a category: Education", c("Less than a high school diploma", "High school or GED", "Some college", "Bachelors degree or higher")), 
          box(
            title = "Drinking Habits by Education Level", status = "primary", solidHeader = TRUE,
            collapsible = TRUE,
            plotOutput("EducationChart", height = 300))
        ),
        
        # Education pie chart
        fluidRow(
          selectInput("category7", "Select a category:Drinking Frequency", c("Lifetime.Abstainer", "Former.Infrequent", "Former.Regular", "Current.Infrequent","Current.Regular")), 
          box(
            title = "Drinking Habits by Education Level", status = "primary", solidHeader = TRUE,
            collapsible = TRUE,
            plotOutput("Education2", height = 300))
        ),
        
        #Family income bar chart 
        fluidRow(
          selectInput("category5", "Select a category: Family income", c("Less than $35,000", "$35,000–$49,999", "$50,000–$74,999", "$75,000–$99,999","$100,000 or more")), 
          box(
            title = "Drinking Habits by Family Income Level", status = "primary", solidHeader = TRUE,
            collapsible = TRUE,
            plotOutput("FamIncome", height = 300))
        ),
        
        # Family income pie chart 
        fluidRow(
          selectInput("category9", "Select a category: Drinking Frequency", c("Lifetime.Abstainer", "Former.Infrequent", "Former.Regular", "Current.Infrequent","Current.Regular")), 
          box(
            title = "Drinking Habits by Family Income", status = "primary", solidHeader = TRUE,
            collapsible = TRUE,
            plotOutput("FamIncome2", height = 300))
        ),
        
        #Marital bar chart
        fluidRow(
          selectInput("category6", "Select a category: Marital", c("Married", "Widowed", "Divorced or separated", "Never married","Living with a partner")), 
          box(
            title = "Drinking Habits by Marital Status", status = "primary", solidHeader = TRUE,
            collapsible = TRUE,
            plotOutput("Marital", height = 300))
        ),
        
        #Marital pie chart
        fluidRow(
          selectInput("category10", "Select a category: Drinking Frequency", c("Lifetime.Abstainer", "Former.Infrequent", "Former.Regular", "Current.Infrequent","Current.Regular")), 
          box(
            title = "Drinking Habits by Marital Status", status = "primary", solidHeader = TRUE,
            collapsible = TRUE,
            plotOutput("Marital2", height = 300))
        ),
        
        fluidRow(
          column(
            width = 6,
            # Age group pie chart
            selectInput("category2", "Select a category: Age", c("18-44", "45-64", "65-74", "75+")), 
            box(
              title = "Drinking Habits by Age Group", status = "success", solidHeader = TRUE,
              collapsible = TRUE,
              plotOutput(
                "AgeChart", 
                height = 300, 
                width = 600),
              width = 600
            )
          ),
          
          # Create employment status bar chart
          column(
            width = 6,
            selectInput("category3", "Select a category", c("Employed", "Full-time", "Part-time", "Not employed but has worked previously","Not employed and has never worked")), 
            box(
              title = "Region", 
              status = "info", 
              solidHeader = TRUE,
              collapsible = TRUE,
              plotOutput(
                "Employee", 
                height = 300,
                width = 600), 
              width = 600
            )
          )
        ),
        
        fluidRow(
          # Age group bar chart
          selectInput("category11", "Select a category: Drinking Frequency", c("Lifetime.Abstainer", "Former.Infrequent", "Former.Regular", "Current.Infrequent","Current.Regular")), 
          box(
            title = "Drinking Habits by Age Group", status = "primary", solidHeader = TRUE,
            collapsible = TRUE,
            plotOutput("Age2", height = 300)) 
        ),
        
        fluidRow(
          # Age group bar chart
          selectInput("category12", "Select a category: Drinking Frequency", c("Lifetime.Abstainer", "Former.Infrequent", "Former.Regular", "Current.Infrequent","Current.Regular")), 
          box(
            title = "Drinking Habits by Employment Status", status = "primary", solidHeader = TRUE,
            collapsible = TRUE,
            plotOutput("Employee2", height = 300)) 
        )
        
      ), 
      
######## Third page##########################################################################
      tabItem(tabName = "effects", 
        h2("Effects of Excessive Drinking in the U.S."),
        
        
      ),
      
######## TEST################################################################################################
        
        tabItem(tabName = "test", 
              h2("TEST"),
              #test info box
              # infoBoxes with fill=TRUE
              fluidRow(
                infoBox("New Orders", 10 * 2, icon = icon("credit-card"), fill = TRUE),
                infoBoxOutput("progressBox2"),
                infoBoxOutput("approvalBox2")
              ),
              fluidRow(
                # Clicking this will increment the progress amount
                box(width = 4, actionButton("count", "Increment progress"))
              ),
              # Radar
              fluidRow(
                column(width = 4,
                       selectInput("category_row1", "Alcohol Consumption", c("Current Regular", "Lifetime Abstainer", "Current Infrequent","Former Infrequent","Former Regular"), selected = "Current Regular")
                ),
                column(width = 4,
                       selectizeInput("category_col1", "Marital Status:", choices = c("Married", "Widowed", "Never married","Divorced or separated","Living with a partner"), multiple = TRUE, selected =c("Married", "Widowed", "Never married","Divorced or separated","Living with a partner"))
                #####you can choose mutiply choice by using multiple = TRUE
                       ),
                box(width = 6, collapsible = TRUE,
                       fluidRow(
                         valueBox(
                           "Married", "IDK how to put value on",
                           color = "yellow"
                         )
                       ),
                       plotOutput("MaritalR", height = 500)
                )
              )
        )# TEST tabItem

    ) # tabItems
  ) # dashboardBody
) # dashboardPage
######## Server ##########################################################

# Define server input and output
server <- function(input, output, session) {

  # First page alcohol consumption map
  output$usPlot <- renderPlot({
    choropleth_map(alcoholByStateGallons, "alcoholConsumptionGallons", "darkgreen")
  })
  
  # First page region pie chart
  output$regionChart <- renderPlot({
    createPieChart(subsetRegion, input$category)
  })
  
  # First page region bar chart
  output$regionChart2 <- renderPlot({
    chooseSub(subsetRegion_rotated, input$category8)
  })
  
  # Second page education status pie chart
  output$EducationChart <- renderPlot({
    chooseSub(subsetEdu, input$category1)
  })
  
  # Second page education with rotate dataframe
  output$Education2 <- renderPlot({
    createPieChart(subsetEdu_rotated, input$category7)
  })
  
  
  # Second page Family income pie chart
  output$FamIncome <- renderPlot({
    chooseSub(subsetFamIncome, input$category5)
  })
  
  # Second page Family income pie chart
  output$FamIncome2 <- renderPlot({
    createPieChart(subsetFamIncome_rotated, input$category9)
  })
  
  # Second page Marital pie chart
  output$Marital <- renderPlot({
    chooseSub(subsetMarital, input$category6)
  })
  
  # Second page Marital pie chart
  output$Marital2 <- renderPlot({
    createPieChart(subsetMarital_rotated, input$category10)
  })
  

  # Second Page age pie chart 
  output$AgeChart <- renderPlot({
    createPieChart(subsetAge, input$category2)
  })
  
  # Second Page Age bar chart 
  output$Age2 <- renderPlot({
    chooseSub(subsetAge_rotated, input$category11)
  })
  
  # Second page employment pie chart
  output$Employee <- renderPlot({
    chooseSub(subsetEmp, input$category3)
  })
  
  # Second page employment pie chart
  output$Employee2 <- renderPlot({
    chooseSub(subsetEmp_rotated, input$category12)
  })
  
  # Third page death cause
  #output$Employee <- renderPlot({
   # chooseSub(stateSubset, input$category4)
 ## })
  #Testing info box
  output$progressBox2 <- renderInfoBox({
    infoBox(
      "Progress", paste0(25 + input$count, "%"), icon = icon("list"),
      color = "purple", fill = TRUE
    )
  })
  output$approvalBox2 <- renderInfoBox({
    infoBox(
      "Approval", "80%", icon = icon("thumbs-up", lib = "glyphicon"),
      color = "yellow", fill = TRUE
    )
  })
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
