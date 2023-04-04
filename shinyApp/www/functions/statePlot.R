#' @title: statePlot
#' @example statePlot("Alaska)

#' Function to create a  chart based on the state chosen 
#' by the user to get state-specific insights 

library(usmap)
library(ggplot2)

# Function

statePlot <- function(state){
  # First get subset for that state
  stateSubset <- dataARDI %>%
    select(LocationDesc, Category)
  stateSubset <- subset(stateSubset, LocationDesc == state)
  stateSubset <- table(stateSubset$Category)
  stateSubset <- as.data.frame(stateSubset)

  # Plot category of alcohol related deaths 
  ggplot(data = stateSubset) + 
    geom_col(mapping = aes(x = "", y = Freq, fill = Var1)) +
    coord_polar(theta = "y") +
    theme_bw() + 
    labs(title = paste0("Pie Chart of Alcohol-Related Deaths for ", state), y = "Frequency")
}
