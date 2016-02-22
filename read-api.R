## Reading from an API

# Demo at httr on github (hadley): https://github.com/hadley/httr/tree/master/demo
# twitter, vimeo, yahoo, azure, facebook, github, google, linkedin



# Twitter
# https://apps.twitter.com/
# New app. Obtain ConsumerKey and ConsumerSecretKey

# See api docs for access:
# https://dev.twitter.com/rest/reference/get/search/tweets

# Access page
# https://dev.twitter.com/rest/reference/get/statuses/home_timeline
# see on this page the Resource URL. Used in GET statement.
myapp = oath_app("twitter", key="yourConsumerKeyHere",secret="yourConsumerSecretHere")
sig = sign_oath1.0(myapp,token="yourTokenHere",token_secret = "yourTokenSecretHere")
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json",sig)

# see the content data, use the "content" to access the data
names(homeTL)  #not tested. 

# Converting the json object
# content function will recognize it is json data. 
# Will return a structured R object for JSON (json1). Hard to read.
# Reformat it as a dataframe (json2) using the jsonlite package
json1 = content(homeTL)  
json2 = jsonlite::fromJSON(toJSON(json1))
# Each row is a tweet.
json[1,1:4]   # look at first tweet, first four columns

                  