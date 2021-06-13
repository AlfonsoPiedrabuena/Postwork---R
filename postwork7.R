install.packages("mongolite")
library(mongolite)

mongo_url<- 'liga a mongo compass'
x<- mongo(
  collection = "match",
  db = "match_games",
  url = mongo_url,
)
x$count()
y<- x$find('{date:"2015-12-20", "home.team":"Real Madrid"}')
