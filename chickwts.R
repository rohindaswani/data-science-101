library(ggplot2)

wts = chickwts

# Plot a boxplot for each feed type to compare their weights.
# For the above boxplots, assign different colors to each boxplot.
ggplot(wts, aes(feed,weight,fill=feed))+
  geom_boxplot()

# According to the plots, which feed type results in a higher weight in average?
# Which feed type has the highest weight? Which one has the lowest?

# heightest weight is Casein
# lowest weight is horsebean

# Plot a Violin plot for each feed type to compare the distributions of their
# weights.

ggplot(wts, aes(feed,weight,fill=feed))+
  geom_violin()

