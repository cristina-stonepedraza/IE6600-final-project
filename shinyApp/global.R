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
library(here)

### Step 1 - Data import, tidy, and transform data for analysis

### First table - Alcohol Consumed By State from WorldPopulationReview 
# (https://worldpopulationreview.com/state-rankings/alcohol-consumption-by-state)
# Goal is to extract the gallons of consumption per state 
alcoholByState <- read_csv("data.csv")

# Select - we just want the state and gallons consumed columns (gallons per person, per year)
# Make tidy - this dataset is already very simple, and tidy
alcoholByStateGallons <- alcoholByState %>%
  select(state, alcoholConsumptionGallons)

### Second table - 2018 Frequency Distribution by Characteristic 
frequencyDist2018 <- read_excel("2018-SHS-data.xlsx")

# Create subsets and make tidy
# Alcohol use by age group
subsetAge <- frequencyDist2018[c(6, 7, 8, 9), ]
colnames(subsetAge)[colnames(subsetAge) == 'Lifetime abstainer1'] <- 'Lifetime Abstainer'
colnames(subsetAge)[colnames(subsetAge) == 'Former infrequent1'] <- 'Former Infrequent'
colnames(subsetAge)[colnames(subsetAge) == 'Former regular1'] <- 'Former Regular'
colnames(subsetAge)[colnames(subsetAge) == 'Current infrequent1'] <- 'Current Infrequent'
colnames(subsetAge)[colnames(subsetAge) == 'Current regular1'] <- 'Current Regular'

subsetAge <- subsetAge %>%
  select('Selected characteristic', 'Lifetime Abstainer', 'Former Infrequent', 'Former Regular', 'Current Infrequent', 'Current Regular')

subsetAge <- data.frame(t(subsetAge[-1]))
subsetAge$X1 <- as.numeric(subsetAge$X1)
subsetAge$X2 <- as.numeric(subsetAge$X2)
subsetAge$X3 <- as.numeric(subsetAge$X3)
subsetAge$X4 <- as.numeric(subsetAge$X4)

colnames(subsetAge)[colnames(subsetAge) == 'X1'] <- '18-44'
colnames(subsetAge)[colnames(subsetAge) == 'X2'] <- '45-64'
colnames(subsetAge)[colnames(subsetAge) == 'X3'] <- '65-74'
colnames(subsetAge)[colnames(subsetAge) == 'X4'] <- '75+'


subsetAge_rotated <- t(subsetAge[ , -5])
rownames(subsetAge_rotated) <- colnames(subsetAge)
colnames(subsetAge_rotated) <- rownames(subsetAge)

subsetAge_rotated <- data.frame(subsetAge_rotated)

subsetAge_rotated$Type = rownames(subsetAge_rotated)

# Alcohol use by education status
subsetEdu <- frequencyDist2018[c(27, 28, 29, 30), ] # <

colnames(subsetEdu)[colnames(subsetEdu) == 'Lifetime abstainer1'] <- 'Lifetime Abstainer' 
colnames(subsetEdu)[colnames(subsetEdu) == 'Former infrequent1'] <- 'Former Infrequent' 
colnames(subsetEdu)[colnames(subsetEdu) == 'Former regular1'] <- 'Former Regular' 
colnames(subsetEdu)[colnames(subsetEdu) == 'Current infrequent1'] <- 'Current Infrequent' 
colnames(subsetEdu)[colnames(subsetEdu) == 'Current regular1'] <- 'Current Regular' 

subsetEdu <- subsetEdu %>%
  select('Selected characteristic', 'Lifetime Abstainer', 'Former Infrequent', 'Former Regular', 'Current Infrequent', 'Current Regular')

subsetEdu <- data.frame(t(subsetEdu[-1]))
subsetEdu$X1 <- as.numeric(subsetEdu$X1)
subsetEdu$X2 <- as.numeric(subsetEdu$X2)
subsetEdu$X3 <- as.numeric(subsetEdu$X3)
subsetEdu$X4 <- as.numeric(subsetEdu$X4)

colnames(subsetEdu)[colnames(subsetEdu) == 'X1'] <- 'Less than a high school diploma'
colnames(subsetEdu)[colnames(subsetEdu) == 'X2'] <- 'High school or GED'
colnames(subsetEdu)[colnames(subsetEdu) == 'X3'] <- 'Some college'
colnames(subsetEdu)[colnames(subsetEdu) == 'X4'] <- 'Bachelors degree or higher'

subsetEdu$Type = rownames(subsetEdu)

subsetEdu_rotated <- t(subsetEdu[ , -5])

subsetEdu_rotated <- data.frame(subsetEdu_rotated)
subsetEdu_rotated$Type = rownames(subsetEdu_rotated)


# Alcohol use by employment status
subsetEmp <- frequencyDist2018[c(32, 33, 34, 35, 36), ]
colnames(subsetEmp)[colnames(subsetEmp) == 'Lifetime abstainer1'] <- 'Lifetime Abstainer'
colnames(subsetEmp)[colnames(subsetEmp) == 'Former infrequent1'] <- 'Former Infrequent'
colnames(subsetEmp)[colnames(subsetEmp) == 'Former regular1'] <- 'Former Regular'
colnames(subsetEmp)[colnames(subsetEmp) == 'Current infrequent1'] <- 'Current Infrequent'
colnames(subsetEmp)[colnames(subsetEmp) == 'Current regular1'] <- 'Current Regular'

subsetEmp <- subsetEmp %>%
  select('Selected characteristic', 'Lifetime Abstainer', 'Former Infrequent', 'Former Regular', 'Current Infrequent', 'Current Regular')

subsetEmp <- data.frame(t(subsetEmp[-1]))
subsetEmp$X1 <- as.numeric(subsetEmp$X1)
subsetEmp$X2 <- as.numeric(subsetEmp$X2)
subsetEmp$X3 <- as.numeric(subsetEmp$X3)
subsetEmp$X4 <- as.numeric(subsetEmp$X4)
subsetEmp$X5 <- as.numeric(subsetEmp$X5)

colnames(subsetEmp)[colnames(subsetEmp) == 'X1'] <- 'Employed'
colnames(subsetEmp)[colnames(subsetEmp) == 'X2'] <- 'Full-time'
colnames(subsetEmp)[colnames(subsetEmp) == 'X3'] <- 'Part-time'
colnames(subsetEmp)[colnames(subsetEmp) == 'X4'] <- 'Not employed but has worked previously'
colnames(subsetEmp)[colnames(subsetEmp) == 'X5'] <- 'Not employed and has never worked'

subsetEmp$Type = rownames(subsetEmp)

subsetEmp_rotated <- t(subsetEmp[ , -6])

subsetEmp_rotated <- data.frame(subsetEmp_rotated)
subsetEmp_rotated$Type = rownames(subsetEmp_rotated)

# Alcohol use by family income 
subsetFamIncome <- frequencyDist2018[c(38, 39, 40, 41, 42, 43), ]
colnames(subsetFamIncome)[colnames(subsetFamIncome) == 'Lifetime abstainer1'] <- 'Lifetime Abstainer'
colnames(subsetFamIncome)[colnames(subsetFamIncome) == 'Former infrequent1'] <- 'Former Infrequent'
colnames(subsetFamIncome)[colnames(subsetFamIncome) == 'Former regular1'] <- 'Former Regular'
colnames(subsetFamIncome)[colnames(subsetFamIncome) == 'Current infrequent1'] <- 'Current Infrequent'
colnames(subsetFamIncome)[colnames(subsetFamIncome) == 'Current regular1'] <- 'Current Regular'

subsetFamIncome <- subsetFamIncome %>%
  select('Selected characteristic', 'Lifetime Abstainer', 'Former Infrequent', 'Former Regular', 'Current Infrequent', 'Current Regular')

subsetFamIncome <- data.frame(t(subsetFamIncome[-1]))
subsetFamIncome <- subset(subsetFamIncome, select = -c(X2))
subsetFamIncome$X1 <- as.numeric(subsetFamIncome$X1)
subsetFamIncome$X3 <- as.numeric(subsetFamIncome$X3)
subsetFamIncome$X4 <- as.numeric(subsetFamIncome$X4)
subsetFamIncome$X5 <- as.numeric(subsetFamIncome$X5)
subsetFamIncome$X6 <- as.numeric(subsetFamIncome$X6)

colnames(subsetFamIncome)[colnames(subsetFamIncome) == 'X1'] <- 'Less than $35,000'
colnames(subsetFamIncome)[colnames(subsetFamIncome) == 'X3'] <- '$35,000–$49,999'
colnames(subsetFamIncome)[colnames(subsetFamIncome) == 'X4'] <- '$50,000–$74,999'
colnames(subsetFamIncome)[colnames(subsetFamIncome) == 'X5'] <- '$75,000–$99,999'
colnames(subsetFamIncome)[colnames(subsetFamIncome) == 'X6'] <- '$100,000 or more'

subsetFamIncome$Type = rownames(subsetFamIncome)

subsetFamIncome_rotated <- t(subsetFamIncome[ , -6])
subsetFamIncome_rotated <- data.frame(subsetFamIncome_rotated)
subsetFamIncome_rotated$Type = rownames(subsetFamIncome_rotated)
  
# Alcohol use by region
subsetRegion <- frequencyDist2018[c(72, 73, 74, 75), ]
colnames(subsetRegion)[colnames(subsetRegion) == 'Lifetime abstainer1'] <- 'Lifetime Abstainer'
colnames(subsetRegion)[colnames(subsetRegion) == 'Former infrequent1'] <- 'Former Infrequent'
colnames(subsetRegion)[colnames(subsetRegion) == 'Former regular1'] <- 'Former Regular'
colnames(subsetRegion)[colnames(subsetRegion) == 'Current infrequent1'] <- 'Current Infrequent'
colnames(subsetRegion)[colnames(subsetRegion) == 'Current regular1'] <- 'Current Regular'

subsetRegion <- subsetRegion %>%
  select('Selected characteristic', 'Lifetime Abstainer', 'Former Infrequent', 'Former Regular', 'Current Infrequent', 'Current Regular')

subsetRegion <- data.frame(t(subsetRegion[-1]))
subsetRegion$X1 <- as.numeric(subsetRegion$X1)
subsetRegion$X2 <- as.numeric(subsetRegion$X2)
subsetRegion$X3 <- as.numeric(subsetRegion$X3)
subsetRegion$X4 <- as.numeric(subsetRegion$X4)

colnames(subsetRegion)[colnames(subsetRegion) == 'X1'] <- 'Northeast'
colnames(subsetRegion)[colnames(subsetRegion) == 'X2'] <- 'Midwest'
colnames(subsetRegion)[colnames(subsetRegion) == 'X3'] <- 'South'
colnames(subsetRegion)[colnames(subsetRegion) == 'X4'] <- 'West'

subsetRegion$Type = rownames(subsetRegion)

subsetRegion_rotated <- t(subsetRegion[ , -5])
subsetRegion_rotated <- data.frame(subsetRegion_rotated)
subsetRegion_rotated$Type = rownames(subsetRegion_rotated)

# Alcohol use by marital status 
subsetMarital <- frequencyDist2018[c(62, 63, 64, 65, 66), ]
colnames(subsetMarital)[colnames(subsetMarital) == 'Lifetime abstainer1'] <- 'Lifetime Abstainer'
colnames(subsetMarital)[colnames(subsetMarital) == 'Former infrequent1'] <- 'Former Infrequent'
colnames(subsetMarital)[colnames(subsetMarital) == 'Former regular1'] <- 'Former Regular'
colnames(subsetMarital)[colnames(subsetMarital) == 'Current infrequent1'] <- 'Current Infrequent'
colnames(subsetMarital)[colnames(subsetMarital) == 'Current regular1'] <- 'Current Regular'

subsetMarital <- subsetMarital %>%
  select('Selected characteristic', 'Lifetime Abstainer', 'Former Infrequent', 'Former Regular', 'Current Infrequent', 'Current Regular')

subsetMarital <- data.frame(t(subsetMarital[-1]))
subsetMarital$X1 <- as.numeric(subsetMarital$X1)
subsetMarital$X2 <- as.numeric(subsetMarital$X2)
subsetMarital$X3 <- as.numeric(subsetMarital$X3)
subsetMarital$X4 <- as.numeric(subsetMarital$X4)
subsetMarital$X5 <- as.numeric(subsetMarital$X5)

colnames(subsetMarital)[colnames(subsetMarital) == 'X1'] <- 'Married'
colnames(subsetMarital)[colnames(subsetMarital) == 'X2'] <- 'Widowed'
colnames(subsetMarital)[colnames(subsetMarital) == 'X3'] <- 'Divorced or separated'
colnames(subsetMarital)[colnames(subsetMarital) == 'X4'] <- 'Never married'
colnames(subsetMarital)[colnames(subsetMarital) == 'X5'] <- 'Living with a partner'

subsetMarital$Type = rownames(subsetMarital)

subsetMarital_rotated <- t(subsetMarital[ , -6])
subsetMarital_rotated <- data.frame(subsetMarital_rotated)
subsetMarital_rotated$Type = rownames(subsetMarital_rotated)

### Third table - Alcohol Related Disease Impact  
ARDI <- read_csv("Alcohol-Related_Disease_Impact__ARDI__Application_-_Alcohol-Attributable_Deaths.csv")

# Subset and Make Tidy 
# Keep only data we need 
dataARDI <- ARDI %>%
  select(LocationAbbr, LocationDesc, ConditionType, Category, Cause_of_Death, ConsumptionPattern, AgeGroup)

# Alcohol related death
subsetAlcoholDeath <- ARDI %>% 
  select(LocationDesc, Category) %>%
  group_by(LocationDesc, Category) %>% 
  mutate (Number_of_Death = n()) 
subsetAlcoholDeath <- unique(subsetAlcoholDeath) %>% 
  spread (key = Category, value = Number_of_Death)
subsetAlcoholDeath <- subsetAlcoholDeath [, -which(names(subsetAlcoholDeath) == "Total")]

