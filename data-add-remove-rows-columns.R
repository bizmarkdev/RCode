# Add/Remove rows and columns
# http://www.statmethods.net/management/merging.html

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

###############################################################
# Merging data lecture

# merging data

# http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0026895

if(!file.exists("./data")){dir.create("./data")}
fileUrl1 = "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 = "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1,destfile="./data/reviews.csv",method="curl")
download.file(fileUrl2,destfile="./data/solutions.csv",method="curl")
reviews = read.csv("./data/reviews.csv"); 
solutions <- read.csv("./data/solutions.csv")
head(reviews)
head(solutions)

names(reviews)
names(solutions)
# default is to merge by all variables with the same name
# by statements override the default
# all=TRUE directs to include rows with missing values, giving the columns NA
mergedData = merge(reviews,solutions,by.x="solution_id",by.y="id",all=TRUE)
head(mergedData)
names(mergedData)

# default is to merge by all variables with the same name
intersect(names(solutions),names(reviews))

# using join in the plyr package
# faster than merge, but only can merge on common variable names
# join(x, y, by = NULL, type = "left", match = "all")
df1 = data.frame(id=sample(1:10),x=rnorm(10))
df2 = data.frame(id=sample(1:10),y=rnorm(10))
arrange(join(df1,df2),id)

# join_all works well with multiple data frames
df1 = data.frame(id=sample(1:10),x=rnorm(10))
df2 = data.frame(id=sample(1:10),y=rnorm(10))
df3 = data.frame(id=sample(1:10),z=rnorm(10))
dfList = list(df1,df2,df3)
join_all(dfList)

#####################################################
# From Week3 quiz, Cleaning Data
#3
#install.packages("data.table")
library(data.table)
# download each file and clean it up as much as possible
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
f <- file.path(getwd(), "getdata-data-GDP.csv")
download.file(url, f)
dtGDP <- data.table(read.csv(f))
# inspect data. note first 4 rows are headers and the last country is at row 219 (219-4=215)
dtGDP <- data.table(read.csv(f, skip = 4, nrows = 215))
# remove rows with blank country
dtGDP <- dtGDP[X != ""]
# remove unneeded columns
dtGDP <- dtGDP[, list(X, X.1, X.3, X.4)]
# give meaningful variable names
setnames(dtGDP, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", "Long.Name", "gdp"))

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
f <- file.path(getwd(), "getdata-data-EDSTATS_Country.csv")
download.file(url, f)
dtEd <- data.table(read.csv(f))
# inspect data. 

dt <- merge(dtGDP, dtEd, all = TRUE, by = c("CountryCode"))
# how many of the IDs match?
sum(!is.na(unique(dt$rankingGDP)))    #[1] 189
# Sort the data frame in descending order by GDP rank (so United States is last).
# What is the 13th country in the resulting data frame?
dt[order(rankingGDP, decreasing = TRUE), list(CountryCode, Long.Name.x, Long.Name.y, rankingGDP, gdp)][13]
###########################################################################

