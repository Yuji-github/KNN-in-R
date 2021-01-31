# KNNN
library(caTools)
library(class) # for KNN classifier

# import data 
dataset = read.csv('Social_Network_Ads.csv')

#remove unnecessary data 
dataset = dataset[2:5]

# encoding gender 
dataset$Gender = factor(dataset$Gender, levels = c('Male', 'Female'), 
                        labels = c(0, 1))

# check data type 
typeof(dataset$Age)
typeof(dataset$EstimatedSalary)
typeof(dataset$Gender)
# all integers, but must convert to integer for feature scaling 
dataset$Gender = as.integer(dataset$Gender)

# splitting dataset 
seed(123)
split = sample.split(dataset$Purchased, SplitRatio = 0.75)
train = subset(dataset, split == TRUE)
test = subset(dataset, split == FALSE)

# feature scaling '-' means except 
train[-4] = scale(train[-4])
test[-4] = scale(test[-4])

# training/fit KNN and predicting the test results
# cl is dependent variables 
# k is umber of neighbors 
y_pred = knn(train = train[, 1:3], test = test[, -4], cl = train[, 4], k=5)  
  
# prediction NO Need for KNN
# y_pred = predict()  
  
# confusion matrix 
cm = table(test[, 4], y_pred)
print(cm)
