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
  ggplot(df, aes(x = Type, y = .data[[colName]], fill = Type)) + 
    geom_bar(stat = "identity") +
    labs(title = "Frequency of Drinking Habits\n", x = "\nHabit", y = "Frequency\n") +
    theme_classic() + 
    theme(axis.text.x = element_text(angle = 45, vjust = 0.5))
}

chooseSub(subsetEdu2, "X1")

# Practice pie chart 
#prac1 <- subsetEdu2 %>%
#  select('Some college')

#pie(table(prac1))


