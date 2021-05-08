set.seed(134)
x <- round(rnorm(1000, 175, 6), 1)
print(x)

media<- mean(x)
mediana<- median(x)
library("DescTools")
moda<- Mode(x)

print(media)
print(mediana)
print(moda)

deciles<- quantile(x, seq(0.1, 0.9, by=0.1))
print(deciles)

rango<-IQR(x)
print(rango)


varianza<-var(x)
desviacion<- sd(x)

print(varianza)
print(desviacion)
