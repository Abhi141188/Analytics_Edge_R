#Operators in R: sort, rank, order.

# Creating data set by combining 4 variables of same length.
# Create a, b, c, d variables
a <- c(10,20,30,40)
b <- c('book', 'pen', 'textbook', 'pencil_case')
c <- c(TRUE,FALSE,TRUE,FALSE)
d <- c(2.5, 8, 10, 7)
# Join the variables to create a data frame
df <- data.frame(a,b,c,d)
df
#Sort()
#You can sort your data according to certain variable in dataset using order() fxn.
# Sort by column 'd' in dataset df in ascending order.
df1 <-df[order(df$d),]
head(df1)
# Sort by column 'd' in dataset df in descending order.
df2 <-df[order(-df$d),]
head(df2)

#sort, rank, order, sample using dataset "mtcars".
head(mtcars)

#sort by mpg
sort(mtcars$mpg) # one column
sort(mtcars$mpg, decreasing = T) # one column

mtcars[order(mtcars$mpg),][1:5] #Sort DF by mpg

mtcars[order(mtcars$cyl, mtcars$mpg), c('cyl','mpg','wt')] #Sort DF by cyl, mpg

mtcars[order(mtcars$cyl, -mtcars$mpg), c('cyl','mpg','wt')] # desc mpg

# rank():
x=c(1,2,36,3)
rank(x)
rank(mtcars$mpg, ties.method = 'min')
# rank(mtcars$mpg, ties.method = 'max')
rorder =cbind(mtcars$mpg, rank(mtcars$mpg, ties.method = 'max'))
rorder
