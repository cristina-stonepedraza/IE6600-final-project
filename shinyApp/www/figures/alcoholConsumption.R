#' @title: alcoholConsumption

#' Visualization of the categories of death due to alcohol use

library(ggplot2)

# First plot - Any Alcohol Use
anyUse <- dataARDI %>%
  select(ConsumptionPattern, Category)
anyUse <- subset(anyUse, ConsumptionPattern == "Any Alcohol Use")
anyUse <- table(anyUse$Category)
anyUse <- as.data.frame(anyUse)
anyUse <- anyUse[-c(11), ]

anyAlcoholUsePlot <- ggplot(data = anyUse) + 
  geom_col(mapping = aes(x = "", y = Freq, fill = Var1)) +
  coord_polar(theta = "y") +
  theme_bw() + 
  labs(title = paste0("Alcohol-Related Deaths Due to Any Alcohol Use (2015-2019)"), y = "Frequency")

# Second plot - Excessive Alcohol Use
excessUse <- dataARDI %>%
  select(ConsumptionPattern, Category)
excessUse <- subset(excessUse, ConsumptionPattern == "Excessive Alcohol Use")
excessUse <- table(excessUse$Category)
excessUse <- as.data.frame(excessUse)
excessUse <- excessUse[-c(10), ]

excessiveAlcoholUsePlot <- ggplot(data = excessUse) + 
  geom_col(mapping = aes(x = "", y = Freq, fill = Var1)) +
  coord_polar(theta = "y") +
  theme_bw() + 
  labs(title = paste0("Alcohol-Related Deaths Due to Excessive Alcohol Use (2015-2019)"), y = "Frequency")
