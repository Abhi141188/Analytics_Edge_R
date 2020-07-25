#Few functions for Data Summarization on Data Frames:

# table()-tells the frequency of occurence of each variable category in the dataset.
# xtabs()- tells the relationship between two categorical variables
# aggregate()- Splits the data into subsets, computes summary statistics for each.
# 
mtcars
View(mtcars)

#table-------
table(mtcars$cyl)

table(mtcars$cyl, mtcars$gear)
t1 = table(mtcars$cyl, mtcars$gear, dnn=c('cyl', 'gear'))
t1

table(mtcars$cyl)
table(mtcars$gear)
table(mtcars$cyl,mtcars$gear)  #count Gear vs Cyl
#1 cars with gear4 and cyl3

table(mtcars$cyl,mtcars$gear, dnn=c('Cyl','Gear'))  
#count Gear vs Cyl ; dnn - dimension names

table(mtcars$cyl,mtcars$gear, mtcars$carb)  #3 dim
#Matrix-Carb8 - rows-gear, col-Cyl

# Cross tabulation
#xtabs------
?xtabs
xtabs(~ cyl + gear, data=mtcars)
xtabs(~ cyl + gear + carb, data=mtcars)

#aggregate-------
?aggregate

#formula method
aggregate(mpg ~ gear, data=mtcars, FUN=mean)

#mean of mpg & hp wrt gear types
aggregate(cbind(mpg, hp) ~ gear, data=mtcars, FUN=mean)

#mean of mpg wrt gear & cyl types
aggregate(mpg ~ gear + cyl, data=mtcars, FUN=mean)

#mean of mpg, hp & wt wrt gear & cyl types
aggregate(cbind(mpg,hp,wt) ~ gear + cyl, data=mtcars, FUN=mean)

#Various types of "table" commands

#addmargins, margin.table, prop.table

mtcars
str(mtcars)

#margin table------------
#sums values over margin
?margin.table
t1 = table(mtcars$cyl, mtcars$gear, dnn=c('cyl', 'gear'))
t1
margin.table(t1)

margin.table(x=t1, margin=1) #cylwise
#margin-1 : rows

margin.table(x=t1, margin=2)  #gearwise
#margin-2 : columns

#addmargins fxn---------
#Used to add different functions as rows/columns over the margins

?addmargins
addmargins(A=t1, margin=1) #default is sum; sum of each column, shown as row
addmargins(A=t1, margin=2, FUN=mean)  #mean of each row shown as column
addmargins(A=t1, margin=c(1,2), FUN=sum)  #sum at both row and column
addmargins(A=t1, margin=c(1,2), FUN=c(sum,mean))  #two function on rows/ col margins
#different functions in rows and columns
addmargins(A=t1, margin=c(1,2), FUN=list(list(sum,mean,length), list(sd, sum)))

#prop.table-------
?prop.table
#This fxn basically calculates proportion of values 
t1
prop.table(t1)
#Cyl4, Gear3 : 1 out of 32 = 1/32

prop.table(t1, margin=1)  #sum of each row=1
#Cyl4, Gear 3 : 1 out of 11 Cyl4 cars : 1/11

prop.table(t1, margin=2)  #sum of each col=1
#Cyl4, Gear 3 : 1 out of 15 Gear3 cars : 1/15

matrix(paste(prop.table(x=t1)*100 ,'%', sep=''), ncol=3)

#quick check
rowSums(prop.table(t1, margin=1))  #correct
#rowSums(prop.table(t1, margin=2))

colSums(prop.table(t1, margin=2))

#transpose----
m1<-t(t1) 
m1

#sweep----
sweep(m1, MARGIN = 1, STATS = c(2,3,4), FUN="+" ) #rowise
sweep(m1, MARGIN = 2, STATS = c(2,3,4), FUN="*" ) #colwise

#addmargins----
m2 <- matrix(1:10, nrow=3)
m2
addmargins(m2,1,sum) #colwise function
addmargins(m2,2,mean) #rowwise function
addmargins(m2,c(1,2),mean) #row & col wise function
addmargins(m2,c(1,2),list(list(mean,sum), list(var,sd))) #row & col wise function

