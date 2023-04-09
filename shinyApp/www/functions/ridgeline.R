#' @title: ridgeline
#' @example ridgeline("Alaska")

#' Function to create a ridgeline chart based on the state chosen 
#' by the user to get state-specific insights about causes of death over time

library(ggplot2)
library(ggridges)

ridgeline <- function(state){
  # Create subplot first
  ridgeSubset <- subset(IHME, location == state)
  ridgeSubset <- ridgeSubset %>%
    select(cause, year, val)
  # Create ridgeline plot showing density/distribution
  # of years per cause based on value/rate of cause
  ggplot(ridgeSubset, aes(x = val, y = cause, fill = stat(x))) +
    geom_density_ridges_gradient() + 
    theme_bw() + 
    scale_fill_viridis_c(name = "Value", option = "C") + 
    labs(title = paste0("Value of Alcohol-Related Deaths for ", state), y = "Causes of Death", x = "Number of Deaths (in 100s of thousands)")
 }
