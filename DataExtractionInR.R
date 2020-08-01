# Data Extraction/importing data in R
#read / write Data - from/to File

# Exporting data

# Export to Hard drive----
#To begin with, you can save the data directly into the working directory. The following code prints the path of your working directory:
directory <-getwd()
directory

mtcars  #inbuilt datasets
data()  #other datasets

# Import/Export of dataset using CSV files--------------------

#------------------Writing the dataset---------------------
#Method 1:
write.csv(mtcars, "mtcars2.csv")

#Method 2:
#make sure you have a folder : "data" in your project directory
#like c1, c2, c3, c4, c5
write.csv(x=mtcars, file='data/mtcars1.csv')
write.csv(x=mtcars, file='data/mtcars2.csv', row.names = F)
#save it in "data" folder .

#--------------Read the dataset------------------------
# Method 1:
f<- file.choose()
c1 <- read.csv(f)

# Method 2:
c_1 <- read.csv("data/mtcars1.csv")
View(c_1)

newmtcars1 = read.csv(file='data/mtcars2.csv')
head(newmtcars1)
#no car names
