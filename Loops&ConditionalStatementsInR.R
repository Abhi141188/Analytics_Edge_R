
# Conditional Statements:----

#If-else statement----
# We want to examine whether a variable stored as "quantity" is above 20. 
# If quantity greater than 20, print "You sold a lot!" otherwise "Not enough for today."
# Create vector quantity
quantity <-  25
# Set the if-else statement
if (quantity > 20) {
  print('You sold a lot!')
} else {
  print('Not enough for today')  
}
 
# Else-if statement----
# We are interested to know if we sold quantities between 20 and 30. 
# If we did, then print: "Average day", if sold quantity is > 30 then print:
# "What a great day!", otherwise print: "Not enough for today".
# Create vector quantiy
quantity <-  10
# Create multiple condition statement
if (quantity <20) {
  print('Not enough for today')
} else if (quantity > 20  &quantity <= 30) {
  print('Average day')
} else {
  print('What a great day!')
}

# Loops: ----

# For Loop----

# Looping over a vector.---------------------------------
# Example 1: We iterate over all the elements of a vector and print the current value.
# Create fruit vector
fruit <- c('Apple', 'Orange', 'Passion fruit', 'Banana')
# Create the for statement
for ( i in fruit){ 
  print(i)
}

# Looping over a matrix.---------------------------------
# Example 3: A matrix has 2-dimension, rows and columns. 
# To iterate over matrix, we define two for loop:
# one for the rows and another for the column.

# Create a matrix
mat <- matrix(data = seq(1, 18, by=1), nrow = 6, ncol =3)

# Create the loop with r and c to iterate over the matrix
for (r in 1:nrow(mat))   
  for (c in 1:ncol(mat))  
    print(paste("Row", r, "and column",c, "have values of", mat[r,c])) 

# Looping over a list.--------------------
# Example 4:
# Create a list with three vectors
fruit <- list(Basket = c('Apple','Orange','Passion-fruit','Banana'), 
              Money = c(10, 12, 15), purchase = FALSE)

# Create a for loop
for (p in fruit) 
{ 
  print(p)
}

# While Loop----
# Example: We create a while loop and after each run add 1 to the stored variable. We need to close the loop, therefore we explicitely tell R to stop looping when the variable reached 3.

#Create a variable with value 1
begin <- 1
#Create the loop
while (begin <= 3){
  #See which we are  
  cat('This is loop number',begin)
  #add 1 to the variable begin after each loop
  begin <- begin+1
  print(begin)
}


#Infinite Loop if end condition not given:
#Create a variable with value 1
begin <- 1
#Create the loop
while (begin <= 3){
  #See which we are  
  cat('This is loop number',begin)
  #add 1 to the variable begin after each loop
 # begin <- begin+1
  print(begin)
}






