#Project: Logistic Regression
library(dplyr)
# %<%

#Read the dataset----
data_adult<-read.csv("F:/rWork/rProjects/Analytics_Edge/Analytics_Edge_R/data/annual_income.csv")

View(data_adult)

summary(data_adult)

##Handling Missing values in the dataset:

#Replacing "?" with NA to know the missing values----
data_adult[ data_adult == "?" ] <- NA

#Counting the total no. of missing values
sum(is.na(data_adult))

#Removing the rows with missing values----
da1 <- data_adult[complete.cases(data_adult), ]  
str(da1)
summary(da1)
View(da1)

#Check continuous variables----
continuous <-select_if(da1, is.numeric)
summary(continuous)
#We can see that all these cont var have totally different scales and 
#hours.per.weeks has large outliers (.i.e. look at the last quartile and maximum value).
# We can deal with cont var of diff scales in following two steps:
#1: Plot the distribution and remove outliers if any.
#2: Standardize the continuous variables

#Plot the distribution of hours.per.week
# Histogram with kernel density curve
library(ggplot2)
ggplot(continuous, aes(x = hours.per.week)) +
    geom_density(alpha = .2, fill = "#FF6666")

boxplot(data_adult$hours.per.week)

#tackle this problem by deleting the top 0.01 percent of the hours per week.
#We Compute the value of the 99 percent of the working time
top_one_percent <- quantile(data_adult$hours.per.week, .99)
top_one_percent
#98 percent of the population works under 80 hours per week.
#We can drop the observations above this threshold. 
data_adult_drop <-da1 %>%
  filter(hours.per.week<top_one_percent)
dim(data_adult_drop)
View(data_adult_drop)

boxplot(data_adult_drop$hours.per.week)

#Standardize the continuous variables
#We can standardize each column to improve the performance because 
#our data does not have the same scale.
#Check continuous variables----
continuous <-select_if(data_adult_drop, is.numeric)
summary(continuous)

data_adult_rescale <- data_adult_drop %>%
  mutate_if(is.numeric, funs(as.numeric(scale(.))))
head(data_adult_rescale)
View(data_adult_rescale)
#Check for factor/categorical variables----
str(data_adult_rescale)
#Select categorical columns
char <- data.frame(select_if(data_adult_rescale, is.character))
ncol(char)#This tells that the dataset contains 6 categorical variables

#Plot a bar chart for each column in the data frame, i.e., character type
library(ggplot2)
# Create graph for each column
graph <- lapply(names(char),
                function(x) 
                  ggplot(char, aes(get(x))) +
                  geom_bar() +
                  theme(axis.text.x = element_text(angle = 90)))
# Print the graph
graph

#Feature Engineering----
#Recast Education:
#low level of education will be converted in dropout. 
#Higher levels of education will be changed to master.
table(data_adult_rescale$education)
recast_data <- data_adult_rescale %>%
  mutate(education = factor(ifelse(education == "Preschool" | education == "10th" | 
                                     education == "11th" | education == "12th" | 
                                     education == "1st-4th" | education == "5th-6th" | 
                                     education == "7th-8th" | education == "9th", "dropout", 
                                   ifelse(education == "HS-grad", "HighGrad",
                                          ifelse(education == "Some-college" | 
                                                   education == "Assoc-acdm" | 
                                                   education == "Assoc-voc", "Community",
                                                   ifelse(education == "Bachelors", "Bachelors",
                                                   ifelse(education == "Masters" | 
                                                            education == "Prof-school", "Master", "PhD")))))))

#check the number of individuals within each group of education.
table(recast_data$education)

#Recast Marital-status: creating lower levels for the marital status
#Change level in marital status var
table(recast_data$marital.status)
recast_data <- recast_data %>%
  mutate(marital.status = factor(ifelse(marital.status == "Never-married" | 
                                          marital.status == "Married-spouse-absent", "Not_married", 
                                        ifelse(marital.status == "Married-AF-spouse" | 
                                                 marital.status == "Married-civ-spouse", "Married", 
                                               ifelse(marital.status == "Separated" | 
                                                        marital.status == "Divorced", "Separated", "Widow")))))
#check the number of individuals within each group.
table(recast_data$marital.status)

#Summary Statistic----
#Here, we check some statistics about our target variables.
# Plot gender income
ggplot(recast_data, aes(x = gender, fill = income)) +
  geom_bar(position = "fill") +
  theme_classic()

#checking if race of individual affects their earning.
# Plot race with income
ggplot(recast_data, aes(x = race, fill = income)) +
  geom_bar(position = "fill") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 90))

# Plot number of hours work with gender.
# box plot gender with working time
ggplot(recast_data, aes(x = gender, y = hours.per.week)) +
  geom_boxplot() +
  stat_summary(fun.y = mean,
               geom = "point",
               size = 3,
               color = "steelblue") +
  theme_classic()

#Split the dataset in Train/Test data----
#Prep Training and Test data.----
View(recast_data)
trainDataIndex <- sample(1:nrow(recast_data),0.7*nrow(recast_data), replace = F)
trainData <-recast_data[trainDataIndex, ]
testData <- recast_data[-trainDataIndex, ]
View(trainData)
View(testData)

# Income distribution of train data
table(trainData$income)

# Change Y values to 1's and 0's
trainData$income <- ifelse(trainData$income == ">50K", 1, 0)
str(trainData)
trainData$income <- factor(trainData$income, levels = c(0, 1))
str(trainData)

#Build the regression model----
logit <- glm(income~., data = trainData, family = 'binomial')
summary(logit)

logit <- glm(income~
               age+
               #workclass+
               education+educational.num+
               marital.status+ 
               gender+hours.per.week, data = trainData, family = 'binomial')
summary(logit)

#Change Dependent Var "Income" values to 1's and 0's----
testData$income <- ifelse(testData$income == ">50K", 1, 0)

#----------Predict--------------------
testData$Pred_Income <- predict(logit,testData,type =c("response"))
View(testData)
table(testData$income)/nrow(testData)

#from above cmd, we know that in the test dataset, 
#count of "0" in column "Income" is 75% and count of "1" is 25%.
#Hence, we try to see the data in column "Pred_Income", using quantile fxn.
#And notice the values at quantile level 75%, i.e., between 70% to 80%
quantile(testData$Pred_Income, probs = seq(0,1,0.05))
table(testData$income)
#Since, the value at quantile level at 75% is 4.058485e-01,
#Hence, we consider all the values greater than this value as 1 and others as 0 in our Predicted values column.
testData$Pred_Income <- ifelse(testData$Pred_Income > 0.4,1,0)
View(testData)

#Checking Accuracy of Model using: Confusion Matrix----
table(testData$Pred_Income)/nrow(testData)
table_mat<-table(testData$Pred_Income,testData$income)
table_mat
##From the above table cmd, we have got confusion matrix, stating that:
#No. of "0" present in training dataset is equal to no. of "0" predicted in test dataset , for 9031 enteries.
#No. of "1" present in training dataset is equal to no. of "1" predicted in test dataset for 2144 enteries.
#Hence, Accuracy will be = (9031+2144)/(9031+2144+1211+1279) = 81.7%
accuracy_Test <- sum(diag(table_mat)) / sum(table_mat)
accuracy_Test
