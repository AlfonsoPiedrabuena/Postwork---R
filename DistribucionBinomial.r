library(ggplot2) # Utilizaremos estos paquetes para algunas gráficas
library(reshape2)

dbinom(x = 20, size = 30, prob = 0.2)
pbinom(q = 20, size = 30, prob = 0.2)

qbinom(p = 0.35, size = 30, prob = 0.2) # b = 5

pbinom(q = 4, size = 30, prob = 0.2) # P(X <= 4) = 0.2552 < 0.35
pbinom(q = 5, size = 30, prob = 0.2) # P(X <= 5) = 0.4275 >= 0.35
pbinom(q = 6, size = 30, prob = 0.2) # P(X <= 6) = 0.6070 >= 0.35

set.seed(4857) # Establecemos una semilla, para poder reproducir la muestra en el futuro
muestra <- rbinom(n = 1000, size = 30, prob = 0.2)
length(muestra); muestra[1:3]
as.data.frame(table(muestra))

(df1 <- as.data.frame(table(muestra)/length(muestra)))

valg <- as.character(df1$muestra) # distintos valores generados por rbinom
(valg <- as.numeric(valg)) # Convertimos a números

(v1 <- round(sapply(valg, dbinom, size = 30, p = 0.2), 3))

(df2 <- cbind(df1, v1))
(names(df2) <- c("Exitos", "FR", "Prob"))

(df2 <- melt(df2)) # función del paquete reshape2

ggplot(df2, aes(x = Exitos, y = value, fill = variable)) + 
  geom_bar (stat="identity", position = "dodge") # Funciones del paquete ggplot2
