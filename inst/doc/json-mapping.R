
## ----echo=FALSE----------------------------------------------------------
library(jsonlite)
library(knitr)
opts_chunk$set(comment="")

#this replaces tabs by spaces because latex-verbatim doesn't like tabs
toJSON <- function(...){
  gsub("\t", "  ", jsonlite::toJSON(...), fixed=TRUE);
}


## ------------------------------------------------------------------------
txt <- '[12, 3, 7]'
x <- fromJSON(txt)
is(x)
print(x)


## ----eval=FALSE----------------------------------------------------------
## library(testthat)
## test_package("jsonlite")


## ------------------------------------------------------------------------
x <- c(1, 2, pi)
cat(toJSON(x))


## ------------------------------------------------------------------------
x <- c(TRUE, FALSE, NA)
cat(toJSON(x))


## ------------------------------------------------------------------------
x <- c(1,2,NA,NaN,Inf,10)
cat(toJSON(x))


## ------------------------------------------------------------------------
cat(toJSON(c(TRUE, NA, NA, FALSE)))
cat(toJSON(c("FOO", "BAR", NA, "NA")))
cat(toJSON(c(3.14, NA, NaN, 21, Inf, -Inf)))
cat(toJSON(c(3.14, NA, NaN, 21, Inf, -Inf), na="null"))


## ------------------------------------------------------------------------
cat(toJSON(Sys.time() + 1:3))
cat(toJSON(as.Date(Sys.time()) + 1:3))
cat(toJSON(factor(c("foo", "bar", "foo"))))
cat(toJSON(complex(real=runif(3), imaginary=rnorm(3))))


## ------------------------------------------------------------------------
#vectors of length 0 and 1
cat(toJSON(vector()))
cat(toJSON(pi))

#vectors of length 0 and 1 in a named list
cat(toJSON(list(foo=vector())))
cat(toJSON(list(foo=pi)))

#vectors of length 0 and 1 in an unnamed list
cat(toJSON(list(vector())))
cat(toJSON(list(pi)))


## ------------------------------------------------------------------------
x <- matrix(1:12, nrow=3, ncol=4)
print(x)
print(x[2,4])


## ------------------------------------------------------------------------
attributes(volcano)
length(volcano)


## ------------------------------------------------------------------------
x <- matrix(1:12, nrow=3, ncol=4)
cat(toJSON(x))


## ------------------------------------------------------------------------
x <- matrix(c(1,2,4,NA), nrow=2)
cat(toJSON(x))
cat(toJSON(x, na="null"))
cat(toJSON(matrix(pi)))


## ------------------------------------------------------------------------
x <- matrix(c(NA,1,2,5,NA,3), nrow=3)
row.names(x) <- c("Joe", "Jane", "Mary");
colnames(x) <- c("Treatment A", "Treatment B")
print(x)
cat(toJSON(x))


## ------------------------------------------------------------------------
library(reshape2)
y <- melt(x, varnames=c("Subject", "Treatment"))
print(y)
cat(toJSON(y, pretty=TRUE))


## ------------------------------------------------------------------------
cat(toJSON(as.data.frame(x), pretty=TRUE))


## ------------------------------------------------------------------------
mylist1 <- list("foo" = 123, "bar"= 456)
print(mylist1$bar)
mylist2 <- list(123, 456)
print(mylist2[[2]])


## ------------------------------------------------------------------------
cat(toJSON(list(c(1,2), "test", TRUE, list(c(1,2)))))


## ------------------------------------------------------------------------
x <- list(c(1,2,NA), "test", FALSE, list(foo="bar"))
identical(fromJSON(toJSON(x)), x)


## ------------------------------------------------------------------------
cat(toJSON(list(foo=c(1,2), bar="test")))


## ----tidy=FALSE----------------------------------------------------------
cat(toJSON(list(foo=list(bar=list(baz=pi)))))


## ------------------------------------------------------------------------
x <- list(foo=123, "test", TRUE)
attr(x, "names")
x$foo
x[[2]]


## ------------------------------------------------------------------------
x <- list(foo=123, "test", TRUE)
print(x)
cat(toJSON(x))


## ------------------------------------------------------------------------
is(iris)
names(iris)
print(iris[1:3, c(1,5)])
print(iris[1:3, c("Sepal.Width", "Species")])


## ------------------------------------------------------------------------
cat(toJSON(iris[1:2,], pretty=TRUE))


## ------------------------------------------------------------------------
cat(toJSON(list(list(Species="Foo", Width=21)), pretty=TRUE))


## ------------------------------------------------------------------------
x <- data.frame(foo=c(FALSE, TRUE,NA,NA), bar=c("Aladdin", NA, NA, "Mario"))
print(x)
cat(toJSON(x, pretty=TRUE))


## ----tidy=FALSE----------------------------------------------------------
options(stringsAsFactors=FALSE)
x <- data.frame(driver = c("Bowser", "Peach"), occupation = c("Koopa", "Princess"))
x$vehicle <- data.frame(model = c("Piranha Prowler", "Royal Racer"))
x$vehicle$stats <- data.frame(speed = c(55, 34), weight = c(67, 24), drift = c(35, 32))
str(x)
cat(toJSON(x, pretty=TRUE))
myjson <- toJSON(x)
y <- fromJSON(myjson)
identical(x,y)


## ------------------------------------------------------------------------
z <- cbind(x[c("driver", "occupation")], x$vehicle["model"], x$vehicle$stats)
str(z)


## ----tidy=FALSE----------------------------------------------------------
x <- data.frame(author = c("Homer", "Virgil", "Jeroen"))
x$poems <- list(c("Iliad", "Odyssey"), c("Eclogues", "Georgics", "Aeneid"), vector());
names(x)
cat(toJSON(x, pretty = TRUE))


## ----tidy=FALSE----------------------------------------------------------
x <- data.frame(author = c("Homer", "Virgil", "Jeroen"))
x$poems <- list(
  data.frame(title=c("Iliad", "Odyssey"), year=c(-1194, -800)),
  data.frame(title=c("Eclogues", "Georgics", "Aeneid"), year=c(-44, -29, -19)),
  data.frame()
)
cat(toJSON(x, pretty=TRUE))


## ------------------------------------------------------------------------
#Heterogeneous lists are bad!
x <- list("FOO", 1:3, list("bar"=pi))
cat(toJSON(x))


## ------------------------------------------------------------------------
#conceptually homogenous array
x <- data.frame(name=c("Jay", "Mary", NA, NA), gender=c("M", NA, NA, "F"))
cat(toJSON(x, pretty=TRUE))


## ----tidy=FALSE----------------------------------------------------------
x <- list(
  humans = data.frame(name = c("Jay", "Mary"), married = c(TRUE, FALSE)),
  horses = data.frame(name = c("Star", "Dakota"), price = c(5000, 30000))
)
cat(toJSON(x, pretty=TRUE))


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
## races$RaceTable$Races$MRData$Results[[1]]$Driver


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
## #basic auth
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
## res <- fromJSON(rawToChar(req$content))
## token <- paste("Bearer", res$access_token);
## 
## #Actual API call
## url = "https://api.twitter.com/1.1/statuses/user_timeline.json?count=10&screen_name=UCLA"
## call1 <- GET(url, config(httpheader = c("Authorization" = token)))
## obj1 <- fromJSON(rawToChar(call1$content))


## ----eval=FALSE----------------------------------------------------------
## mydata <- airquality[1:2,]
## y <- reshape2::melt(data = mydata, id = c("Month", "Day"))
## cat(toJSON(y))


