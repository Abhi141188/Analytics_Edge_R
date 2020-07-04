#----Factors----
# R stores categorical variables into a factor.

# Create gender vector
gender_vector <- c("Male", "Female", "Female", "Male", "Male")
class(gender_vector)
table(gender_vector)

# Convert gender_vector to a factor
factor_gender_vector <-factor(gender_vector)
class(factor_gender_vector)
table(gender_vector)

# A categorical variable can be divided into 2 types:
# nominal categorical variable and ordinal categorical variable.

#Nominal Categorical Variable has several values but the order does not matter. 

# Create Nominal Categorical vector
color_vector <- c('blue', 'red', 'green', 'white', 'black', 'yellow')
# Convert the vector to factor
factor_color <- factor(color_vector)
factor_color

#Ordinal categorical variables do have a natural ordering. 
#We can specify the order here, 
# from the lowest to the highest with order = TRUE and 
# from highest to lowest with order = FALSE.

# Create Ordinal categorical vector 
day_vector <- c('evening', 'morning', 'afternoon', 'midday', 'midnight', 'evening')
# Convert `day_vector` to a factor with ordered level
factor_day <- factor(day_vector, order = TRUE, levels =c('morning', 'midday', 'afternoon', 'evening', 'midnight'))
# Print the new variable
factor_day

#Note: Continuous Variables are by default of numeric class in R.


