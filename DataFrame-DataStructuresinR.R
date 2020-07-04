#----Data Frame----
#We can create a dataframe by combining variables of same length.
# Create a, b, c, d variables
a <- c(10,20,30,40)
b <- c('book', 'pen', 'textbook', 'pencil_case')
c <- c(TRUE,FALSE,TRUE,FALSE)
d <- c(2.5, 8, 10, 7)
# Join the variables to create a data frame
df <- data.frame(a,b,c,d)
df

#We can see the column headers have the same name as the variables. 
#We can change the column name with the function names()
names(df) <- c('ID', 'items', 'store', 'price')
df

# Print the structure
str(df)
# Note: By default, data frame returns string variables as a factor.
str(df) #structure of DF
head(df) #top 6 rows
head(df,n=3) #top 3 rows
tail(df) #last 6 rows
View(df)
class(df) # DF
summary(df) #summary
#Slice Data Frame: 
#We select rows and columns to return into bracket preceded by the name of the data frame

## Select row 1 in column 2
df[1,2]

## Select Rows 1 to 2
df[1:2,]

## Select Columns 1
df[,1]

## Select Rows 1 to 3 and columns 3 to 4
df[1:3, 3:4]

#It is also possible to select the columns with their names.
## Slice with columns name
df[, c('ID', 'store')]

#Append a Column to Data Frame (use the symbol $ to append a new variable.)
# Create a new vector
quantity <- c(10, 35, 40, 5)
# Add `quantity` to the `df` data frame
df$quantity <- quantity
df

#Note:The number of elements in the vector has to be equal to the no of elements in data frame. 
#Hence, executing the below statement will give error
quantity <- c(10, 35, 40)
# Add `quantity` to the `df` data frame
df$quantity <- quantity

#Selecting a Column of a Data Frame.
# Select the column ID
df$ID

#Subsetting a Data Frame based on some condition.(we will use subset() fxn for this)
# Select price above 5
subset(df, subset = price > 5)



