library(dplyr)
library(fbRanks)

liga17<- read.csv("SP117.csv")
liga18<- read.csv("SP118.CSV")
liga19<- read.csv("SP119.CSV")

new17<- rename(liga17, date=Date,home.team=HomeTeam, home.score=HS, away.team=AwayTeam, away.score=AS)
new17<- select(new17,date,home.team,home.score,away.team,away.score)
new18<- rename(liga18, date=Date,home.team=HomeTeam, home.score=HS, away.team=AwayTeam, away.score=AS)
new18<- select(new18,date,home.team,home.score,away.team,away.score)
new19<- rename(liga19, date=Date,home.team=HomeTeam, home.score=HS, away.team=AwayTeam, away.score=AS)
new19<- select(new19,date,home.team,home.score,away.team,away.score)

SmallData<- as.data.frame(rbind(new17,new18,new19))

write.csv(SmallData, file='soccer.csv', row.names = FALSE)

listasoccer<-create.fbRanks.dataframes(scores.file = "soccer.csv",teams.file = "soccer.csv",date.format = "%d/%m/%Y")

anotaciones<- listasoccer$scores
anotaciones
equipos<- listasoccer$teams
equipos
fecha <- unique(SmallData$date)
n<-  length(fecha)
ranking <- rank.teams(scores = anotaciones, teams = equipos,max.date="19/07/2020", min.date="18/08/2017", date.format='%d/%m/%Y')

predict(ranking, max.date="19/07/2020", min.date="18/08/2017")

