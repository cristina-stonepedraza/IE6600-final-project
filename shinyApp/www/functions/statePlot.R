#' @title: statePlot
#' @example statePlot("Alaska)

#' Function to create a  chart based on the state chosen 
#' by the user to get state-specific insights 

library(usmap)
library(ggplot2)

# Function

statePlot <- function(state, yr){
  # First get subset for that state
  stateSubset <- subset(IHME, location == state)
  stateSubset <- subset(stateSubset, year == yr)
  stateSubset <- stateSubset %>%
    select(cause, val)
  # Plot category of alcohol related deaths 
  ggplot(data = stateSubset) + 
    geom_col(mapping = aes(x = "", y = val, fill = cause)) +
    coord_polar(theta = "y") +
    theme_bw() + 
    labs(title = paste0("Frequency of Alcohol-Related Deaths for ", state), y = "Frequency")
}

#statePlot("Alabama", 1990)
