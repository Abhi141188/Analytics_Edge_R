# Advanced Plots in R:Plot in R using ggplot Package----

#install.packages(ggplot2)
library(ggplot2)

#dataset
View(mtcars)

#Line Plots----
#To plot use geom_line() function in ggplot package.

# create data
xValue <- 1:10
yValue <- cumsum(rnorm(10))
data <- data.frame(xValue,yValue)

#Plot
ggplot(data, aes(x=xValue, y=yValue)) +
  geom_line()

#Customized plot
# Plot
ggplot(data, aes(x=xValue, y=yValue)) +
  geom_line( color="#69b3a2", size=2, alpha=0.9, linetype=2) +
  #theme_ipsum() +
  ggtitle("Evolution of something")

#----
#Area Plots----
#To plot use geom_area() function in ggplot package.
# create data
xValue <- 1:50
yValue <- cumsum(rnorm(50))
data <- data.frame(xValue,yValue)

#Plot
ggplot(data, aes(x=xValue, y=yValue)) +
  geom_area()

#Customized Plot
ggplot(data, aes(x=xValue, y=yValue)) +
  geom_area( fill="#69b3a2", alpha=0.4) +
  geom_line(color="#69b3a2", size=2) +
  geom_point(size=3, color="#69b3a2") +
  #theme_ipsum() +
  ggtitle("Evolution of something")

#----
#Box Plot----
#to plot it use geom_boxplot() function in ggplot package

# create a dataset
data <- data.frame(
  name=c( rep("A",500), rep("B",500), rep("B",500), rep("C",20), rep('D', 100)  ),
  value=c( rnorm(500, 10, 5), rnorm(500, 13, 1), rnorm(500, 18, 1), rnorm(20, 25, 4), rnorm(100, 12, 1) )
)
data
View(data)
# Plot
Plot1<-data %>%
  ggplot( aes(x=name, y=value, fill=name)) +
  geom_boxplot() +
  ggtitle("A boxplot") +
  xlab("")
Plot1
#Note:Box Plot is criticized for hiding the underlying distribution of each group. 
#Hence, for showing individual observation, we use jitter on top of boxes.
#To add invdividual observation on top of boxes, use geom_jitter() function.

#Libraries
#install.packages("tidyverse")
library(tidyverse)
#install.packages("hrbrthemes")
library(hrbrthemes)
Plot2<-data %>%
  ggplot( aes(x=name, y=value, fill=name)) +
  geom_boxplot() +
  geom_jitter(color="black", size=0.4, alpha=0.9) +
  #theme_ipsum() +
  theme(
    legend.position="none",
    plot.title = element_text(size=11)
  ) +
  ggtitle("A boxplot with jitter & theme") +
  xlab("")
Plot2
#----
#Histogram Plots:---- 
#using the geom_histogram() function
p1 <- ggplot(mtcars, aes(x=mpg)) + 
  geom_histogram()
p1

p2 <- ggplot(mtcars, aes(x=mpg)) + 
  geom_histogram(binwidth=30)
p2
#----
#Bar Plot----
#Use function:"geom_bar()" for making bar plot in R using ggplot package.

# Create data
data <- data.frame(
  name=c("A","B","C","D","E") ,  
  value=c(3,12,5,18,45)
)

ggplot(data, aes(x=name, y=value)) + 
  geom_bar(stat = "identity")

#Adding color to the bars of plot:
#Uniform color. Color is for the border, fill is for the inside
ggplot(mtcars, aes(x=as.factor(cyl) )) +
  geom_bar(color="blue", fill=rgb(0.1,0.4,0.5,0.7) )

#Using RColorBrewer
ggplot(mtcars, aes(x=as.factor(cyl), fill=as.factor(cyl) )) + 
  geom_bar( ) +
  scale_fill_brewer(palette = "Set1")# +
  #theme(legend.position="none")
#Note:To remove legends in this case, use function: theme(legend.position="none").

#----
#Pie Chart----
#ggplot2 does not offer any specific geom to build piecharts.
#The trick is to build a stacked barchart with one bar only using the geom_bar()
#function and making it circular with coord_polar()
# Create Data
data <- data.frame(
  group=LETTERS[1:5],
  value=c(13,7,9,21,2)
)

# Basic piechart
ggplot(data, aes(x="", y=value, fill=group)) +
  geom_bar(stat="identity") +
  coord_polar("y", start=0)

#Customized Piechart
ggplot(data, aes(x="", y=value, fill=group)) +
  geom_bar(stat="identity", color="white") +
  coord_polar("y", start=0) +
  theme_void() # used to remove background, grid, numeric labels

#Adding lables in pie char using geom_text()
# Compute the position of labels
#install.packages("dplyr")
library(dplyr)
library(ggplot2)
data <- data %>% 
  arrange(desc(group)) %>%
  mutate(prop = value / sum(data$value) *100) %>%
  mutate(ypos = cumsum(prop)- 0.5*prop )

# Basic piechart
ggplot(data, aes(x="", y=prop, fill=group)) +
  geom_bar(stat="identity", width=1, color="white") +
  coord_polar("y", start=0) +
  theme_void() + 
  theme(legend.position="none") +
  geom_text(aes(y = ypos, label = group), color = "white", size=6)

#----
#Heat Maps----
#Use function:"geom_tile()" for making heat maps in R using ggplot package.
# Library
library(ggplot2)

# Dummy data
x <- LETTERS[1:20]
y <- paste0("var", seq(1,20))
data <- expand.grid(X=x, Y=y)
data$Z <- runif(400, 0, 5)
View(data)
#Basic Heatmap 
ggplot(data, aes(X, Y, fill= Z)) + 
  geom_tile()

# Give extreme colors:

ggplot(data, aes(X, Y, fill= Z)) + 
  geom_tile() +
  scale_fill_gradient(low="white", high="blue") 

# Color Brewer palette
ggplot(data, aes(X, Y, fill= Z)) + 
  geom_tile() +
  scale_fill_distiller(palette = "RdPu")

# Color Brewer palette
#install.packages("viridis")
#library(viridis)
#ggplot(data, aes(X, Y, fill= Z)) + 
  #geom_tile() +
  #scale_fill_viridis(discrete=FALSE) 
  #theme_ipsum()

#----
#Scatter Plot----
#Use function:"geom_point()" for making scatter plot in R using ggplot package.
ggplot(mtcars, aes(x = drat, y = mpg)) +
  geom_point()

#Scatter plot with groups:
#To distinguish the values by a group of data (i.e. factor level data).
my_graph<-ggplot(mtcars, aes(x = mpg, y = drat)) +
  geom_point(aes(color = factor(gear)))
my_graph

#-------------------------------------------------------------------------------------

#To add information/lables to the graph with labs()function.----
my_graph +
  labs(
    title = "Plot Mile per hours and drat"
  )

#To add a title with a dynamic name----
#We can use paste() function to print static text and dynamic text.
A <-2010
paste("The first year is", A)

B <-2018
paste("The first year is", A, "and the last year is", B)

mean_mpg <- mean(mtcars$mpg)
my_graph + labs(
  title = paste("Plot Mile per hours and drat. Average mpg is", mean_mpg)
)

#To add a subtitle: we use "subtitle" & "caption" cmds:----
my_graph +
  labs(
    title =
      "Relation between Mile per hours and drat",
    subtitle =
      "Relationship break down by gear class",
    caption = "Computation using mtcars dataset"
  )

#To rename x-axis and y-axis----

my_graph +
  labs(
    x = "Drat definition",
    y = "Mile per hours",
    color = "Gear",
    title = "Relation between Mile per hours and drat",
    subtitle = "Relationship break down by gear class",
    caption = "Computation using mtcars dataset"
  )

#Themes:----
#R allows us to customize out plot with different themes.
#The library ggplot2 includes eights themes:theme_bw(),theme_light(),theme_classic(), 
#theme_linedraw(), theme_dark(), theme_minimal(),theme_gray(), theme_void()

Plot1<-my_graph +
  theme_bw() +
  labs(
    x = "Drat definition, in log",
    y = "Mile per hours, in log",
    color = "Gear",
    title = "Relation between Mile per hours and drat",
    subtitle = "Relationship break down by gear class",
    caption = "Authors own computation"
  )
Plot1

#Saving Plots:----
#We use cmd: ggsave('NAME OF THE FILE') to save the graph in our working directory.

directory <-getwd()
directory
ggsave("my_fantastic_plot.png")



