# Add/Remove rows and columns

set.seed(13435)
x <- data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
x <-x[sample(1:5),]
x$var2[c(1,3)] = NA
x

x$var4 <- rnorm(5)
x

# cbind
y <- cbind(x,rnorm(5))
y

# rbind

# https://data.baltimorecity.gov/Community/Restaurants/k5ry-ef3g
# > Export > baltimore-restaurants.csv
if (!file.exists("data")){dir.create("data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile="./data/restaurants.csv",method="curl")
restData <- read.csv("./data/restaurants.csv")

# Append a variable of restaurants that are near me
restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)

# Append a variable of restaurants with bad zipcodes
restData$zipWrong <- ifelse(restData$zipCode < 0, TRUE, FALSE)
table(restData$zipWrong,restData$zipCode < 0)

# Append a factor (categorical) variable by breaking up quantiative variables
# cut divides the range of x into intervals and codes the values in x according to which interval they fall. 
# The leftmost interval corresponds to level one, the next leftmost to level two and so on.
# Returns a factor variable
restData$zipGroups = cut(restData$zipCode,breaks=quantile(restData$zipCode))
table(restData$zipGroups)
is.factor(restData$zipGroups)  # cut returns a factor variable

# Append a variable with mutate
# dplyr supplies five 'verbs' that cover most fundamental data manipulation tasks: 
#   select(), filter(), arrange(), mutate(), and summarize()
# See: swirll: Getting and Cleaning Data
library(Hmisc)
library(plyr)
restData2 = mutate(restData,zipGroups2=cut2(zipCode,g=4))
table(restData2$zipGroups2)


# Creating sequences for an index to a data set
s1 <- seq(1,10,by=2); s1
s2 <- seq(1,10,length=3); s2
x <- c(1,3,8,25,100); seq(along = x)
