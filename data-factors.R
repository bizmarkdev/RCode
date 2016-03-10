# Factors

# http://www.stat.berkeley.edu/~s133/factors.html
data <- c(1,2,2,3,1,2,3,3,1,3,3)
data[4]
fdata = factor(data)
fdata [4]
rdata = factor(data,labels=c("I","II","III"))
rdata[4]

# Factors represent a very efficient way to store character values, 
# because each unique character value is stored only once, 
# and the data itself is stored as a vector of integers. 
# Because of this, read.table will automatically convert character variables to factors 
# unless the as.is= argument is specified. See Section  for details.

# Factors: categorical data
x<-factor(c("yes","yes","no","yes","no"))
x
# Factors are really integers with ann additional attribute of Levels
class(x)
unclass(x)
# because no is lower in alphabetical order, it gets 1



# https://data.baltimorecity.gov/Community/Restaurants/k5ry-ef3g
# > Export > baltimore-restaurants.csv
if (!file.exists("data")){dir.create("data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile="./data/restaurants.csv",method="curl")
restData <- read.csv("./data/restaurants.csv")

# Append a factor variable by breaking up quantiative variables
# cut divides the range of x into intervals and codes the values in x according to which interval they fall. 
# The leftmost interval corresponds to level one, the next leftmost to level two and so on.
# Returns a factor variable
restData$zipGroups = cut(restData$zipCode,breaks=quantile(restData$zipCode))
table(restData$zipGroups)
is.factor(restData$zipGroups)  # cut returns a factor variable

# Hmisc does easier cutting
install.packages("Hmisc")
library(Hmisc)
restData$zipGroups = cut2(restData$zipCode,g=4)
table(restData$zipGroups)
class(restData$zipGroups)

# Append a factor variable by converting another variable
restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]
is.factor(restData$zcf)
head(restData)

# Levels of factor variables
# levels are an attribute.
yesno <- sample(c("yes","no"),size=10,replace=TRUE)
class(yesno)    #character
yesnofac = factor(yesno,levels=c("yes","no"))
class(yesnofac) #factor
relevel(yesnofac,ref="yes")

as.numeric(yesnofac)  #treat factor var as numeric var
