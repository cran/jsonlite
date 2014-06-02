
## ----echo=FALSE----------------------------------------------------------
#For JSS
#opts_chunk$set(prompt=TRUE, highlight=FALSE, background="white")
#options(prompt = "R> ", continue = "+  ", width = 70, useFancyQuotes = FALSE)


## ----eval=FALSE----------------------------------------------------------
## hadley_orgs <- fromJSON("https://api.github.com/users/hadley/orgs")
## hadley_repos <- fromJSON("https://api.github.com/users/hadley/repos")
## gg_issues <- fromJSON("https://api.github.com/repos/hadley/ggplot2/issues")
## gg_commits <- fromJSON("https://api.github.com/repos/hadley/ggplot2/commits")


## ----eval=FALSE----------------------------------------------------------
## citibike <- fromJSON("http://citibikenyc.com/stations/json")


## ----eval=FALSE----------------------------------------------------------
## res <- fromJSON("http://api.angel.co/1/tags/59/startups")
## res$startups


## ----eval=FALSE----------------------------------------------------------
## races <- fromJSON('http://ergast.com/api/f1/2012/1/results.json')
## races$MRData$RaceTable$Races$Results[[1]]$Driver


## ----eval=FALSE----------------------------------------------------------
## #Register keys at http://developer.nytimes.com/docs/reference/keys
## 
## #search for articles
## article_key = "&api-key=c2fede7bd9aea57c898f538e5ec0a1ee:6:68700045"
## url = "http://api.nytimes.com/svc/search/v2/articlesearch.json?q=obamacare+socialism"
## articles <- fromJSON(paste0(url, article_key))
## 
## #search for best sellers
## bestseller_key = "&api-key=5e260a86a6301f55546c83a47d139b0d:3:68700045"
## url = "http://api.nytimes.com/svc/books/v2/lists/overview.json?published_date=2013-01-01"
## bestsellers <- fromJSON(paste0(url, bestseller_key))
## 
## #movie reviews
## movie_key = "&api-key=5a3daaeee6bbc6b9df16284bc575e5ba:0:68700045"
## url = "http://api.nytimes.com/svc/movies/v2/reviews/dvd-picks.json?order=by-date"
## reviews <- fromJSON(paste0(url, movie_key))


## ----eval=FALSE, tidy=FALSE----------------------------------------------
## key <- "f6dv6cas5vw7arn5b9d7mdm3"
## res <- fromJSON(paste0("http://api.crunchbase.com/v/1/search.js?query=R&api_key=", key))
## str(res$results)


## ----eval=FALSE, tidy=FALSE----------------------------------------------
## #register key at http://sunlightfoundation.com/api/accounts/register/
## key <- "&apikey=39c83d5a4acc42be993ee637e2e4ba3d"
## 
## #some queries
## drones <- fromJSON(paste0("http://openstates.org/api/v1/bills/?q=drone", key))
## word <- fromJSON(paste0("http://capitolwords.org/api/1/dates.json?phrase=obamacare", key))
## legislators <- fromJSON(paste0("http://congress.api.sunlightfoundation.com/",
##   "legislators/locate?latitude=42.96&longitude=-108.09", key))


## ----tidy=FALSE, eval=FALSE----------------------------------------------
## #Create your own appication key at https://dev.twitter.com/apps
## consumer_key = "EZRy5JzOH2QQmVAe9B4j2w";
## consumer_secret = "OIDC4MdfZJ82nbwpZfoUO4WOLTYjoRhpHRAWj6JMec";
## 
## #Use basic auth
## library(httr)
## secret <- RCurl::base64(paste(consumer_key, consumer_secret, sep=":"));
## req <- POST("https://api.twitter.com/oauth2/token",
##   config(httpheader = c(
##     "Authorization" = paste("Basic", secret),
##     "Content-Type" = "application/x-www-form-urlencoded;charset=UTF-8"
##   )),
##   body = "grant_type=client_credentials",
##   multipart = FALSE
## );
## 
## #Extract the access token
## token <- paste("Bearer", content(req)$access_token);
## 
## #Actual API call
## url = "https://api.twitter.com/1.1/statuses/user_timeline.json?count=10&screen_name=UCLA"
## call1 <- GET(url, config(httpheader = c("Authorization" = token)))
## obj1 <- fromJSON(rawToChar(call1$content))
## print(obj1$text)


