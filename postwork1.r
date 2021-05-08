library(dplyr)
url19<-"https://www.football-data.co.uk/mmz4281/1920/SP1.csv"
download.file(url = url19, destfile = "SP119.csv", mode ="wb")

liga19<- read.csv("SP119.CSV")

new19<- select(liga19, FTHG, FTAG)
View(new19)

new20<- new19

#resolución con tabla de frecuncias
#HomeTeam
dfht<- as.data.frame(table(new20$FTHG))
dfht2<- prop.table(table(new20$FTHG, exclude=c(3:6)))#con esta tabla me sale otro número
dfht2<- prop.table(table(new20$FTHG))#con esta tabla me sale otro número
View(dfht2)
#AwayTeam
dfat<- as.data.frame(table(new20$FTAG))
dfat2<- prop.table(table(new20$FTAG, exclude=c(3:6)))#con esta tabla me sale otro número
dfat2<- prop.table(table(new20$FTAG))#con esta tabla me sale otro número
View(dfat2)
#Combinated
dcom<- prop.table(table(new20$FTHG, new20$FTAG, exclude=c(3:6)))
View(dcom)


#Probabilidad marginal de FTHG con 1 Gol
b <- filter(new19, FTHG == 1)
c <- (length(b$FTHG)/length(new19$FTHG))*100
print(c)

#Probabilidad marginal de FTHG con 2 Goles
d <- filter(new19, FTHG == 2)
e <- (length(d$FTHG)/length(new19$FTHG))*100
print(e)

#Probabilidad marginal de FTHG con 3 Goles
f <- filter(new19, FTHG == 3)
g <- (length(f$FTHG)/length(new19$FTHG))*100
print(g)

#Probabilidad marginal de FTAG con 1 Gol
h <- filter(new19, FTAG == 1)
i <- (length(h$FTHG)/length(new19$FTHG))*100
print(i)

#Probabilidad marginal de FTAG con 2 Goles
j <- filter(new19, FTAG == 2)
k <- (length(j$FTHG)/length(new19$FTHG))*100
print(k)

#Probabilidad marginal de FTAG con 3 Goles
l <- filter(new19, FTAG == 3)
m <- (length(l$FTHG)/length(new19$FTHG))*100
print(m)



