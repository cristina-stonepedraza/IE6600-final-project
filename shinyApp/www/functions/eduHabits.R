#' @title: eduHabits
#' @example eduHabits("Lifetime Abstainer")

#' Function to create a bar chart based on the drinking habit  
#' that the user chooses to examine for education. 

library(ggplot2)

# Function
eduHabits <- function(habit){
  ggplot(subsetEdu_rotated, aes(x = Type, y = .data[[habit]], fill = Type)) + 
    geom_bar(stat = "identity") +
    labs(title = "Regional Frequency by Habit\n", x = "\nEducation Level", y = "Frequency\n") +
    theme_classic() + 
    theme(axis.text.x = element_text(angle = 45, vjust = 0.5))
}
