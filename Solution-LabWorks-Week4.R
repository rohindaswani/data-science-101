# Labworks for Week4

# 1. 
library(utils)
realEstate=read.csv("Sacramentorealestatetransactions.csv")
# for more accuarate results we should remove rows which have a sq__ft of zero
realEstate=realEstate[-which(realEstate$sq__ft==0),]
  
#############################################################################################################
# 2. Build a linear regression model in order to predict the price of houses from square feet.
library(caret)
model=train(price ~.,realEstate[,c("sq__ft","price")],method="lm")

#############################################################################################################
# 3. Split the data to half and repeat task 2 on the training set. 
training=realEstate[seq(1,nrow(realEstate),2),c("sq__ft","price")]
model=train(price ~.,training,method="lm")

#############################################################################################################
# 4. Use your model in task 3 to predict prices in the test data and measure RMSE and R-Squared for your predictions.
library(hydroGOF)
testing=realEstate[seq(2,nrow(realEstate),2),c("sq__ft","price")]
predictedPrices=predict(model,testing)
RMSE=rmse(predictedPrices,testing$price) # RMSE=88591.34
rSquarred=1-(sum((testing$price-predictedPrices)^2)/sum((testing$price-mean(testing$price))^2)) # rSquarred=0.47

#############################################################################################################
# 5. Use “beds”, “baths” and “sq__ft” to predict “prices” using multiple linear regression. Train on the first half of the data and measure RMSE and R-Squared on the Test set. Compare results with task 4.
training=realEstate[seq(1,nrow(realEstate),2),c("beds","baths","sq__ft","price")]
testing=realEstate[seq(2,nrow(realEstate),2),c("beds","baths","sq__ft","price")]
model=train(price ~.,training,method="lm")
predictedPrices=predict(model,testing)
RMSE=rmse(predictedPrices,testing$price) # RMSE=89537.09 , lower than task 4
rSquarred=1-(sum((testing$price-predictedPrices)^2)/sum((testing$price-mean(testing$price))^2)) # rSquarred=0.46, lower than task 4

#############################################################################################################
# 6. se “beds”, “baths” and “sq__ft” to predict “prices” using the Bayesian Ridge Regression model. Train on the first half of the data and measure RMSE and R-Squared on the Test set. Compare results with task 4 and 5.
model=train(price ~.,training,method="bridge")
predictedPrices=predict(model,testing)
RMSE=rmse(predictedPrices,testing$price) # RMSE=88687.07
rSquarred=1-(sum((testing$price-predictedPrices)^2)/sum((testing$price-mean(testing$price))^2)) # rSquarred=0.47

#############################################################################################################
# 7. Repeat task 6 and apply greedy feature selection in order to find the best set of predictors in order to predict “prices”.
# since we are using a regression model, we can only use features which are numbers:
# pick one random feature such as "sq__ft"
selectedFeatures=c("sq__ft","price")
possibleFeatures=c("zip","beds","baths","latitude","longitude")
# apply greedy feature selection to all possibleFeatures
training=realEstate[seq(1,nrow(realEstate),2),selectedFeatures]
testing=realEstate[seq(2,nrow(realEstate),2),selectedFeatures]
model=train(price ~.,training,method="bridge")
predictedPrices=predict(model,testing)
baseRMSE=rmse(predictedPrices,testing$price)
for (i in 1:length(possibleFeatures)){
  training=realEstate[seq(1,nrow(realEstate),2),c(selectedFeatures,possibleFeatures[i])]
  testing=realEstate[seq(2,nrow(realEstate),2),c(selectedFeatures,possibleFeatures[i])]
  model=train(price ~.,training,method="bridge")
  predictedPrices=predict(model,testing)
  RMSE=rmse(predictedPrices,testing$price)
  if(RMSE<baseRMSE){
    selectedFeatures=c(selectedFeatures,possibleFeatures[i])
    baseRMSE=RMSE
  }
}
# print the selectedFeatures 
selectedFeatures

#############################################################################################################
  
  
  