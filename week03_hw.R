setwd('~/Projects/personal/data-science-101')
library(utils)
library(ggplot2)

# import data
mydata = read.csv(file='realEstate.csv',skip=0,head=TRUE)

# How many unique cities exist in the city column?
uniqueCities = unique(mydata$city)
numUniqueCities = length(uniqueCities)

# Is there any correlation between the sq__ft and price? Show the correlation
# both in number and visually.
# NO

mydata = mydata[complete.cases(mydata), ]
mydata[-which(mydata[ , 7]== 0) , 7]
correlateion_sqft_price = cor(mydata$sq__ft,mydata$price)
ggplot(data=mydata,aes(y=sq__ft,x=price)) + geom_point()

# Use a plot to show the distribution of the prices.
ggplot(data=mydata,aes(price))+geom_histogram(color="red",fill="orange")

# Repeat task number 4 for price and latitude
cor(mydata$sq__ft,mydata$price) #0.333897
ggplot(data=mydata,aes(x=mydata$latitude,y=mydata$price))+geom_point()

# Is there any correlation between the number of beds and baths?
# Yes, there is a positive correlation
cor(mydata$beds,mydata$baths) # 0.8396
ggplot(data=mydata,aes(x=beds,y=baths))+geom_point()

# Compare the price ranges for different bed numbers. Which bed number has a
# higher price in general? Which bed number has a greater fluctuation in price?
ggplot(data=mydata,aes(x=as.character(beds),y=price))+geom_boxplot()
# 5 beds has a higher price in general
# 4 beds has a higher fluctuation in price

# Repeat task 8 for bath number vs prices
ggplot(data=mydata,aes(as.character(baths),y=price))+geom_boxplot()
# 5 baths has a higher price in general

