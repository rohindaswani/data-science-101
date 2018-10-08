library(ggplot2)

#read the dataset in
usArrests = USArrests

# state with highest rate of murder
usArrests[which.max(usArrests$Murder),]  #Georgia

# state with higest rate of rape
usArrests[which.max(usArrests$Rape),]  #Nevada

# state with lowest rate of murder
usArrests[which.min(usArrests$Murder),]  #North Dakota

# state with lowest rate of rape
usArrests[which.min(usArrests$Rape),]   #North Dakota

# avg. rate of murder in the US
mean(usArrests$Murder)  #7.788

# avg. rate of rape in the US
mean(usArrests$Rape)  #21.234

# histogram to show distribution of Murder rate

ggplot(usArrests, aes(Murder))+
  geom_histogram(bins = 10, color="blue",fill="green")+
  ggtitle("Distribution of Murder Rates")+
  theme(plot.title=element_text(hjust=0.5),text=element_text(size=20))+
  theme_bw()

# correlation between murder and rape
# there is a positive correlation between murder rates and rape
ggplot(usArrests, aes(Murder, Rape,color="class"))+
  geom_point(color="red",size=4)

#exclude 3 states from the dataset that have the highest rates of rape
ggplot(usArrests,aes(row.names(usArrests),Rape))+
  geom_point(color="blue")
new_data_set = usArrests
top_3_rape_vales = tail(sort(new_data_set$Rape),3)
top_3_cities = sapply(top_3_rape_vales,function(x) row.names(new_data_set[which(new_data_set$Rape==x),]))

ix <- which(rownames(new_data_set) %in% top_3_cities)
new_data_set = new_data_set[-ix,]


