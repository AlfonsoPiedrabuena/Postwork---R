install.packages("mongolite")
library(mongolite)

mongo_url<- 'mongodb+srv://root:root@cluster0.gm2op.mongodb.net/test?authSource=admin&replicaSet=atlas-5fp2uk-shard-0&readPreference=primary&appname=MongoDB%20Compass&ssl=true'
x<- mongo(
  collection = "match",
  db = "match_games",
  url = mongo_url,
)
x$count()
y<- x$find('{date:"2015-12-20", "home.team":"Real Madrid"}')
