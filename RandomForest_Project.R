#Project on Random Forest
library(randomForest)

#Read the dataset
data <- read.csv("F:/rWork/rProjects/Analytics_Edge/Analytics_Edge_R/data/heart-disease.csv",header=TRUE)

View (data)

dim(data)

head(data)

#To simplify the problem, we're only going to attempt to distinguish the presence of heart disease (values 1,2,3,4) from absence of heart disease (value 0). Therefore, we replace all labels greater than 1 by 1.
data$Heart_D[data$Heart_D > 1] <- 1

#We use function 'summary' for viewing metrics related to our data. 
summary(data)
#We'll notice that it provides mean for even the categorical variables in the dataset.
#This implies that there is an issue with the column types. 
#So lets view the data type of each column.
str(data)

#In R, a categorical variable (a variable that takes on a finite amount of values) is a factor. So we'll convert few of them to factors.
#Also, "sex" is incorrectly treated as a number, it can only be 1 if male and 0 if female.
#Hence, we'll also convert it to a factor.
#We can use the transform method to change the in built type of each of these features.
data <- transform(data,
                  Age=as.integer(Age),
                  Sex=as.factor(Sex),
                  Chest_pain_type=as.factor(Chest_pain_type),
                  Resting_blood_pressure=as.integer(Resting_blood_pressure),
                  Serum_cholestrol=as.integer(Serum_cholestrol),
                  Fasting_blood_sugar=as.factor(Fasting_blood_sugar),
                  Resting_Electrocardiographic_results=as.factor(Resting_Electrocardiographic_results),
                  Max_heart_rate=as.integer(Max_heart_rate),
                  Exercise_induced_angina=as.factor(Exercise_induced_angina),
                  Old_peak=as.numeric(Old_peak),
                  Slope=as.factor(Slope),
                  ca=as.factor(ca),
                  thai=as.factor(thai),
                  Heart_D=as.factor(Heart_D)
)

str(data)

#If we, again, print summary of dataset, we get features with appropriate data type.
summary(data)

#Identifying Missing Values in dataset:
data[ data == "?"] <- NA

#we can use the colSums function to view the missing value counts of each column.
colSums(is.na(data))

#Handling Missing Values

#We're  going to replace the missing values for "thai" with level which has occurred max no. of times. 
m<-table(data$thai)
m
#As level "3" has max occurrence, replacing missing values with "3".
data$thai[which(is.na(data$thai))] <- as.factor("3")

#Next, we're going to drop the rows where "ca" is missing.
data <- data[!(data$ca %in% c(NA)),]

#we can use the colSums function to view the missing value counts of each column.
colSums(is.na(data))

#If we run summary again, we'll see that it still views ? as a potential class.
summary(data)

#To get around this issue, we cast the columns to factors again.
data$ca <- factor(data$ca)
data$thai <- factor(data$thai)
summary(data)

#Split the dataset in Train/Test data----
#Prep Training and Test data.----
View(data)
trainDataIndex <- sample(1:nrow(data),0.75*nrow(data), replace = F)
trainData <-data[trainDataIndex, ]
testData <- data[-trainDataIndex, ]
View(trainData)
View(testData)

#Building the model on train dataset:
rf <- randomForest( Heart_D ~ .,data=trainData)

#Validating the model on test dataset:
#Now, we use our model to predict whether the people in our testing set have heart disease.
pred = predict(rf, newdata=testData[-14])

#Accuracy
#Since this is a classification problem, we use confusion matrix to evaluate the performance of model:

cm = table(testData[,14], pred)
cm

accuracy_Test <- sum(diag(cm)) / sum(cm)
accuracy_Test
#Hence, the accuracy of our prediction is 78.66 %.
