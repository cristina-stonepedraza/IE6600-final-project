#' @title: PieChart
#' @example createPieChart(subsetEdu, "Some college")

#' Function to create a pie chart based on the demographic subset 
#' that the user chooses to examine. 

library(ggplot2)

# Function of Pie Chart
createPieChart <- function(df, colName) {
  ggplot(data = df) + 
    geom_col(mapping = aes(x = "", y = .data[[colName]], fill = Type)) +
    coord_polar(theta = "y") +
    theme_bw() +
    labs(title = paste0("Pie Chart of ", colName), y = "Frequency")
}

<<<<<<< HEAD
createPieChart(prac2, "Freq")
createPieChart(subsetAge, "Current regular1")
=======
createPieChart(subsetEdu, "Some college")
>>>>>>> be5e66cb253a0f2dfd4f3cef409870c23b877cb2
