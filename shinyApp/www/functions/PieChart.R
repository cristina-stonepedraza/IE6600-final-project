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
