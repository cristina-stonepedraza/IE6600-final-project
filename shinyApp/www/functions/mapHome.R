library(ggplot2)
library(maps)
library(RColorBrewer)
library(dplyr)
library(plotly)

create_fresh_map_home <- function(data, var) {
  # Get US map data
  us_map <- map_data("state")
  
  # Assign a color ID to each state
  unique_states <- unique(us_map$region)
  color_ids <- 1:length(unique_states)
  names(color_ids) <- unique_states
  us_map$color_id <- color_ids[us_map$region]
  
  # Create a color palette with 50 colors
  pastel_colors <- colorRampPalette(brewer.pal(9, "Pastel1"))(50)
  
  # Remove 'year' and 'cause' columns
  data <- data %>% select(-year, -cause)
  
  # Aggregate 'val' column based on 'location'
  data <- data %>%
    group_by(location) %>%
    summarise(val = sum(val, na.rm = TRUE))
  
  # Merge map data and input data
  data$region <- tolower(data$location)
  merged_data <- us_map %>%
    left_join(data, by = "region")
  
  # Create a map of the United States
  p <- ggplot() +
    geom_polygon(data = merged_data, aes(x = long, y = lat, group = group, fill = as.factor(color_id), text = paste(region, "<br>", round(val, 1))), color = "white", size = 0.1) +
    coord_fixed(1.3) +
    scale_fill_manual(values = pastel_colors) +
    theme_minimal() +
    theme(
      legend.position = "none",
      plot.title = element_text(hjust = 0.5)
    ) + 
    labs(x = "Latitude", y = "Longitud ")
  
  # Using plotly to make graphs interactive
  p <- ggplotly(p, tooltip = "text")
  
  return(p)
}


# Example usage
data <- IHME
var <- "val"
create_fresh_map_home(data, var)



