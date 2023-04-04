#' @title: subsetFunctions

#' Function to create a chart based on the demographic subset 
#' that the user chooses to examine. 
#' Example: education status + some college

library(ggplot2)

# Practice table to try and get plots to work 
#prac2 <- subsetEdu2 %>%
#  select(Type, "Some college")

Type <- c("Lifetime Abstainer", "Former Infrequent", "Former Regular", "Current Infrequent", "Current Regular")
Freq <- c(8930, 5912, 3901, 9755, 33113)
prac2 <- data.frame(Type, Freq)

ggplot(prac2, aes(x = Type, y = Freq, fill = Type)) + 
  geom_bar(stat = "identity") +
  labs(title = "Frequency of Drinking Habits for Some College Edu Status\n", x = "\nHabit", y = "Frequency\n") +
  theme_classic() + 
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5))


# Function - almost works (can't get line 30 to work properly, gives weird y-axis)

chooseSub <- function(df, colName){
  newSub <- df %>%
    select(Type, all_of(colName))
  ggplot(newSub, aes(x = Type, y = !!ensym(colName), fill = Type)) + 
    geom_bar(stat = "identity") +
    labs(title = "Frequency of Drinking Habits\n", x = "\nHabit", y = "Frequency\n") +
    theme_classic() + 
    theme(axis.text.x = element_text(angle = 45, vjust = 0.5))
}

chooseSub(subsetEdu2, "Some college")

##### Does the function work?
chooseSub2 <- function(df, colName){
  df_plot <- ggplot(data = df, mapping = aes_string(x = colName)) 
  df_plot + 
    geom_histogram(stat = "count") +
    labs(title = "Frequency of Drinking Habits") +
    theme(axis.line.x = element_text(angle = 45))
}  

chooseSub2(subsetEdu2, "X1")

# Practice pie chart 
#prac1 <- subsetEdu2 %>%
#  select('Some college')

#pie(table(prac1))

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

