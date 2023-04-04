library(ggplot2)

# Create pie chart of "Some College" people frequency of drinking
ggplot( data= prac2) + 
  geom_col(mapping =  aes(x =  "", y = Freq, fill = Type)) +
  coord_polar(theta = "y") +
  theme_bw()+
  labs(title = "Pie Chart of Drinking Frequency for Some College Education Status", y = "Frequency")

# Function of Pie Chart
createPieChart <- function(df, colName) {
  ggplot(data = df) + 
    geom_col(mapping = aes(x = "", y = df[[colName]], fill = Type)) +
    coord_polar(theta = "y") +
    theme_bw() +
    labs(title = paste0("Pie Chart of ", colName), y = "Frequency")
}

