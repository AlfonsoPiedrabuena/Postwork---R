library(ggplot2)
#Sesion1Clase3
names(mtcars)
ggplot(mtcars, aes(x=cyl, y=hp, colour=mpg))+#ggplot
  geom_point()+
  theme_grey()+ #tema
  facet_wrap("cyl")+ #lo divide por el número de cilindros
  xlab('Núm Acilindros')+ #nombre en los ejes
  ylab('Caballos de Fuerza')


#Histogramas

library(dplyr)
url1<- "https://raw.githubusercontent.com/beduExpert/Programacion-con-R-2021/main/Sesion-03/Data/boxp.csv"
download.file(url = url1, destfile = "boxp.csv", mode ="wb")
data<- read.csv("boxp.csv")
head(data)
names(data)
hist(data$Mediciones, breaks=(seq(0,300,20)),
  main="Histograma de Mediciones",
  xlab="Mediciones",
  ylab="Frecuencia")