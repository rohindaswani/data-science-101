# Labworks for Week3

# 2. Download the Real Estate data set in slide 7 and import it into R.
library(utils)
realEstate=read.csv("Sacramentorealestatetransactions.csv")

#############################################################################################################
# 3. How many unique cities exist in the city column?
length(unique(realEstate$city))

#############################################################################################################
# 4. Is there any correlation between the sq__ft and price? Show the correlation both in number and visually.
library(ggplot2)
ggplot(realEstate,aes(sq__ft,price))+geom_point()
# yes there is a positive linear correlation
cor(realEstate$sq__ft,realEstate$price) # correlation=0.33

#############################################################################################################
# 5. Use a plot to show the distribution of the prices.
ggplot(realEstate,aes(price))+geom_histogram()

#############################################################################################################
# 6. Repeat task number 4 for price and latitude.
ggplot(realEstate,aes(latitude,price))+geom_point()
# no correlation obviously

#############################################################################################################
# 7. Is there any correlation between the number of beds and baths?
ggplot(realEstate,aes(beds,baths))+geom_point()
# yes there is a positive linear correlation
cor(realEstate$beds,realEstate$baths) # correlation=0.83

#############################################################################################################
# 8. Compare the price ranges for different bed numbers. Which bed number has a higher price in general? Which bed number has a greater fluctuation in price?
ggplot(realEstate,aes(as.character(beds),price))+geom_boxplot()
# Which bed number has a higher price in general? 5 bed
# Which bed number has a greater fluctuation in price? 6 bed 

#############################################################################################################
# 9. Repeat task 8 for bath number vs prices.
ggplot(realEstate,aes(as.character(baths),price))+geom_boxplot()
# Which bath number has a higher price in general? 5 bath
# Which bath number has a greater fluctuation in price? 4 bath

#############################################################################################################
# 10. Find the rows which have only 1 bed.
which(realEstate$beds==1)

#############################################################################################################
# 11. Find the rows which have a sq__ft less than 1000 and at least 2 beds.
which(realEstate$sq__ft<1000 & realEstate$beds>=2)

#############################################################################################################


