#' @title: subsetFunction
#' @example chooseSub(subsetEdu, "Some college")

#' Function to create a bar chart based on the demographic subset 
#' that the user chooses to examine. 
#' Example: education status + some college

library(ggplot2)

# Function
chooseSub <- function(df, colName){
  ggplot(df, aes(x = Type, y = .data[[colName]], fill = Type)) + 
    geom_bar(stat = "identity") +
    labs(title = "Frequency of Drinking Habits\n", x = "\nHabit", y = "Frequency\n") +
    theme_classic() + 
    theme(axis.text.x = element_text(angle = 45, vjust = 0.5))
}
