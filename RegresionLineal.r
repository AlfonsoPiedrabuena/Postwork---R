production<- read.table('https://raw.githubusercontent.com/beduExpert/Programacion-con-R-2021/main/Sesion-05/Ejemplo-01/production.txt', header = TRUE)
prod<- as.data.frame(production)
attach(prod)

plot(RunSize, RunTime, xlab="Run Size", ylab = "Run Time")

m1 <- lm(RunTime~RunSize)

summary(m1)

abline(lsfit(RunSize,RunTime))
m1$residuals

mean(m1$residuals)
sum(m1$residuals^2)/18
#Altura <- c(1.94, 1.82, 1.75, 1.80, 1.62, 1.64, 1.68, 1.46, 1.50, 1.55, 1.72, 1.67, 1.57, 1.60) 
#Peso <- c(98, 80, 72, 83, 65, 70, 67, 47, 45, 50, 70, 61, 50, 52)
#cor(Altura, Peso)

