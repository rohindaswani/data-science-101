setwd('~/Projects/personal/data-science-101')
library(utils)

realEstate = read.csv("realEstate.csv")
library(caret)

# Build a linear regression model in order to predict the price of houses from square feet
dataset = realEstate[,c("sq__ft","price")]

ggplot(dataset,aes(price,sq__ft))+ geom_point()+geom_smooth(se= FALSE)

model <- train(price ~.,data=dataset,method="lm")
model
model$finalModel

# price = 54.16 * sq__ft + 162930.16

# Split the data to half and repeat task 2 on the training set.
splitData = split(dataset, sample(1:2, nrow(dataset), replace=T))
testingData = unlist(splitData[2])

trainingData = do.call(rbind.data.frame, splitData[1])
testingData = do.call(rbind.data.frame, splitData[2])

ggplot(trainingData,aes(price,sq__ft))+geom_point() + geom_smooth(se=FALSE)
ggplot(testingData,aes(price,sq__ft))+geom_point() +geom_smooth(se=FALSE)

# price = 51.41 * sq__ft + 165692.98
modelSplit <- train(price ~.,data=trainingData,method="lm")
modelSplit
modelSplit$finalModel
predictedPrice= as.numeric(predict(modelSplit,testingData))

# 4- Use your model in task 3 to predict prices in the test data and measure RMSE and R-Squared for your predictions.
mean(abs(testingData$price-predictedPrice)) # 95717.49
RMSE(testingData$price,predictedPrice) #129737.3

# 5- Use “beds”, “baths” and “sq__ft” to predict “prices” using multiple linear regression. Train on the first half of the data and measure RMSE and R-Squared on
# the Test set. Compare results with task 4.
dataset = realEstate[,c('beds','baths','sq__ft','price')]
ggplot(dataset,aes(price,sq__ft,color=baths))+ geom_point()+geom_smooth(se= FALSE)

splitData = split(dataset, sample(1:2, nrow(dataset), replace=T))
trainingData = do.call(rbind.data.frame, splitData[1])
testingData = do.call(rbind.data.frame, splitData[2])

modelBath <- train(price ~.,data=trainingData,method="lm")
modelBath
modelBath$finalModel
predictedPrice = as.numeric(predict(modelBath,testingData))

mean(abs(testingData$price-predictedPrice)) #97636.94
RMSE(testingData$price,predictedPrice) # 130857.2
