#            Estimate Insurance Premium             #
#              Multiple Regression                  #
#---------------------------------------------------#
#----Read the dataset------
getwd()
setwd("F:/rWork/rProjects/Analytics_Edge/Analytics_Edge_R")
Plan_Dataset <- read.csv("data/InsurancePlanSubscriptions-2017.csv")
View(Plan_Dataset)
df <- Plan_Dataset
View(df)

# Recasting Independent Variables

#install.packages("RH2")
#install.packages("sqldf")
#install.packages("proto")
#install.packages("gsubfn")
#install.packages("RSQLite")

# -----------------------  States --------------------------------
# To check Plan Subscription ratio in dataset
table(df$Home_state)/nrow(df)
# Avg Premium by state# To check Plan Subscription ratio in dataset
library(sqldf)
sqldf("select Home_state, COUNT (*) as obs, avg(Annual_EE_Contri) from df GROUP BY 1")
#Create dummy variables for states:
#Since here out of 20 states only 4 have large/significant no. of obs,so lets consider its no. of levels as 3.
#Hence, the no. of dummy var here will be 4-1 = 3.(i.e. State8 & State6, remaining will go in third state.)
insurance_premium1 <- df
insurance_premium1$State1 <- ifelse(df$Home_state=='Utah',1,0)
insurance_premium1$State2 <- ifelse(df$Home_state=='California',1,0)
insurance_premium1$State3 <- ifelse(df$Home_state=='Idaho',1,0)

View(insurance_premium1)
#-------------------------- Marital Status ----------------------
table(df$marital_status)/nrow(df)
# Avg Premium by marital status
sqldf("select marital_status, count(*) as obs, avg(Annual_EE_Contri)  from df group by 1")
#Create dummy variables for marital status:
#Since here the no. of significant levels are 2.
#Hence,the no. of dummy var here will be 2-1 = 1.(i.e. Marital_status1 & Marital_status2, remaining will go in third status)
insurance_premium1$Marital_status1 <- ifelse(insurance_premium1$marital_status=='MARRIED',1,0)

View(insurance_premium1)
#------------------------------------------------
#---------------------Company Division---------------------------
table(df$Employee_Division)/nrow(df)
# Avg Premium by location
sqldf("select Employee_Division, count(*) as obs, avg(Annual_EE_Contri)  from df  group by 1")
#Create dummy variables for Division
#Here the no. of levels are 5 but no. of observations are high in only 2 levels.
#Hence,no.of dummy var will be 2-1 = 1.
insurance_premium1$Division_1 <- ifelse(insurance_premium1$Employee_Division=='IHUT1',1,0)

View(insurance_premium1)
#---------------------Age_Grp--------------------------
table(df$Age_Grp)/nrow(df)
# Avg Premium by Age_Grp
sqldf("select Age_Grp, count(*) as obs, avg(Annual_EE_Contri)  from df  group by 1")
#Create dummy variables for Age_Grp
#Here the no. of levels are 3 and all 3 have large no. of observations.
#Hence,no.of dummy var will be 3-1=2.
insurance_premium1$Age_Grp1 <- ifelse(insurance_premium1$Age_Grp=='Millennials [15-36]yrs',1,0)
insurance_premium1$Age_Grp2 <- ifelse(insurance_premium1$Age_Grp=='Generation X [37-52]yrs',1,0)

View(insurance_premium1)
#---------------------Gender--------------------------
table(df$Gender)/nrow(df)
# Avg Premium by Gender
sqldf("select Gender, count(*) as obs, avg(Annual_EE_Contri)  from df  group by 1")
#Create dummy variables for Gender
#Here the no. of levels are 2 but only 2 have large no. of observations.
#Hence,no.of dummy var will be 2-1= 1.
insurance_premium1$Gender1 <- ifelse(insurance_premium1$Gender=='Male',1,0)

View(insurance_premium1)
#---------------------Annual_Salary_Bucket--------------------------
table(df$Annual_Salary_Bucket)/nrow(df)
# Avg Premium by Annual_Salary_Bucket
sqldf("select Annual_Salary_Bucket, count(*) as obs, avg(Annual_EE_Contri)  from df  group by 1")
#Create dummy variables for Annual_Salary_Bucket
#Here the no. of levels are 4 and all 4 have significant no. of observations.
#Hence,no.of dummy var will be 4-1= 3.
insurance_premium1$Annual_Salary_Bucket1 <- ifelse(insurance_premium1$Annual_Salary_Bucket=='$40,000 to $80,000',1,0)
insurance_premium1$Annual_Salary_Bucket2 <- ifelse(insurance_premium1$Annual_Salary_Bucket=='$80,000-$1,20,000',1,0)
insurance_premium1$Annual_Salary_Bucket3 <- ifelse(insurance_premium1$Annual_Salary_Bucket=='Less than $40,000',1,0)

View(insurance_premium1)
#---------------------Exp_Within_Org--------------------------
table(df$Exp_Within_Org)/nrow(df)
# Avg Premium by Exp_Within_Org
sqldf("select Exp_Within_Org, count(*) as obs, avg(Annual_EE_Contri)  from df  group by 1")
#Create dummy variables for Exp_Within_Org
#Here the no. of levels are 4 but 3 have significant no. of observations.
#Hence,no.of dummy var will be 3-1= 2.
insurance_premium1$Exp_Within_Org1 <- ifelse(insurance_premium1$Exp_Within_Org=='A[0-10]yrs',1,0)
insurance_premium1$Exp_Within_Org2 <- ifelse(insurance_premium1$Exp_Within_Org=='B[11-20]yrs',1,0)

View(insurance_premium1)
#---------------------Employee.Class--------------------------
table(df$Employee_Class)/nrow(df)
# Avg Premium by Employee_Class
sqldf("select Employee_Class, count(*) as obs, avg(Annual_EE_Contri)  from df  group by 1")
#Create dummy variables for Employee.Class
#Here the no. of levels are 4 but 2 have significant no. of observations.
#Hence,no.of dummy var will be 2-1= 1.
insurance_premium1$Employee_Class1 <- ifelse(insurance_premium1$Employee_Class=='Full Time-Hourly',1,0)

View(insurance_premium1)
#---------------------Coverage_Level--------------------------
table(df$Coverage_Level)/nrow(df)
# Avg Premium by Coverage_Level
sqldf("select Coverage_Level, count(*) as obs, avg(Annual_EE_Contri)  from df  group by 1")

#Create dummy variables for Coverage.Level
#Here the no. of levels are 6 but 3 have significant no. of observations.
#Hence,no.of dummy var will be 3-1= 2.
insurance_premium1$Coverage.Level1 <- ifelse(insurance_premium1$Coverage_Level=='Employee',1,0)
insurance_premium1$Coverage.Level2 <- ifelse(insurance_premium1$Coverage_Level=='Employee, Spouse & Children',1,0)

View(insurance_premium1)
#-------Regression Model--------------
reg_ins_formula <- lm(Annual_EE_Contri ~ #State3+
                        #State2+
                        #State1+
                        #Marital_status1+#Division_1+
                        Age_Grp1+Age_Grp2+#Gender1+
                        #Annual_Salary_Bucket1+Annual_Salary_Bucket2+
                        #Annual_Salary_Bucket3+
                        #Exp_Within_Org1+#Exp_Within_Org2+
                        Employee_Class1+Coverage.Level1+Coverage.Level2,
                      data=insurance_premium1)
summary(reg_ins_formula)


#Initially, we took, dataset of 2017 as training data for building model.
#---Taking dataset of 2018 as test data.--------
setwd("F:/rWork/rProjects/Analytics_Edge/Analytics_Edge_R")
sm2 <- read.csv("data/InsurancePlanSubscriptions-2018.csv")
View(sm2)
#From the regression eqn/model build above, we can see that variables: 
#Age_Grp2, Age_Grp1,Employee.Class1, Coverage.Level2,Coverage.Level1
#are significant but they dont exist in 2018 dataset, so we add them in 2018 dataset
#and then run the predict function for predicitve modeling.

#Adding var column:Age_Grp2, Age_Grp1, Employee.Class1, Coverage.Level2,Coverage.Level1 in the 2018 dataset
sm2$Coverage.Level1 <- ifelse(sm2$Coverage_Level=='Employee',1,0)
sm2$Coverage.Level2 <- ifelse(sm2$Coverage_Level=='Employee, Spouse & Children',1,0)
sm2$Age_Grp1 <- ifelse(sm2$Age_Grp=='Millennials [15-36]yrs',1,0)
sm2$Age_Grp2 <- ifelse(sm2$Age_Grp=='Generation X [37-52]yrs',1,0)
sm2$Employee_Class1 <- ifelse(sm2$Employee_Class=='Full Time-Hourly',1,0)

View(sm2)
#Predict----
sm2$Pred_EE_Contri <- predict(reg_ins_formula,newdata=sm2)
View(sm2)

#Accuracy:----
#Determining Prediction accuracy on test dataset using MAPE

#MAPE(MeanAbsolutePercentageError): 
#Lower its value better is the accuracy of the model.

#MAPE Calculation:
mape <- mean(abs((sm2$Pred_EE_Contri - sm2$Annual_EE_Contribution))/sm2$Annual_EE_Contribution)
mape

# Mape using mape function
#install.packages("Metrics")
library(Metrics)
mape(sm2$Pred_EE_Contri,sm2$Annual_EE_Contribution)
