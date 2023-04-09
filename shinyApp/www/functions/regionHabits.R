#' @title: regionHabits
#' @example regionHabits("Lifetime Abstainer")

#' Function to create a bar chart based on the demographic subset 
#' that the user chooses to examine. 
#' Example: education status + some college

library(ggplot2)

# Function
regionHabits <- function(habit){
  ggplot(subsetRegion_rotated, aes(x = Type, y = .data[[habit]], fill = Type)) + 
    geom_bar(stat = "identity") +
    labs(title = "Regional Frequency by Habit\n", x = "\nRegion", y = "Frequency\n") +
    theme_classic() + 
    theme(axis.text.x = element_text(angle = 45, vjust = 0.5))
}
