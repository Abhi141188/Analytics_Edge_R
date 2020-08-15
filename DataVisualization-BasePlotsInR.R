# Base Plots in R:

#bar Plot in R----
#count of categories.
#We can build them using the barplot() function available in base R.
View(mtcars)
cylinders = table(mtcars$cyl)
cylinders
barplot(table(mtcars$cyl))

barplot(table(mtcars$am))
barplot(table(mtcars$gear), 
        col=1:3, main='No of cars of each gear type', xlab='Gear Type', ylab='Count of Cars')

c = table(mtcars$carb)
c
barplot(table(mtcars$carb), col=1:5, horiz = T)

#---------------------------------------------------------------------------

#box Plot----
#used for continuous values to depict 5 number summary.
#We can build them using the boxplot() function available in base R.
mtcars
summary(mtcars$mpg)
quantile(mtcars$mpg)

#box plot with line showing mean of mpg 
boxplot(mtcars$mpg)
abline(h=mean(mtcars$mpg))

#box plot with lines showing quantile values of mpg 
boxplot(mtcars$mpg, col='green')
abline(h=quantile(mtcars$mpg))  

qvalues = c(10, 20, 30)
#box plot with lines showing user defined points
boxplot(mtcars$mpg, col='yellow')
abline(h=qvalues, col=1:3)  
#specifying col 1 to 3 : maps to R colours

#--------------------------
#Line Plots in R----
#We can build them using the plot() function available in base R.

#plot
X=1:10
Y=11:20
plot(x=X, y=Y)
plot(x=X, y=Y, type='s') #points
plot(x=X, y=Y, type='p', pch=11) #points, plotting symbol=13
#see internet for different plotting symbols
plot(x=X, y=Y, type='p', cex=2) #points, double the size

#Another Example of Line Plots:

x <- c(1:5); y <- x # create some data 
par(mfrow=c(2,4)) # all plots on one page 
opts = c("p","l","o","b","c","s","S","h") 
for(i in 1:length(opts)){ 
  heading = paste("type=",opts[i]) 
  plot(x, y, type="n", main=heading) 
  lines(x, y, type=opts[i]) 
}

# Create Line Chart
?Orange
View(Orange)
str(Orange)
# convert ordinal factor to numeric for convenience 
Orange$Tree <- as.numeric(Orange$Tree) 
ntrees <- max(Orange$Tree)

# get the range for the x and y axis 
xrange <- range(Orange$age) 
yrange <- range(Orange$circumference) 

# set up the plot 
plot(xrange, yrange, type="n", xlab="Age (days)",
     ylab="Circumference (mm)" ) 
colors <- rainbow(ntrees) 
linetype <- c(1:ntrees) 
plotchar <- seq(18,18+ntrees,1)

# add lines 
for (i in 1:ntrees) { 
  tree <- subset(Orange, Tree==i) 
  lines(tree$age, tree$circumference, type="b", lwd=1.5,
        lty=linetype[i], col=colors[i], pch=plotchar[i]) 
} 

# add a title and subtitle 
title("Tree Growth", "example of line plot")

# add a legend 
legend(xrange[1], yrange[2], 1:ntrees, cex=0.8, col=colors,
       pch=plotchar, lty=linetype, title="Tree")


#--------------------------
#Scatterplot & Pairs plots in R----
#We can build them using the plot() function available in base R.

X=1:10
Y=11:20
plot(x=X, y=Y)
mtcars
plot(mtcars$wt, mtcars$mpg, main="Scatterplot Example", 
     xlab="Car Weight ", ylab="Miles Per Gallon ", pch=11)

plot(x=mtcars$wt, y=mtcars$mpg)

df<-mtcars
plot(x=df$wt, y=df$mpg, col=df$am)

#add more features
plot(x=df$wt, y=df$mpg, col=df$cyl)
#3 colors wrt to each cyl : how to find which cylinder

plot(x=df$wt, y=df$mpg, col=df$cyl, cex=2)
plot(x=df$wt, y=df$mpg, col=df$cyl, cex=df$gear)
#using am and vs will not work for cex as they have 0 values also
plot(x=df$wt, y=df$mpg, col=df$cyl, cex=df$am) 

plot(x=mtcars$wt, y=mtcars$mpg)
#Negative Relationship : wt increase, mpg reduces

#Pairs Plot using scatter plots
#The pairs R function returns a plot matrix,consisting of scatterplots 
#for each variable-combination of a data frame.
View(mtcars)
pairs(~mpg+disp+drat+wt,data=mtcars, 
      main="Pair plot")

View(iris)
pairs(~Sepal.Width+Sepal.Length+Petal.Width+Petal.Length,data=iris, 
      main="Pair plot")

#--------------------------
#Correlation Plot in R----
#Use cor( ) function to produce correlations in R and
#we use function corrgram( ) to plot correlograms in R.

# mtcars dataset is natively available in R
head(mtcars)
# Correlation matrix from mtcars
# with mpg, cyl, and disp as rows 
# and hp, drat, and wt as columns 
x <- mtcars[1:3]
y <- mtcars[4:6]
z<-cor(x, y)
z

#We use function corrplot( ) in package "corrplot" to plot correlograms.
#install.packages("corrplot")
library(corrplot)
corrplot(z, type = "upper", 
         tl.col = "black", tl.srt = 45)

#We use function corrgram( ) in package "corrgram" to plot correlograms.
#install.packages("corrgram")
library(corrgram)

# First
corrgram(mtcars, order=TRUE, lower.panel=panel.shade, 
         upper.panel=panel.pie, text.panel=panel.txt, 
         main="Car Milage Data in PC2/PC1 Order") 

# Second
corrgram(mtcars, order=TRUE, lower.panel=panel.ellipse, 
         upper.panel=panel.pts, text.panel=panel.txt, 
         diag.panel=panel.minmax, main="Car Milage Data in PC2/PC1 Order") 

# Third
corrgram(mtcars, order=NULL, lower.panel=panel.shade, 
         upper.panel=NULL, text.panel=panel.txt, 
         main="Car Milage Data (unsorted)")
#--------------------------
#pie chart in R----
#We can build them using the pie() function available in base R.
x = c(10,20,40,50)
pie(x)
xlabels = c('A','B','C','D')
pie(x, labels=xlabels)

#pie on mtcars
(cylinders = table(mtcars$cyl))
pie(x=cylinders)
pie(x=cylinders, labels=c('4-Cyl','6-Cyl','8-Cyl'))
pie(x=cylinders, labels=paste(c('4-Cyl','6-Cyl','8-Cyl'),'\n', cylinders, ' cars', sep='-')) #'\n' wraps the output

#--------------------------
#Mosaic Plots----
#We can build them using the mosaic() function available in base R.

# Mosaic Plot Example
#install.packages("vcd")
library(vcd)
HairEyeColor
View(HairEyeColor)
mosaic(HairEyeColor, shade=TRUE, legend=TRUE)

dftable <- xtabs(  ~ gear + cyl, data=df)
mosaic(dftable, shade=TRUE, legend=TRUE)

dftable_1 <- xtabs(  ~ gear + cyl + am, data=df)
mosaic(dftable_1, shade=TRUE, legend=TRUE)

#Include shade=TRUE to color the figure, and legend=TRUE to display a legend for the Pearson residuals.
#mosaic plot
mosaicplot(~ gear + cyl, data = df, shade=T, color = TRUE)

mosaicplot(~ Sex + Age + Survived, data = Titanic, shade=T, color = TRUE)

#--------------------------
#Heat Maps in R----
#We can build them using the heatmap() function available in base R.

#The mtcars dataset:
data <- as.matrix(mtcars)

#Default Heatmap
heatmap(data)

#Using 'scale' to normalize
heatmap(data, scale="column")

#Native palette from R
heatmap(data, scale="column", col = cm.colors(256))
heatmap(data, scale="column", col = terrain.colors(256))

#Rcolorbrewer palette
library(RColorBrewer)
coul <- colorRampPalette(brewer.pal(8, "PiYG"))(25)
heatmap(data, scale="column", col = coul)

# Add classic arguments like main title and axis title
heatmap(data, Colv = NA, Rowv = NA, scale="column", col = coul, xlab="variable", ylab="car", main="heatmap")
#--------------------------

#Adding Labels, Title, Legend in Base Plots----

#Adding Legend: Add a legend with the legend() function.
attach(mtcars)
boxplot(mpg~cyl, main="Milage by Car Weight",
        ylab="cylinders", xlab="Milage", horizontal=TRUE,
        col=terrain.colors(3))
legend("topright", inset=.05, title="Number of Cylinders",
       c("4","6","8"), fill=terrain.colors(3), horiz=TRUE)

#Titles: Use the title( ) function to add Title to a plot.
boxplot(mpg~cyl)+
title(main="main title", sub="sub-title")

#---------------------------------------------------------------------------
#--------------------------
#Histogram & Density Plots in R----
#We can build them using the hist() function available in base R.
# Simple Histogram
hist(mtcars$mpg)

# Colored Histogram with Different Number of Bins
hist(mtcars$mpg, breaks=10, col="red")

#Density plots:
#These plots are effective way to view the distribution of a variable.
#Density Plot
d <- density(mtcars$mpg) # returns the density data 
plot(d) # plots the results

# Filled Density Plot
d <- density(mtcars$mpg)
plot(d, main="Density of Miles Per Gallon")
polygon(d, col="red", border="blue")

#Comparing groups via density.
#Compare MPG distributions for cars with 
#4,6, or 8 cylinders
#install.packages("sm")
library(sm)
attach(mtcars)

# create value labels 
cyl.f <- factor(cyl, levels= c(4,6,8),
                labels = c("4 cylinder", "6 cylinder", "8 cylinder")) 

# plot densities 
sm.density.compare(mpg, cyl, xlab="Miles Per Gallon")
title(main="MPG Distribution by Car Cylinders")

View(women)
#histogram
hist(women$height, freq=TRUE)  #3 women between 58 and 60
#no of breaks auto calculated.

hist(women$height, breaks=4, col=1:4)
#Density Plot
d <- density(women$height)
plot(d, main="Density Plot of women height")

#--------------------------