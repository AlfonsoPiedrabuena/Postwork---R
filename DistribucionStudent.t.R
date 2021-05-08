library(ggplot2) # Utilizaremos estos paquetes para algunas gráficas
library(reshape2)


x <- seq(-4, 4, 0.01) # Algunos valores que puede tomar la v.a. T con 7 gl
y <- dt(x, df = 7) # Valores correspondientes de la densidad t de Student con 7 gl
plot(x, y, type = "l", main = "Densidad t de Student, gl = 7", xlab="", ylab="")
abline(v = 0, lwd=2, lty=2)

pt(q = 1.5, df = 7)

plot(x, y, type = "l", main = "Densidad t de Student, gl = 7", xlab="", ylab="")
polygon(c(min(x), x[x<=1.5], 1.5), c(0, y[x<=1.5], 0), col="purple")

pt(q = 2, df = 7, lower.tail = FALSE)

plot(x, y, type = "l", main = "Densidad t de Student, gl = 7", xlab="", ylab="")
polygon(c(2, x[x>=2], max(x)), c(0, y[x>=2], 0), col="orange")

(d <- qt(p = 0.025, df = 7))

pt(q = d, df = 7)

plot(x, y, type = "l", main = "Densidad t de Student, gl = 7", xlab="", ylab="")
axis(side = 1, at = d, font = 2, padj = 1, lwd = 2)

set.seed(777) # Para poder reproducir la muestra en el futuro
muestra <- rt(n = 1000, df = 7)
length(muestra); mdf <- as.data.frame(muestra)
tail(mdf)

ggplot(mdf, aes(muestra)) + 
  geom_histogram(colour = 'green', 
                 fill = 'orange',
                 alpha = 0.7, # Intensidad del color fill
                 binwidth = 0.5) + 
  geom_density(aes(y = 0.5*..count..))+
  geom_vline(xintercept = mean(mdf$muestra), linetype="dashed", color = "black") + 
  ggtitle('Histograma para la muestra t de Student') + 
  labs(x = 'Valores obtenidos', y = 'Frecuencia')+
  theme_light() +
  theme(plot.title = element_text(hjust = 0.5, size = 16))  

