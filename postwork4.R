library(dplyr)

liga17<- read.csv("SP117.csv")
liga18<- read.csv("SP118.CSV")
liga19<- read.csv("SP119.CSV")

View(liga17)
View(liga18)
View(liga19)

new17<- select(liga17,Date,HomeTeam,HS,AwayTeam,AS)
new18<- select(liga18,Date,HomeTeam,HS,AwayTeam,AS)
new19<- select(liga19,Date,HomeTeam,HS,AwayTeam,AS)

SmallData<- as.data.frame(rbind(new17,new18,new19))

write.csv(SmallData, file='soccer.csv', row.names = FALSE)
