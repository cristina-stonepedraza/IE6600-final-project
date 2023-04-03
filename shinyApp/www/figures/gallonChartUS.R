#' @title: gallonChartUS
#' 
#' US Map showing average alcohol consumption per person per state
#' in gallons. 

install.packages('usmap')
library(usmap)
library(ggplot2)

plot_usmap(data = alcoholByStateGallons, values = "alcoholConsumptionGallons", color = "black") + 
  scale_fill_continuous(low = "white", high = "darkblue", name = "Consumption in Gallons (per Person, per Year)", label = scales::comma) + 
  theme(legend.position = "right")

