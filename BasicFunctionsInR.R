#----Various Functions in R----
?str()
# str()- Compactly display the internal structure of an R object/datasets. 
# names()- Names of elements within an object
# class()- Retrieves the internal class of an object/dataset.
# mode()- Get or set the type or storage mode of the dataset/object.
# length()- Retrieves the no. of elements in a dataset/object.
# dim()- Retrieve or set the dimension of the dataset/object.
# attributes()- Gives col & row names of the dataset/object.
# head()- Gives top 6 rows of the dataset.
# tail()- Gives bottom 6 rows of the dataset.
# View()- View dataset in seperate tab like excel.
# mean()- Average of all the numbers. 
# median()- The "middle" value in the list of numbers.
# quantile()- Gives quartiles of the dataset. 
# summary()- Gives the min, max & quartile values corresponding to each column of the dataset.

#----Examples:----
x <- c(1:10)
class(x)
str(x)
mode(x)
mean(x)
median(x)
length(x)

# Creating data set by combining 4 variables of same length.
# Create a, b, c, d variables
a <- c(10,20,30,40)
b <- c('book', 'pen', 'textbook', 'pencil_case')
c <- c(TRUE,FALSE,TRUE,FALSE)
d <- c(2.5, 8, 10, 7)
# Join the variables to create a data frame
df <- data.frame(a,b,c,d)
df
names(df)
length(df) 
dim(df)


#----mtcars data set - base R-----

?mtcars #help on dataset

mtcars #print dataset
View(mtcars)

str(mtcars) #structure of dataset
#can be used a matrix

dim(mtcars)#dimensions of dataset

class(mtcars)#class

attributes(mtcars) #col and rownames

names(mtcars) #colnames

colnames(mtcars) #colnames

rownames(mtcars) #rownames

head(mtcars) #top 6 rows 
tail(mtcars) #bottom 6 rows
head(mtcars,n=3) #top 3 rows

dim(mtcars)  #dimensions of DF 32 rows, 11 columns
NROW(mtcars)
length(mtcars) #variables nos

mtcars$mpg
length(mtcars$mpg)  #length of the vector

#Detailed summary of each column/variable in the dataset
summary(mtcars)

ncol(mtcars)
nrow(mtcars)

View(mtcars)  #View DF in seperate tab like excel

mtcars[1]  #print 1st column
mtcars$mpg[1] #1 in vectors print 1st position value in the vector
mtcars$mpg[3] #3 in vectors print 3rd position value in the vector

#Quantile fxn:
x = c(1,4,2, 20:300)
x
quantile(x)


# R Environment functions:
# ls()- returns all the variables present in the rscript.
# rm()- removes all the variables present in the rscript.
# install.packages()- used to install a package in our collection of packages in R
# whose functions we wish to use. Done only once.
# library()- Used when we wish to call the functions of an already installed package.
# help()- Gives details of the dataset

# ls()- returns all the variables present in the rscript.
ls()

# rm()- removes all the variables present in the rscript.
rm(list = ls())

# install.packages()- 
#used to install a package in our collection of packages in R
#install.packages("dplyr")
library(dplyr)

# help()- Gives details of the dataset
??dplyr
