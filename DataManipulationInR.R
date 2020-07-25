#----Data Manipulation in Data.Frames----

# select(): It is used to select columns of interest from a data set
# filter(): It filters the data based on a condition
# arrange(): It is used to arrange data set values on ascending or descending order
# mutate(): It is used to create new variables from existing variables
# summarise(with group_by): It is used to perform analysis by commonly used operations such as min, max, mean count etc.

# select()
#install.packages("dplyr")
library(dplyr)
# Creating data set by combining 4 variables of same length.
# Create a, b, c, d variables
a <- c(10,20,30,40)
b <- c('book', 'pen', 'textbook', 'pencil_case')
c <- c(TRUE,FALSE,TRUE,FALSE)
d <- c(2.5, 8, 10, 7)
# Join the variables to create a data frame
df <- data.frame(a,b,c,d)
df

step_1_df <- select(df, a,b,c)
dim(df)
dim(step_1_df)
step_1_df

# filter()
# Select observations
select_f1 <- filter(df, b == "book")
select_f1
dim(select_f1)

select_f2 <- filter(df, c == "TRUE")
select_f2
dim(select_f2)

#use filter to filter data with required condition
mynewdata <- mtcars
filter(mynewdata, cyl > 4 & gear > 4 )
filter(mynewdata, cyl > 4)

#use select to pick columns by name
select(mynewdata, cyl,mpg,hp)

#here you can use (-) to hide columns
select(mynewdata, -cyl, -mpg ) 
# or use the command below
select(mynewdata, -c(cyl,hp))

#select series of columns
select(mynewdata, cyl:gear)

#chaining or pipelining - a way to perform multiple operations in one line
mynewdata %>% select(cyl, wt, gear)%>% filter(wt > 3)

#arrange can be used to reorder rows in ascending order.
mynewdata%>% select(cyl, wt, gear)%>% arrange(wt)

mynewdata%>% select(cyl, wt, gear)%>% arrange(desc(wt))

#mutate - create new variables
mynewdata %>% select(mpg, cyl)%>% mutate(newvariable = mpg*cyl)

# summarise()- this is used to find insights from data
?iris
myirisdata <- iris
View(myirisdata)

myirisdata%>% group_by(Species)%>%
  summarise(Average = mean(Sepal.Length, na.rm = TRUE))

#or use summarise each
View(myirisdata%>% group_by(Species)%>% 
  summarise_each(funs(mean, median), Sepal.Length, Sepal.Width))

#you can rename the variables using rename command
mynewdata %>% rename(miles = mpg)

#----Merging various datasets using joins----
# Creating two data frame tables: df_primary & df_secondary

library(dplyr)

df_primary <- tribble(
  ~ID, ~y,
  "A", 5,
  "B", 5,
  "C", 8,
  "D", 0,
  "F", 9)
df_secondary <- tribble(
  ~ID, ~y,
  "A", 30,
  "B", 21,
  "C", 22,
  "D", 25,
  "E", 29)

View(df_primary)

View(df_secondary)

# left join()
left_join(df_primary, df_secondary, by ='ID')

# right_join()
right_join(df_primary, df_secondary, by = 'ID')

# inner_join()
inner_join(df_primary, df_secondary, by ='ID')

# full_join()
full_join(df_primary, df_secondary, by = 'ID')







