library(dplyr)

url1 <- 'https://raw.githubusercontent.com/beduExpert/Programacion-con-R-Santander/master/Sesion-06/Postwork/match.data.csv'
download.file(url = url1, destfile = "match.data.csv")

match.data <- read.csv('match.data.csv')

datos<- mutate(match.data, sumagoles = home.score + away.score)
datos2<- group_by(datos,date)
datos3<-summarise(datos2, mean(datos$sumagoles))
datos3
