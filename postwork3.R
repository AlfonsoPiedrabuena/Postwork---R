library(ggplot2)
library(dplyr)

liga17<- read.csv("SP117.csv")
liga18<- read.csv("SP118.CSV")
liga19<- read.csv("SP119.CSV")
View(liga17)

new17<- select(liga17,Date:FTR)
new18<- select(liga18,Date:FTR)
new19<- select(liga19,Date, HomeTeam:FTR)

new17<- mutate(new17, Date = as.Date(Date, "%d/%m/%y"), FTHG = as.numeric(FTHG), FTAG = as.numeric(FTAG))
new18<- mutate(new18, Date = as.Date(Date, "%d/%m/%Y"), FTHG = as.numeric(FTHG), FTAG = as.numeric(FTAG))
new19<- mutate(new19, Date = as.Date(Date, "%d/%m/%Y"), FTHG = as.numeric(FTHG), FTAG = as.numeric(FTAG))

x<- rbind(new17,new18,new19)
prueba<-x

#Home Team
dfht<- as.data.frame(table(prueba$FTHG))
dfht2<-as.data.frame(prop.table(table(prueba$FTHG)))#con esta tabla me sale otro número
#AwayTeam
dfat<- as.data.frame(table(prueba$FTAG))
dfat2<-as.data.frame(prop.table(table(prueba$FTAG)))#con esta tabla me sale otro número
#Combinated
dcom<- as.data.frame(prop.table(table(prueba$FTHG, prueba$FTAG)))

#Versión 4 de gráficos de barra con GGplot
GolesHomeTeam<- ggplot(dfht2, aes(x=Var1, y=Freq))+
  geom_col()+
  xlab("Frecuencia") + 
  ylab("Goles") + 
  ggtitle("Gráfico de barras para el equipo de casa")


GolesAwayTeam<- ggplot(dfat2, aes(x=Var1, y=Freq))+
  geom_col()+
  xlab('Frecuencia')+
  ylab('Goles')+
  ggtitle('Gráfico de barras de equipo visitante')

GolesHomeTeam
GolesAwayTeam

#Heatmap
GolesConjunto<- ggplot(dcom, aes(x = Var1, y = Var2, fill = Freq)) + 
  geom_tile()

GolesConjunto