# app.R

library(shiny)
library(shinydashboard)
library(shinyBS)
# Use functions from www/functions
#source("www/figures/gallonChartUS.R")
source("www/functions/MapFunction.R")
source("www/functions/PieChart.R")
source("www/functions/subsetFunctions.R")
source("www/functions/regionHabits.R")
source("www/functions/eduHabits.R")
source("www/functions/maritalHabits.R")
source("www/functions/empHabits.R")
source("www/functions/incomeHabits.R")
source("www/functions/ageHabits.R")
#source("www/functions/Radar.R")
source("www/functions/statePlot.R")
source("www/functions/ridgeline.R")
source("www/functions/multiLine.R")
addResourcePath("figures", "www/figures")

#ui
ui <- dashboardPage(skin = "red",
 
  dashboardHeader(title = "Alcohol Use"),
  dashboardSidebar(
    sidebarMenu(tags$img(src = "figures/bo2.jpg", height = "100px", width = "100%"),
      menuItem("HOME", tabName = "home", icon = icon("home")), 
      menuItem("US & Regional", tabName = "maps", icon = icon("globe")), 
      menuItem("Demographics", tabName = "demographics", icon = icon("users")), 
      menuItem("Effects & Outcomes", tabName = "effects", icon = icon("heartbeat")),
      menuItem("TEST", tabName = "test", icon = icon("cog"))
    )
  ),
  dashboardBody(
    tabItems(
      
######## First tab content################################################

      tabItem(tabName = "maps",
        h2("U.S. Drinking Habits Overall"), 
        # alcohol gallon consumption map Tab Box
        fluidRow(
          box(
            title = "Gallons Consumed per Person per Year", status = "danger", solidHeader = TRUE,
            collapsible = TRUE,
            tabBox(
              title = NULL,
              # The id lets us use input$tabset4 on the server to find the current tab
              id = "tabset4", height = "250px",
              # alcohol gallon consumption map, region
              tabPanel("Static US Map", "", 
                plotOutput("usPlot", height = 300, width = 1200)
              ),
              #new map
              tabPanel("Interactive US Map", "",
                plotlyOutput("interactive_map", height = 300, width = 1200)
              )
            ),
            width = 12,
            style = "margin-bottom: 250px;", # Move the next row down by 250px
          )
        ),
        
        # region pie chart 
        fluidRow(
          column(width = 6,
                 box(
                   title = "Drinking Habits by U.S. Region", status = "warning", solidHeader = TRUE,
                   selectInput("category", "Select a category: Region", c("West", "Midwest", "South", "Northeast")),
                   collapsible = TRUE,
                   plotOutput("regionChart", height = 300, width = 600),
                   width = 600
                 ) 
          ),
          column(width = 6,
            box(
              title = "U.S. Regional Frequency by Drinking Habit", status = "warning", solidHeader = TRUE,
              selectInput("category8", "Select a category: Drinking Frequency", c("Lifetime Abstainer", "Former Infrequent", "Former Regular", "Current Infrequent","Current Regular")), 
              collapsible = TRUE,
              plotOutput("regionChart2", height = 300, width = 600),
              width = 600
            )
          )
        )
      ), # First page end
      
######## Second page###########################################################################
      tabItem(tabName = "demographics",
        h2("Drinking Habit Data by Demographic"),
        
        #Education tab Box
        fluidRow(
          box(
            title = "Drinking Habits by Education Level", status = "primary", solidHeader = TRUE,
            collapsible = TRUE,
          column(width = 6,
          tabBox(
            title = NULL,
            # The id lets us use input$tabset1 on the server to find the current tab
            id = "tabset1", height = "500px",width = 600,
            # Education bar chart
            tabPanel("Status", " ", 
                     selectInput("category1", "Select a category: Education", c("Less than a high school diploma", "High school or GED", "Some college", "Bachelors degree or higher")),
                     plotOutput("EducationChart", height = 300, width = 600)
                     ),
            # Education bar chart2
            tabPanel("Frequency", " ",
                     selectInput("category7", "Select a category:Drinking Frequency", c("Lifetime Abstainer", "Former Infrequent", "Former Regular", "Current Infrequent","Current Regular")),
                     plotOutput("Education2", height = 300, width = 600)
                     )
          )
          )  
          ),

                    
          #Family income tab Box
          box(
            title = "Drinking Habits by Family Income Level", status = "success", solidHeader = TRUE,
            collapsible = TRUE,
          column(width = 6,
          tabBox(
            title = NULL, 
            # The id lets us use input$tabset2 on the server to find the current tab
            id = "tabset2", height = "250px",width = 600,
            # Family income bar chart
            tabPanel("Status", " ", 
                     selectInput("category5", "Select a category: Family income", c("Less than $35,000", "$35,000–$49,999", "$50,000–$74,999", "$75,000–$99,999","$100,000 or more")),
                     plotOutput("FamIncome", height = 300, width = 600)
            ),
            # Family income bar chart2
            tabPanel("Frequency", " ",
                     selectInput("category9", "Select a category: Drinking Frequency", c("Lifetime Abstainer", "Former Infrequent", "Former Regular", "Current Infrequent","Current Regular")),
                     plotOutput("FamIncome2", height = 300, width = 600)
            )
          ),
          style = "margin-bottom: 250px;", # Move the next row down by 250px
          )
          )
          ),
        
        #Age group tab Box
        fluidRow(
          box(
            title = "Drinking Habits by Age Group", status = "warning", solidHeader = TRUE,
            collapsible = TRUE,
            column(width = 6,
                   tabBox(
                     title = NULL,
                     # The id lets us use input$tabset5 on the server to find the current tab
                     id = "tabset5", height = "500px",width = 600,
                     # Age group pie chart
                     tabPanel("Status", " ", 
                              selectInput("category2", "Select a category: Age", c("18-44","45-64","65-74","75+")),
                              plotOutput("AgeChart", height = 300, width = 600)
                     ),
                     # Age group bar chart
                     tabPanel("Frequency", " ",
                              selectInput("category11", "Select a category: Drinking Frequency", c("Lifetime Abstainer", "Former Infrequent", "Former Regular", "Current Infrequent","Current Regular")),
                              plotOutput("Age2", height = 300, width = 600)
                     )
                   )
            )  
          ),
          
          
          #Employment tab Box
          box(
            title = "Drinking Habits by Employment Status", status = "danger", solidHeader = TRUE,
            collapsible = TRUE,
            column(width = 6,
                   tabBox(
                     title = NULL, 
                     # The id lets us use input$tabset6 on the server to find the current tab
                     id = "tabset6", height = "250px",width = 600,
                     # Employment status bar chart
                     tabPanel("Status", " ", 
                              selectInput("category3", "Select a category", c("Employed", "Full-time", "Part-time", "Not employed but has worked previously","Not employed and has never worked")), 
                              plotOutput("Employee", height = 300, width = 600)
                     ),
                     # Employment status bar chart
                     tabPanel("Frequency", " ",
                              selectInput("category12", "Select a category: Drinking Frequency", c("Lifetime Abstainer", "Former Infrequent", "Former Regular", "Current Infrequent","Current Regular")),
                              plotOutput("Employee2", height = 300, width = 600)
                     )
                   ),
                   style = "margin-bottom: 250px;", # Move the next row down by 250px
            )
          )
        ),
        
        #Marital tab box
        fluidRow(
          box(
            title = "Drinking Habits by Marital Status", status = "info", solidHeader = TRUE,
            collapsible = TRUE,
          tabBox(
            title = NULL,
            # The id lets us use input$tabset3 on the server to find the current tab
            id = "tabset3", height = "250px",
            #Marital bar chart
            tabPanel("Status", " ", 
                     selectInput("category6", "Select a category: Marital", c("Married", "Widowed", "Divorced or separated", "Never married","Living with a partner")),
                     plotOutput("Marital", height = 300, width = 600)
            ),
            #Marital bar chart2
            tabPanel("Frequency", " ",
                     selectInput("category10", "Select a category: Drinking Frequency",c("Lifetime Abstainer", "Former Infrequent", "Former Regular", "Current Infrequent","Current Regular")),
                     plotOutput("Marital2", height = 300, width = 600)
            )
          ),
          style = "margin-bottom: 250px;", # Move the next row down by 250px
          )
           ),


), #Second page end

######## Third page##########################################################################
      tabItem(tabName = "effects", 
        h2("Effects of Excessive Drinking in the U.S."),
        
        fluidRow(
          column(width = 6, 
            box(
              title = "Alcohol-Related Deaths Over Time", status = "primary", solidHeader = TRUE, 
              selectInput("chooseState3", "Select a state: ", c("Alabama", "Alaska","Arizona",
                                                                "Arkansas", "California","Colorado",
                                                                "Connecticut","Delaware","Florida",
                                                                "Georgia","Hawaii","Idaho", "Illinois", 
                                                                "Indiana","Iowa","Kansas","Kentucky",
                                                                "Louisiana","Maine","Maryland",
                                                                "Massachusetts","Michigan","Minnesota",
                                                                "Mississippi","Missouri",'Montana',
                                                                'Nebraska','Nevada','New Hampshire',
                                                                'New Jersey','New Mexico','New York',
                                                                'North Carolina','North Dakota','Ohio',
                                                                'Oklahoma','Oregon','Pennsylvania',
                                                                'Rhode Island','South Carolina',
                                                                'South Dakota','Tennessee','Texas','Utah',
                                                                'Vermont','Virginia','Washington',
                                                                'West Virginia','Wisconsin','Wyoming')),
              collapsible = TRUE, 
              plotOutput("lineCauses", height = 300, width = 600), 
              width = 600
            )
          ), 
          column(width = 6, 
            box(
              title = "Density for Causes of Alcohol-Related Deaths", status = "warning", solidHeader = TRUE, 
              selectInput("chooseState2", "Select a state: ", c("Alabama", "Alaska","Arizona",
                                                                "Arkansas", "California","Colorado",
                                                                "Connecticut","Delaware","Florida",
                                                                "Georgia","Hawaii","Idaho", "Illinois", 
                                                                "Indiana","Iowa","Kansas","Kentucky",
                                                                "Louisiana","Maine","Maryland",
                                                                "Massachusetts","Michigan","Minnesota",
                                                                "Mississippi","Missouri",'Montana',
                                                                'Nebraska','Nevada','New Hampshire',
                                                                'New Jersey','New Mexico','New York',
                                                                'North Carolina','North Dakota','Ohio',
                                                                'Oklahoma','Oregon','Pennsylvania',
                                                                'Rhode Island','South Carolina',
                                                                'South Dakota','Tennessee','Texas','Utah',
                                                                'Vermont','Virginia','Washington',
                                                                'West Virginia','Wisconsin','Wyoming')), 
              collapsible = TRUE, 
              plotOutput("densityCauses", height = 300, width = 600), 
              width = 600
            )
          )
        ), 
        fluidRow(
          column(width = 12, 
            box(
              title = "Causes of Alcohol-Related Deaths", status = "danger", solidHeader = TRUE, 
              collapsible = TRUE,
              column(width = 3,
                selectInput("chooseState", "Select a state: ", c("Alabama", "Alaska","Arizona",
                                                                 "Arkansas", "California","Colorado",
                                                                 "Connecticut","Delaware","Florida",
                                                                 "Georgia","Hawaii","Idaho", "Illinois", 
                                                                 "Indiana","Iowa","Kansas","Kentucky",
                                                                 "Louisiana","Maine","Maryland",
                                                                 "Massachusetts","Michigan","Minnesota",
                                                                 "Mississippi","Missouri",'Montana',
                                                                 'Nebraska','Nevada','New Hampshire',
                                                                 'New Jersey','New Mexico','New York',
                                                                 'North Carolina','North Dakota','Ohio',
                                                                 'Oklahoma','Oregon','Pennsylvania',
                                                                 'Rhode Island','South Carolina',
                                                                 'South Dakota','Tennessee','Texas','Utah',
                                                                 'Vermont','Virginia','Washington',
                                                                 'West Virginia','Wisconsin','Wyoming')), 
                selectInput("chooseYear", "Select a year: ", c(1990, 1991, 1992, 1993, 1994, 1995, 1996, 1997, 
                                                               1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 
                                                               2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 
                                                               2014, 2015, 2016, 2017, 2018, 2019))
              ),
              column(width = 9,
                plotOutput("stateCauses", height = 300, width = 800)
              ),
              width = 800
            )
          ),
        )
        
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
)# dashboardPage
######## Server ##########################################################

# Define server input and output
server <- function(input, output, session) {
  #Second page alcohol consumption map tab box 4
  output$tabset4Selected <- renderText({
    input$tabset4
  })
  
  # First page alcohol consumption map
  output$usPlot <- renderPlot({
    choropleth_map(alcoholByStateGallons, "alcoholConsumptionGallons")
  })
  ####test
  output$interactive_map <- renderPlotly({
    data <- alcoholByStateGallons
    var <- "alcoholConsumptionGallons"
    create_fresh_map(data, var)
  })
  
  # First page region pie chart
  output$regionChart <- renderPlot({
    createPieChart(subsetRegion, input$category)
  })
  
  # First page region bar chart
  output$regionChart2 <- renderPlot({
    regionHabits(input$category8)
  })
  
  #Second page education status tabbox
  output$tabset1Selected <- renderText({
    input$tabset1
  })
  
  # Second page education status bar chart2
  output$EducationChart <- renderPlot({
    chooseSub(subsetEdu, input$category1)
  })
  
  # Second page education bar chart2
  output$Education2 <- renderPlot({
    eduHabits(input$category7)
  })
  
  #Second page Family income tab box 2
  output$tabset2Selected <- renderText({
    input$tabset2
  })
  
  # Second page Family income bar chart
  output$FamIncome <- renderPlot({
    chooseSub(subsetFamIncome, input$category5)
  })
  
  # Second page Family income bar chart2
  output$FamIncome2 <- renderPlot({
    incomeHabits(input$category9)
  })
  #Second page Marital tab box 3
  output$tabset3Selected <- renderText({
    input$tabset3
  })
  
  # Second page Marital bar chart
  output$Marital <- renderPlot({
    chooseSub(subsetMarital, input$category6)
  })
  
  # Second page Marital bar chart2
  output$Marital2 <- renderPlot({
    maritalHabits(input$category10)
  })
  
  #Second page age group tabbox
  output$tabset5Selected <- renderText({
    input$tabset5
  })
  
  # Second Page age pie chart 
  output$AgeChart <- renderPlot({
    createPieChart(subsetAge, input$category2)
  })
  
  # Second Page Age pie chart2
  output$Age2 <- renderPlot({
    createPieChart(subsetAge_rotated, input$category11)
  })
  
  #Second page Employment tabbox
  output$tabset6Selected <- renderText({
    input$tabset6
  })
  
  # Second page employment pie chart
  output$Employee <- renderPlot({
    createPieChart(subsetEmp, input$category3)
  })
  
  # Second page employment pie chart2
  output$Employee2 <- renderPlot({
    createPieChart(subsetEmp_rotated, input$category12)
  })
  
  # Third page death cause
  output$stateCauses <- renderPlot({
    statePlot(input$chooseState, input$chooseYear)
  })
  
  # Third page density of death causes over time
  output$densityCauses <- renderPlot({
    ridgeline(input$chooseState2)
  })
  
  # Third page death cause changes over time 
  output$lineCauses <- renderPlot({
    multiLine(input$chooseState3)
  })
  
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

subsetAge