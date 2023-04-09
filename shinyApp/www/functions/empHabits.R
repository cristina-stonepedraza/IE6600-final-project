#' @title: empHabits
#' @example empHabits("Lifetime Abstainer")

#' Function to create a bar chart based on the drinking habit  
#' that the user chooses to examine for employment status 

library(ggplot2)

# Function
empHabits <- function(habit){
  ggplot(subsetEmp_rotated, aes(x = Type, y = .data[[habit]], fill = Type)) + 
    geom_bar(stat = "identity") +
    labs(title = "Regional Frequency by Habit\n", x = "\nEmployment Status", y = "Frequency\n") +
    theme_classic() + 
    theme(axis.text.x = element_text(angle = 45, vjust = 0.5))
}
