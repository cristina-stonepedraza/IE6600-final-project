# IE 6600 Final Project - Team 2 

# Imports/Libraries

# Reading and tidying data
library(readr)
library(dplyr)
library(readxl)

library(tidyverse)
library(ggplot2)
library(scales)
library(tidyr)
library(haven)

# Step 1 - Data import, tidy, and transform data for analysis

# First table - Alcohol Consumed By State from WorldPopulationReview (https://worldpopulationreview.com/state-rankings/alcohol-consumption-by-state)
# Goal is to extract the gallons of consumption per state 
alcoholByState <- read_csv("~/VSCode/NEU/IE6600/Project/IE6600-final-project/shinyApp/data.csv")

# Select - we just want the state and gallons consumed columns (gallons per person, per year)
alcoholByStateGallons <- alcoholByState %>%
  select(state, alcoholConsumptionGallons)

# Make tidy - this dataset is already very simple, and tidy
alcoholByStateGallons

# Second table - 2018 Frequency Distribution by Characteristic 
frequencyDist2018 <- read_excel("~/VSCode/NEU/IE6600/Project/IE6600-final-project/shinyApp/2018-SHS-data.xlsx")
View(frequencyDist2018)

# Create subsets and make tidy
# Alcohol use by age group
subsetAge <- frequencyDist2018[c(6, 7, 8, 9), ]
colnames(subsetAge)[colnames(subsetAge) == 'Selected characteristic'] <- 'Age Group'
colnames(subsetAge)[colnames(subsetAge) == 'Lifetime abstainer1'] <- 'Lifetime Abstainer'
colnames(subsetAge)[colnames(subsetAge) == 'Former infrequent1'] <- 'Former Infrequent'
colnames(subsetAge)[colnames(subsetAge) == 'Former regular1'] <- 'Former Regular'
colnames(subsetAge)[colnames(subsetAge) == 'Current infrequent1'] <- 'Current Infrequent'
colnames(subsetAge)[colnames(subsetAge) == 'Current regular1'] <- 'Current Regular'
View(subsetAge)

# Alcohol use by education status
subsetEdu <- frequencyDist2018[c(27, 28, 29, 30), ]

#colnames(subsetEdu)[colnames(subsetEdu) == 'Selected characteristic'] <- 'Education Level'
colnames(subsetEdu)[colnames(subsetEdu) == 'Lifetime abstainer1'] <- 'Lifetime Abstainer'
colnames(subsetEdu)[colnames(subsetEdu) == 'Former infrequent1'] <- 'Former Infrequent'
colnames(subsetEdu)[colnames(subsetEdu) == 'Former regular1'] <- 'Former Regular'
colnames(subsetEdu)[colnames(subsetEdu) == 'Current infrequent1'] <- 'Current Infrequent'
colnames(subsetEdu)[colnames(subsetEdu) == 'Current regular1'] <- 'Current Regular'

subsetEdu <- subsetEdu %>%
  select('Selected characteristic', 'Lifetime Abstainer', 'Former Infrequent', 'Former Regular', 'Current Infrequent', 'Current Regular')

subsetEdu2 <- data.frame(t(subsetEdu[-1]))
colnames(subsetEdu2)[colnames(subsetEdu2) == 'X1'] <- 'Less than a high school diploma'
colnames(subsetEdu2)[colnames(subsetEdu2) == 'X2'] <- 'High school or GED'
colnames(subsetEdu2)[colnames(subsetEdu2) == 'X3'] <- 'Some college'
colnames(subsetEdu2)[colnames(subsetEdu2) == 'X4'] <- 'Bachelors degree or higher'

subsetEdu2$Type = rownames(subsetEdu2)

View(subsetEdu2)

# Alcohol use by employment status
subsetEmp <- frequencyDist2018[c(32, 33, 34, 35, 36), ]
colnames(subsetEmp)[colnames(subsetEmp) == 'Selected characteristic'] <- 'Employment Status'
colnames(subsetEmp)[colnames(subsetEmp) == 'Lifetime abstainer1'] <- 'Lifetime Abstainer'
colnames(subsetEmp)[colnames(subsetEmp) == 'Former infrequent1'] <- 'Former Infrequent'
colnames(subsetEmp)[colnames(subsetEmp) == 'Former regular1'] <- 'Former Regular'
colnames(subsetEmp)[colnames(subsetEmp) == 'Current infrequent1'] <- 'Current Infrequent'
colnames(subsetEmp)[colnames(subsetEmp) == 'Current regular1'] <- 'Current Regular'
View(subsetEmp)

# Alcohol use by family income 
subsetFamIncome <- frequencyDist2018[c(38, 39, 40, 41, 42, 43), ]
colnames(subsetFamIncome)[colnames(subsetFamIncome) == 'Selected characteristic'] <- 'Family Income'
colnames(subsetFamIncome)[colnames(subsetFamIncome) == 'Lifetime abstainer1'] <- 'Lifetime Abstainer'
colnames(subsetFamIncome)[colnames(subsetFamIncome) == 'Former infrequent1'] <- 'Former Infrequent'
colnames(subsetFamIncome)[colnames(subsetFamIncome) == 'Former regular1'] <- 'Former Regular'
colnames(subsetFamIncome)[colnames(subsetFamIncome) == 'Current infrequent1'] <- 'Current Infrequent'
colnames(subsetFamIncome)[colnames(subsetFamIncome) == 'Current regular1'] <- 'Current Regular'
View(subsetFamIncome)

# Alcohol use by region
subsetRegion <- frequencyDist2018[c(72, 73, 74, 75), ]
colnames(subsetRegion)[colnames(subsetRegion) == 'Selected characteristic'] <- 'US Region'
colnames(subsetRegion)[colnames(subsetRegion) == 'Lifetime abstainer1'] <- 'Lifetime Abstainer'
colnames(subsetRegion)[colnames(subsetRegion) == 'Former infrequent1'] <- 'Former Infrequent'
colnames(subsetRegion)[colnames(subsetRegion) == 'Former regular1'] <- 'Former Regular'
colnames(subsetRegion)[colnames(subsetRegion) == 'Current infrequent1'] <- 'Current Infrequent'
colnames(subsetRegion)[colnames(subsetRegion) == 'Current regular1'] <- 'Current Regular'
View(subsetRegion)

# Alcohol use by marital status 
subsetMarital <- frequencyDist2018[c(62, 63, 64, 65, 66), ]
colnames(subsetMarital)[colnames(subsetMarital) == 'Selected characteristic'] <- 'Marital Status'
colnames(subsetMarital)[colnames(subsetMarital) == 'Lifetime abstainer1'] <- 'Lifetime Abstainer'
colnames(subsetMarital)[colnames(subsetMarital) == 'Former infrequent1'] <- 'Former Infrequent'
colnames(subsetMarital)[colnames(subsetMarital) == 'Former regular1'] <- 'Former Regular'
colnames(subsetMarital)[colnames(subsetMarital) == 'Current infrequent1'] <- 'Current Infrequent'
colnames(subsetMarital)[colnames(subsetMarital) == 'Current regular1'] <- 'Current Regular'
View(subsetMarital)

# Third table - Alcohol Related Disease Impact  
ARDI <- read_csv("~/VSCode/NEU/IE6600/Project/IE6600-final-project/shinyApp/Alcohol-Related_Disease_Impact__ARDI__Application_-_Alcohol-Attributable_Deaths.csv")
View(ARDI)

# Subset and Make Tidy 
# Keep only data we need 
dataARDI <- ARDI %>%
  select(LocationAbbr, LocationDesc, ConditionType, Category, Cause_of_Death, ConsumptionPattern, AgeGroup)
View(dataARDI)





#testing 





