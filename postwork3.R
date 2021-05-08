library(ggplot2)

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

typeof(prueba)
#Home Team
dfht<- as.data.frame(table(prueba$FTHG))
dfht2<- prop.table(table(prueba$FTHG, exclude=c(3:6)))#con esta tabla me sale otro número
dfht2<- prop.table(table(prueba$FTHG))#con esta tabla me sale otro número

#AwayTeam
dfat<- as.data.frame(table(prueba$FTAG))
dfat2<- prop.table(table(prueba$FTAG, exclude=c(3:6)))#con esta tabla me sale otro número
dfat2<- prop.table(table(prueba$FTAG))#con esta tabla me sale otro número
View(dfat2)
#Combinated
dcom<- prop.table(table(prueba$FTHG, prueba$FTAG, exclude=c(3:6)))
dfdcom<- as.data.frame(dcom)
View(dfdcom)

View(dfht)
View(dfht2)

#primer versión de gráficas
golesvector<- c(0:6)
#versión 1.a
barplot(dfht$Freq, names.arg = golesvector, xlab = "Frecuencia de goles", ylab = 'Cantidad de Goles')
barplot(dfat$Freq)

#versión 2.a ///////Estable
#HomeTeam
data<- dfht
hist(data$Freq, breaks=(seq(0,400,20)),
     main="Histograma de Goles de Casa",
     xlab="Goles",
     ylab="Frecuencia")
#AwayTeam
data2<- dfat
hist(data2$Freq, breaks=(seq(0,500,20)),
     main="Histograma de Goles de Visitante",
     xlab="Goles",
     ylab="Frecuencia")


#versión3 3a
plot(x = dfht$Freq, main = "Gráfica de Goles",
     xlab = "Goles", ylab = "Cantidad", 
     col = c("royalblue", "seagreen", "purple", "grey"))

#HeatMap

attach(dfdcom)
# Dummy data
x <- dfdcom$Var1
y <- dfdcom$Var1
data <- dfdcom$Freq

# Heatmap 
ggplot(dfdcom, aes(X,Y,fill= dfdcom$Freq)) + 
  geom_tile()
