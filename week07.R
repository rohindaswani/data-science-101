#association rule minning
#Apriori model

library(RSelenium)
rd = rsDriver(verbos=FALSE,port=4455L)
remDr = rD$client

remDr$navigate("https://www.google.com")
webElem = remDr$findElement(using="name","q")
