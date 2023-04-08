#' @title: multiLine
#' @example multiLine("Alaska")

#' Function to create a multiline chart based on the state chosen 
#' by the user to get state-specific insights about causes of death over time

library(ggplot2)
library(ggridges)

multiLine <- function(state){
  # Create subplot first
  ridgeSubset <- subset(IHME, location == state)
  ridgeSubset <- ridgeSubset %>%
    select(cause, year, val)
  # Create line plot with multiple lines
  ggplot(ridgeSubset, aes(x = year, y = val, colour = cause)) +
    geom_line() +
    theme_bw() +
    labs(title = paste0("Alcohol-Related Deaths Over Time (1990-2019)", state), y = "Number of Cases (in 100s of thousands)", x = "Year")
}
