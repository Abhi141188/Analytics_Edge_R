# Finding Missing Values in R
df <- data.frame(A = c(2,NA,9,NA),                 
                 
                 B = c(4,NA, 55,66),                 
                 
                 C = c(3,44,1,22)) 
df

# is.na() - indicates which elements are missing
is.na(df) 

# any(is.na()) - indicates if there are any NAs
any(is.na(df))

# sum(is.na()) - counts the number of NAs
sum(is.na(df))

# summary() - finds NAs
summary(df)

# complete.cases() - 
#Indicates Rows with no missing values as TRUE
complete.cases(df)

#Used to find rows with no missing values.
df[complete.cases(df),] 

# na.omit() - to remove rows with NAs
df
df1<-na.omit(df)
df1

# Example using titanic dataset (please download the csv from my Github repository)
getwd()

df_titanic <- read.csv(file = "F:/rWork/rProjects/Analytics_Edge/Analytics_Edge_R/data/TitanicDataMissingValues.csv")

View(df_titanic)
dim(df_titanic)

#Total missing values in dataset:
sum(is.na(df_titanic))

# Return the column names containing missing observations
list_na <- colnames(df_titanic)[ apply(df_titanic, 2, anyNA) ]
list_na

# Missing observations
dim(df_titanic)
summary(df_titanic)

# Dropping/Deleting/Excluding the missing observations
library(dplyr)
df_titanic_drop <-df_titanic %>%
  na.omit()		
dim(df_titanic_drop)
summary(df_titanic_drop)

#Imputing Missing values in dataset----
#Impute Missing data with the Mean and Median
list_na <- colnames(df_titanic)[ apply(df_titanic, 2, anyNA) ]
list_na

# Create mean
average_missing <- apply(df_titanic[,colnames(df_titanic) %in% list_na],
                         2, mean, na.rm =TRUE)
average_missing
class(average_missing)
#We successfully created the mean of the columns containing missing observations. These two values will be used to replace the missing observations.

# Create a new variable with the mean
# mutate() -This verb in the dplyr library is helpful to create new variable or change the values of an existing variable.
df_titanic_replace <- df_titanic %>%
  mutate(replace_mean_age  = ifelse(is.na(Age), average_missing[1], Age),
         replace_mean_fare = ifelse(is.na(Fare), average_missing[2], Fare))
View(df_titanic_replace)

#Check the total NAs in Age
sum(is.na(df_titanic_replace$Age))
#Perform the replacement
sum(is.na(df_titanic_replace$replace_mean_age))

#We can replace the missing observations with the median as well.
median_missing <- apply(df_titanic[,colnames(df_titanic) %in% list_na],
                        2,
                        median,
                        na.rm =  TRUE)
median_missing

# Create a new variable with the median
# mutate() -This verb in the dplyr library is helpful to create new variable or change the values of an existing variable.
df_titanic_replace <- df_titanic %>%
  mutate(replace_median_age  = ifelse(is.na(Age), median_missing[1], Age), 
         replace_median_fare = ifelse(is.na(Fare), median_missing[2], Fare))
View(df_titanic_replace)

#Check the total NAs in Fare
sum(is.na(df_titanic_replace$Fare))
#Perform the replacement
sum(is.na(df_titanic_replace$replace_median_fare))





