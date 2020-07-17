# Coercion Rules in R
# R will automatically convert between built-in object types when appropriate. 
# R will convert from more specific types to more general types.

#define a vector x
x <- c(1, 2, 3, 4, 5)
x
class(x)

#Let's change the second element of the vector to the word "hat." 
x[2] <- "hat"
x
class(x)

#R will change the object class to character and change all the elements in the vector to char

#Let's change the third element of the vector to the "List" 
#Creating a list

#Creating a Vector with numeric from 1 up to 5
vect  <- 1:5

#Creating a 2x 5 matrix
mat  <- matrix(1:10, ncol = 5)
dim(mat)

# Creating a data frame by selecting the 10th row of the built-in R data set EuStockMarkets
df <- EuStockMarkets[1:10,]

# Construct list with these vec, mat, and df:
my_list <- list(vect, mat, df)
my_list

x[3] <- my_list[1]
x
class(x)

#Example 3:
x <- c(1:10,"a")
class(x)