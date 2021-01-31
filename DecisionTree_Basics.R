#Decision Tree- 
#Regression: Predicting Continuous Dependent Var Values.
#Classification: Predicting Categorical Dependent Var Values.
#Pruning:It is a technique used in determining the size of the tree.

#install.packages("rpart")
#install.packages("rpart.plot")
library("rpart")
library("rpart.plot")
#Read dataset----
?iris
data("iris")
data_iris <- iris
View(data_iris)

#explore iris data set structure by str() command.
str(iris)

#Create training dataset and testing dataset----
indexes = sample(150, 110)
iris_train = iris[indexes,]
iris_test = iris[-indexes,]
View(iris_train)
View(iris_test)

#Build and plot model----
#Classification Decision Tree-
ctree = rpart(Species ~., data = iris_train, method = "class")
ctree
rpart.plot(ctree)

#Predicting:----
#Classification Tree: Predicting whether the species is "Setosa" or not,
iris_test$Prediction_Species = predict(ctree, iris_test, type = 'class')
View(iris_test)

#Accuracy (Confusion Matrix)

#Regression Tree-
rtree = rpart(Sepal.Length ~., data = iris_train, method = "anova")
rpart.plot(rtree)
print(ctree)

#Predicitng:----
#Regression Tree: Predicting the lenth of Sepal,
iris_test$Prediction_Sepal.Length = predict(rtree, iris_test)
View(iris_test)

#Accuracy (MAPE)

#Pruning----
tree_ms5 = rpart(Species~., iris_train,control = rpart.control(minsplit = 5))
rpart.plot(tree_ms5, main = "minsplit=5")

