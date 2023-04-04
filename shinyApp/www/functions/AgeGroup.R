library(ggplot2)

# Fuction
create_pie_chart <- function(data, selected_agegroup, column_name) {
  # Choose AgeGroup and 1 column
  if (!all(c("AgeGroup", column_name) %in% names(data))) {
    stop(paste("Input data must contain 'AgeGroup' and", column_name, "columns"))
  }
  
  # Filter Data
  filtered_data <- data[data$AgeGroup == selected_agegroup, ]
  
  # Calculation
  column_frequency <- as.data.frame(table(filtered_data[, column_name]))
  
  # Create Piechart
  pie_chart <- ggplot(column_frequency, aes(x="", y=Freq, fill=Var1)) +
    geom_bar(width=1, stat="identity") +
    coord_polar("y", start=0) +
    theme_void() +
    labs(title = paste("Distribution of", column_name, "for Age Group", selected_agegroup),
         fill = column_name)
  return(pie_chart)
}

# use function
selected_agegroup <- "Overall"  # AgeGroup
column_name <- "Category"  # column name
pie_chart <- create_pie_chart(data, selected_agegroup, column_name)

# show
print(pie_chart)

