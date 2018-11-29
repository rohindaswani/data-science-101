### greedy feature selection using for loop

cancer_2 = cancer[which(cancer$bareNuclei!="?"),] # cleaning data to do greedy selection
cancer$class = as.factor(cancer$class) # converting our predicted column to a factor for classification models
train_control = trainControl(method="repeatedcv", number=10, repeats = 3) # setting up train control

selectedFeatures=c('clumpThickness', 'class')
possibleFeatures=c('cellSize','cellShape','marginalAdhesion','singleECellSize',
                   'bareNuclei','blandChromatin','normalNuclei','mitoses')
data = cancer_2[,selectedFeatures] 
m1 = train(class~., data, trControl = train_control, method = "kknn") # getting initial accuracy measurement
acc = m1$results[1,4]

for (i in 1:length(possibleFeatures)){
  data = cancer_2[,c(selectedFeatures, possibleFeatures[i])]
  model=train(class~., data, trControl = train_control, method = "kknn")
  new_acc=model$results[1,4]
  if(acc<new_acc){
    selectedFeatures=c(selectedFeatures,possibleFeatures[i])
    acc=new_acc
  }
}

new_data = cancer_2[,selectedFeatures] #new data set post greedy selection
new_model = train(class~., new_data, trControl = train_control, method = "kknn")
new_model$results