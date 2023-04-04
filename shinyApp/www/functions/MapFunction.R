library(usmap)
library(ggplot2)

# define function to generate choropleth map
choropleth_map <- function(data, var, color) {
  plot_usmap(data = data, values = var, color = color) + 
    scale_fill_continuous(low = "white", high = color, 
                          name = paste(var, " (per Person, per Year)"), 
                          label = scales::comma) + 
    theme(legend.position = "right")
}

# example usage
data <- alcoholByStateGallons
var <- "alcoholConsumptionGallons"
color <- "darkgreen"
choropleth_map(data, var, color)