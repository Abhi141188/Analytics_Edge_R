#----Matrix----

# Let's construct two 5x2 matrix with a sequence of number from 1 to 10, 
# one with byrow = TRUE and one with byrow = FALSE to see the difference.

#Construct a matrix with 5 rows that contain the numbers 1 up to 10 and byrow=TRUE 
matrix_a <-matrix(1:10, byrow = TRUE, nrow = 5)
matrix_a
# Print dimension of the matrix with dim()
dim(matrix_a)

# Construct a matrix with 5 rows that contain the numbers 1 up to 10 and byrow=FALSE
matrix_b <-matrix(1:10, byrow = FALSE, nrow = 5)
matrix_b
# Print dimension of the matrix with dim()
dim(matrix_b)

# Construct a matrix with 5 rows that contain the numbers 1 up to 10 with byrow not mentioned.
matrix_c <-matrix(1:10, nrow = 5)
matrix_c
# Hence, by default, byrow is set to FALSE in a matrix if not mentioned explicitely.

# Matrix object Properties
mx= matrix(1:24,nrow=6)
class(mx)
dim(mx)

# Add a Column to a Matrix with the cbind()
# concatenate c(1:5) to the matrix_a
matrix_a1 <- cbind(matrix_a, c(1:5))
# Check the dimension
dim(matrix_a1)
matrix_a1

# Add a row to a Matrix with the rbind()
# Append to the matrix
matrix_a2 <- rbind(matrix_a, c(1:2))
# Check the dimension
dim(matrix_a2)
matrix_a2

--------------------------------------------------
#Slice a Matrix:
#We can select one or many elements from a matrix by using the square brackets [ ]. 
#This is where slicing comes into the picture.
#Example:
#Below cmd selects the element at the first row and second column of matrix a2.
matrix_a2[1,2] 
#Below cmd results in a matrix with data on the rows 1, 2, 3 and columns 1, 2.
matrix_a2 [1:3,1:2] 
#Below cmd selects all elements of the first column.
matrix_a2[,1] 
#Below cmd selects all elements of the first row.
matrix_a2[1,] 

#Matrix-----
(m1 = matrix(1:12, nrow=4))

#Add names of cols and rows in matrix

(colnames(m1) = paste('C',1:3, sep=''))
(rownames(m1) = paste('R',1:4, sep=''))
m1

# Conversion: Vector to Matrix
(m3 = 1:24)
dim(m3)= c(6,4)
m3

#access elements
(m2 = matrix(1:12, ncol=3, byrow=T))
m2
m2[1,]  #first row
m2[c(1,3,4),]  #1st,3rd,4th row

m2[,1]  #first col
m2[,2:3] # 2nd to 3rd coln

m2[c(1,2),c(2,3)]
m2[,]
m2[-2,] # exclude 2nd row
m2[1:8] # matrix is like vector
m2[m2 > 5]

#modify Vector
m2[2,2]
m2[2,2] = 10
m2
m2[m2> 10] = 99
m2


#row and col wise summary
m1
colSums(m1); 
rowSums(m1)
colMeans(m1); 
rowMeans(m1)

# transpose
t(m1) 
m1


