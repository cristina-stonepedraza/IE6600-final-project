library(usmap)
library(ggplot2)

# define function to generate choropleth map
choropleth_map <- function(data, var, color) {
  plot_usmap(data = data, values = var, color = color) + 
    scale_fill_continuous(low = "white", high = color, 
                          name = paste(var, " (per Person, per Year)"), 
                          label = function(x) format(round(x, 2), nsmall = 2, big.mark = ",")) +
    theme(legend.position = "right")
}

# example usage
#data <- alcoholByStateGallons
#var <- "alcoholConsumptionGallons"
#color <- "darkgreen"
#choropleth_map(data, var, color)


#data <- subsetAlcoholDeath
#var <- "Number_of_Death"
#color <- "darkblue"
#choropleth_map(data, var, color)
