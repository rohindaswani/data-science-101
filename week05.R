setwd('~/Projects/personal/data-science-101')
library(utils)
library(caret)

realEstate = read.csv("realEstate.csv")

# Step1: select the dataset for modeling
myData=realEstate[,c('beds','baths','sq__ft','price')]

# clean the data
myData=myData[-which(myData$sq__ft==0),]

# Step2: split to train and test
training=myData[seq(1,nrow(myData),2),]
testing=myData[seq(2,nrow(myData),2),]

# Step3: train the model
set.seed(14)
model=train(price ~.,method='rf',data=training)

# Step4: test the model
predictedPrices=predict(model,testing)

#Step5: measure accuracy
#MAE
mean(abs(predictedPrices-testing$price))
#RMSE
RMSE(predictedPrices,testing$price)
R2(predictedPrices,testing$price)

## Classification
iris = iris
ggplot(iris,aes(Sepal.Length,Petal.Length,color=Species))+geom_point()

#step1: select the data
myData=iris[,c(1,3,5)]
myData=iris

#step2: split the train and test dataset
training=myData[seq(1,nrow(myData),2),]
testing=myData[seq(2,nrow(myData),2),]

#step3: train the model
model=train(Species ~.,method="kknn",data=training)
model$finalModel

#step4: predict the species
predictedSpecies=predict(model,testing)

#step5: measure accuracy
predictedSpecies[1:4]
testing$Species[1:4]

predictedSpecies==testing$Species
sum(predictedSpecies==testing$Species)/nrow(testing)

# in the mpg data set use cty and hwy to classify the class of car
