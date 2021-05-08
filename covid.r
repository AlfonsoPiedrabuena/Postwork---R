library(dplyr)

l1<-"https://data.humdata.org/hxlproxy/data/download/time_series_covid19_confirmed_global_narrow.csv?dest=data_edit&filter01=explode&explode-header-att01=date&explode-value-att01=value&filter02=rename&rename-oldtag02=%23affected%2Bdate&rename-newtag02=%23date&rename-header02=Date&filter03=rename&rename-oldtag03=%23affected%2Bvalue&rename-newtag03=%23affected%2Binfected%2Bvalue%2Bnum&rename-header03=Value&filter04=clean&clean-date-tags04=%23date&filter05=sort&sort-tags05=%23date&sort-reverse05=on&filter06=sort&sort-tags06=%23country%2Bname%2C%23adm1%2Bname&tagger-match-all=on&tagger-default-tag=%23affected%2Blabel&tagger-01-header=province%2Fstate&tagger-01-tag=%23adm1%2Bname&tagger-02-header=country%2Fregion&tagger-02-tag=%23country%2Bname&tagger-03-header=lat&tagger-03-tag=%23geo%2Blat&tagger-04-header=long&tagger-04-tag=%23geo%2Blon&header-row=1&url=https%3A%2F%2Fraw.githubusercontent.com%2FCSSEGISandData%2FCOVID-19%2Fmaster%2Fcsse_covid_19_data%2Fcsse_covid_19_time_series%2Ftime_series_covid19_confirmed_global.csv"
l2<-"https://data.humdata.org/hxlproxy/data/download/time_series_covid19_deaths_global_narrow.csv?dest=data_edit&filter01=explode&explode-header-att01=date&explode-value-att01=value&filter02=rename&rename-oldtag02=%23affected%2Bdate&rename-newtag02=%23date&rename-header02=Date&filter03=rename&rename-oldtag03=%23affected%2Bvalue&rename-newtag03=%23affected%2Binfected%2Bvalue%2Bnum&rename-header03=Value&filter04=clean&clean-date-tags04=%23date&filter05=sort&sort-tags05=%23date&sort-reverse05=on&filter06=sort&sort-tags06=%23country%2Bname%2C%23adm1%2Bname&tagger-match-all=on&tagger-default-tag=%23affected%2Blabel&tagger-01-header=province%2Fstate&tagger-01-tag=%23adm1%2Bname&tagger-02-header=country%2Fregion&tagger-02-tag=%23country%2Bname&tagger-03-header=lat&tagger-03-tag=%23geo%2Blat&tagger-04-header=long&tagger-04-tag=%23geo%2Blon&header-row=1&url=https%3A%2F%2Fraw.githubusercontent.com%2FCSSEGISandData%2FCOVID-19%2Fmaster%2Fcsse_covid_19_data%2Fcsse_covid_19_time_series%2Ftime_series_covid19_deaths_global.csv"

download.file(url=l1, destfile="st19ncov-confirmados.csv", mode="wb")
download.file(url=l2, destfile="st19ncov-muertes.csv", mode="wb")

conf <- read.csv("st19ncov-confirmados.csv")
muer <- read.csv("st19ncov-muertes.csv")

Sconf <- conf[-1, ]
Smuer <- muer[-1, ]

View(Smuer)

Sconf <- select(Sconf, Country.Region, Date, Value)
Sconf <- rename(Sconf, Pais = Country.Region, Fecha = Date, Infectados = Value)
Sconf <- mutate(Sconf, Fecha = as.Date(Fecha, "%Y-%m-%d"), Infectados = as.numeric(Infectados))

Smuer <- select(Smuer, Country.Region, Date, Value) # Seleccionamos país, fecha y acumulado de muertos
Smuer <- rename(Smuer, Pais = Country.Region, Fecha = Date, Muertos = Value) # Renombramos
Smuer <- mutate(Smuer, Fecha = as.Date(Fecha, "%Y-%m-%d"), Muertos = as.numeric(Muertos)) 

View(Smuer)
Scm <- merge(Sconf, Smuer) # Unimos infectados y muertos acumulados para cada fecha
View(Scm)

mex <- filter(Scm, Pais == "Mexico") # Seleccionamos sólo a México
mex <- filter(mex, Infectados != 0) # Primer día de infectados

mex <- mutate(mex, NI = c(1, diff(Infectados))) # Nuevos infectados por día
mex <- mutate(mex, NM = c(0, diff(Muertos))) # Nuevos muertos por día

mex <- mutate(mex, Letalidad = round(Muertos/Infectados*100, 1)) # Tasa de letalidad

mex <- mutate(mex, IDA = lag(Infectados), MDA = lag(Muertos)) # Valores día anterior
mex <- mutate(mex, FCI = Infectados/IDA, FCM = Muertos/MDA) # Factores de Crecimiento
mex <- mutate(mex, Dia = 1:dim(mex)[1]) # Días de contingencia

head(mex); tail(mex)
write.csv(mex, "C19Mexico.csv", row.names = FALSE)