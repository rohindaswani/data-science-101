library(ggplot2)
mydata = mpg
View(mydata)

#aes takes the number of columns
#add + to add components and features into the graph
ggplot(mydata, aes(cty))+
  geom_histogram(bins = 6, color="blue", fill="green")+
  ggtitle("My first histogram")+
  theme(plot.title = element_text(hjust = 0.5), text= element_text(size=20))+
  xlab("city mpg")+
  ylab("Count")+
  xlim(0,80)+
  theme_bw()

#density plot
ggplot(mydata, aes(cty))+
  geom_density(color="blue", fill="green")+
  ggtitle("My first histogram")+
  theme(plot.title = element_text(hjust = 0.5), text= element_text(size=20))+
  xlab("city mpg")+
  ylab("Count")+
  theme_bw()

#bar graphs

ggplot(mydata, aes(manufacturer))+
  geom_bar(fill="violet")+
  theme_bw()

#scatterplot
#add color=class to make it a 3 dimensional scatterplot
ggplot(mydata, aes(cty,hwy))+geom_point(size=4,color="red",alpha=0.3)

#answer the question How can you compare the distributions of hwy msgs for different classes of cars?
newMPG=rbind(mpg,mpg,mpg,mpg,mpg,mpg) 
newMPG$hwy=newMPG$hwy+runif(nrow(newMPG),min=0,max=1)

ggplot(newMPG, aes(class,hwy,color=class))+
  geom_jitter()

ggplot(newMPG, aes(class,hwy,fill=class))+
  geom_violin()

#box plots
ggplot(newMPG, aes(class,hwy,fill=class))+
  geom_boxplot()

#heatmaps
x=c(1,1,1,2,2,2,3,3,3)
y=c(1,2,3,1,2,3,1,2,3) 
z=c(1,4,4,2,3,6,6,1,8) 
myData=data.frame(X=x,Y=y,Z=z) 
ggplot(myData,aes(X,Y,fill=Z))+geom_tile()

ggplot(newMPG, aes(class,hwy,fill=class))+
  geom_tile()
