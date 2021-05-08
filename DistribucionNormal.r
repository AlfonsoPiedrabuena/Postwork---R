library(ggplot2) # Utilizaremos estos paquetes para algunas gráficas
library(reshape2)

x <- seq(-4, 4, 0.01)*6 + 175 # Algunos posibles valores que puede tomar la v.a. X (mínimo: mu-4sigma, máximo: mu+4sigma)
y <- dnorm(x, mean = 175, sd = 6) # Valores correspondientes de la función de densidad de probabilidad

plot(x, y, type = "l", xlab = "", ylab = "")
title(main = "Densidad de Probabilidad Normal", sub = expression(paste(mu == 175, " y ", sigma == 6)))
abline(v = 175, lwd = 2, lty = 2) # La media es 175 

pnorm(q = 180, mean = 175, sd = 6)

par(mfrow = c(2, 2))

plot(x, y, type = "l", xlab = "", ylab = "")
title(main = "Densidad de Probabilidad Normal", sub = expression(paste(mu == 175, " y ", sigma == 6)))
polygon(c(min(x), x[x<=180], 180), c(0, y[x<=180], 0), col="red")

pnorm(q = 165, mean = 175, sd = 6)

plot(x, y, type = "l", xlab = "", ylab = "")
title(main = "Densidad de Probabilidad Normal", sub = expression(paste(mu == 175, " y ", sigma == 6)))
polygon(c(min(x), x[x<=165], 165), c(0, y[x<=165], 0), col="yellow")

pnorm(q = 180, mean = 175, sd = 6) - pnorm(q = 165, mean = 175, sd = 6)

plot(x, y, type = "l", xlab="", ylab="")
title(main = "Densidad de Probabilidad Normal", sub = expression(paste(mu == 175, " y ", sigma == 6)))
polygon(c(165, x[x>=165 & x<=180], 180), c(0, y[x>=165 & x<=180], 0), col="green")

pnorm(q = 182, mean = 175, sd = 6, lower.tail = FALSE)

plot(x, y, type = "l", xlab="", ylab="")
title(main = "Densidad de Probabilidad Normal", sub = expression(paste(mu == 175, " y ", sigma == 6)))
polygon(c(182, x[x>=182], max(x)), c(0, y[x>=182], 0), col="blue")

dev.off() # Para mostrar solo una gráfica

(b <- qnorm(p = 0.75, mean = 175, sd = 6)) 

pnorm(b, 175, 6)

plot(x, y, type = "l", xlab="", ylab="")
title(main = "Densidad de Probabilidad Normal", sub = expression(paste(mu == 175, " y ", sigma == 6)))
axis(side = 1, at = b, font = 2, padj = 1, lwd = 2)


set.seed(7563) # Para poder reproducir la muestra en el futuro
muestra <- rnorm(n = 1000, mean = 175, sd = 6)
length(muestra); mdf <- as.data.frame(muestra)
tail(mdf)

ggplot(mdf, aes(muestra)) + 
  geom_histogram(colour = 'red', 
                 fill = 'blue',
                 alpha = 0.3, # Intensidad del color fill
                 binwidth = 3) + 
  geom_density(aes(y = 3*..count..))+
  geom_vline(xintercept = mean(mdf$muestra), linetype="dashed", color = "black") + 
  ggtitle('Histograma para la muestra normal') + 
  labs(x = 'Valores obtenidos', y = 'Frecuencia')+
  theme_dark() +
  theme(plot.title = element_text(hjust = 0.5, size = 16))  

mean <- 175; sd <- 6
x <- seq(mean-4*sd, mean+4*sd, 0.01)
y <- dnorm(x, mean, sd)
plot(x, y, type = "l", xlab="valores", ylab = "", xaxt = "n", yaxt = "n")
title(main = "Densidad de Probabilidad Normal", sub = expression(paste("Regla Empírica con ", mu == 175, " y ", sigma == 6)))
abline(v=mean, lty = 2, lwd = 2)
for(k in c(-3, -2, -1, 1, 2, 3)) abline(v = mean+k*sd, lty = 2, col = abs(k))
ps <- c(mean - 3*sd, mean - 2*sd, mean - sd, mean, mean + sd, mean + 2*sd, mean + 3*sd)
axis(side = 1, at = ps)
x0 <- NULL
for(i in 1:length(ps)-1) x0 <- c(x0, (ps[i]+ps[i+1])/2)
y0 <- dnorm(x0, mean, sd)*1/3
text(x = x0, y = y0, labels = c("2.35%", "13.5%", "34%", "34%", "13.5%", "2.35%"))
x1 <- (x[1]+ps[1])/2; y1 <- dnorm(mean, mean, sd)*1/2
xf <- (x[length(x)]+ps[length(ps)])/2; yf <- dnorm(mean, mean, sd)*1/2
text(x = c(x1, xf), y = c(y1, yf), labels = c("0.15%", "0.15%"))
segments(x0 = x1, y0 = 0, x1 = x1, y1 = y1,               # Draw one line as in Example 1
         col = "cornflowerblue",                               # Color of line
         lwd = 5,                                              # Thickness of line
         lty = "dotted")     
segments(x0 = xf, y0 = 0, x1 = xf, y1 = yf,               
         col = "cornflowerblue",                               
         lwd = 5,                                              
         lty = "dotted")     