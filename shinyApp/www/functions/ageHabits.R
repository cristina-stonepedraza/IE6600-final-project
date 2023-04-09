#' @title: ageHabits
#' @example ageHabits("Lifetime Abstainer")

#' Function to create a bar chart based on the drinking habit  
#' that the user chooses to examine for age range 

library(ggplot2)

# Function
ageHabits <- function(habit){
  ggplot(subsetAge_rotated, aes(x = Type, y = .data[[habit]], fill = Type)) + 
    geom_bar(stat = "identity") +
    labs(title = "Regional Frequency by Habit\n", x = "\nAge Range", y = "Frequency\n") +
    theme_classic() + 
    theme(axis.text.x = element_text(angle = 45, vjust = 0.5))
}

ageHabits("Lifetime Abstainer")
