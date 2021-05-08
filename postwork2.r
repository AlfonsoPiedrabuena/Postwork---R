url17<-"https://www.football-data.co.uk/mmz4281/1718/SP1.csv"
url18<-"https://www.football-data.co.uk/mmz4281/1819/SP1.csv"
url19<-"https://www.football-data.co.uk/mmz4281/1920/SP1.csv"

download.file(url = url17, destfile = "SP117.csv", mode ="wb")
download.file(url = url18, destfile = "SP118.csv", mode ="wb")
download.file(url = url19, destfile = "SP119.csv", mode ="wb")

liga17<- read.csv("SP117.csv")
liga18<- read.csv("SP118.CSV")
liga19<- read.csv("SP119.CSV")
View(liga17)

library(dplyr)

ligas<-list(liga17, liga18, liga19)

ligas_sel<- lapply(ligas, select,Date:FTR)

new17<- select(liga17,Date:FTR)
new18<- select(liga18,Date:FTR)
new19<- select(liga19,Date, HomeTeam:FTR)

str(liga19)

new17<- mutate(new17, Date = as.Date(Date, "%d/%m/%y"), FTHG = as.numeric(FTHG), FTAG = as.numeric(FTAG))
new18<- mutate(new18, Date = as.Date(Date, "%d/%m/%Y"), FTHG = as.numeric(FTHG), FTAG = as.numeric(FTAG))
new19<- mutate(new19, Date = as.Date(Date, "%d/%m/%Y"), FTHG = as.numeric(FTHG), FTAG = as.numeric(FTAG))

tablas_limpias<-list(new17, new18, new19)

str(new17)
str(new18)
str(new19)

x<- rbind(new17,new18,new19)
View(x)
prueba<-x

str(x)

z<- mutate(x, Goles = FTHG + FTAG )
y<- mutate(z, Prob= FTHG/length(FTHG ))
View(y)
