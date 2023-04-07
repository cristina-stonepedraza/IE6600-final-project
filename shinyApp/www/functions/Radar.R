library(fmsb)


create_radarchart <- function(data, max_value, min_value, selected_rows = NULL, 
                              selected_columns = NULL, log_transform = FALSE, 
                              show_values = TRUE) {
  
  # Check if selected_rows and selected_columns are not empty
  #if (length(selected_rows) == 0 || length(selected_columns) == 0) {
  #  return(NULL)
  #}
  
  # if >3
  #if (ncol(data) < 3) {
  #  stop("The input data must have at least 3 columns.")
  #}

  
  # select row and col
  data <- data[selected_rows, selected_columns, drop = FALSE]
  
  # if need log
  if (log_transform) {
    data <- log(data)
    max_value <- log(max_value)
    min_value <- log(min_value)
  }
  
  
  # add max and min
  data <- rbind(rep(max_value, ncol(data)), rep(min_value, ncol(data)), data)
  
  rownames(data)[1:2] <- c("MaxValueRow", "MinValueRow")
  
  
  # creat radar
  radarchart( data,
              pcol = "gray",
              pfcol = "gray",
              cglcol = "black",
              cglty = 1,
              plwd = 3,
              cglwd = 2)

  
  # if show_values = true
  if (show_values) {
    for (i in 3:nrow(data)) {
      for (j in 1:ncol(data)) {
        angle <- (j - 1) * 2 * pi / ncol(data)
        xpos <- (4 + data[i, j] / max_value) * cos(angle) * 0.3
        ypos <- (2 + data[i, j] / max_value) * sin(angle) * 0.435
        text(xpos, ypos, labels = round(data[i, j], 1), cex = 1, col = "darkgray",font = 2,)
      }
    }
  }
}


# example

create_radarchart(subsetMarital, max_value = 72000, min_value = 500, selected_rows = c("Current Regular"), selected_columns = c("Married", "Widowed", "Never married","Divorced or separated","Living with a partner"))
