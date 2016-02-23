# Is it categorical data? If so, do not use linear regression!

# swirl 12: Looking at data
ls()
class(plants)
dim(plants)
nrow(plants)
ncol(plants)
object.size(plants)
names(plants)
head(plants)
head(plants,10)
tail(plants,15)
summary(plants)
table(plants$Active_Growth_Period)
str(plants)

# exploring a dataset
head(flags)
dim(flags)
class(flags)
cls_list <- lapply(flags,class)  # a data.frame is a list of vectors
cls_list  # displays as a list (allows multiple classes of data)
as.character(cls_list)   # displays as a vector (requires all to be of the same class)
?sapply
sapply(flags,class)
cls_vect <- sapply(flags,class)

sum(flags$orange)
flag_colors <- flags[,11:17]  # extract all rows, columns 11-17 (colums for the colors)
head(flag_colors)
lapply(flag_colors,sum)       # sum the columns as a list
sapply(flag_colors,sum)       # sum the columns as a vector
sapply(flag_colors,mean)
flag_shapes <- flags[, 19:23]
lapply(flag_shapes,range)
shape_mat <- sapply(flag_shapes,range)  # note that it returns a matrix (not a vector)
shape_mat                     # displays the min and max of each shape amongs the flags

unique(c(3,4,5,5,5,5,6,6))
unique_vals <- lapply(flags,unique)
sapply(unique_vals, length)
lapply(unique_vals, function(elem) elem[2])

vapply(flags,unique,numeric(1))  # throws an error
vapply(flags, class, character(1))

table(flags$landmass)   # table of landmass for each part of the world (1-6)
table(flags$animate)    # table of flags with animate objects
tapply(flags$animate, flags$landmass, mean) # proportion of countries with animate objects, by each part of the world

# dplyr supplies five 'verbs' that cover most fundamental data manipulation tasks: 
#   select(), filter(), arrange(), mutate(), and summarize()

# How large is the dataset?
fakeData = rnorm(1e5)
object.size(fakeData)
print(object.size(fakeData),units="Mb")

# https://data.baltimorecity.gov/Community/Restaurants/k5ry-ef3g
# > Export > baltimore-restaurants.csv
if (!file.exists("data")){dir.create("data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile="./data/restaurants.csv",method="curl")
restData <- read.csv("./data/restaurants.csv")

# inspection commands for dataset
head(restData,n=3)
tail(restData,n=3)
summary(restData)
str(restData)

# inspection of column
quantile(restData$councilDistrict,na.rm=TRUE)
quantile(restData$councilDistrict,probs=c(0.5,0.75,0.9))

# frequency and contingency tables
# table uses the cross-classifying factors to build a contingency table of the counts 
#   at each combination of factor levels.
# Note: differnece between contingency table and frequency table! 
#   https://en.wikipedia.org/wiki/Contingency_table
#   https://en.wikipedia.org/wiki/Frequency_distribution
table(restData$zipCode,useNA="ifany")  #useNA will ad a column for NA values
table(restData$councilDistrict,restData$zipCode)

# are there any missing values?
sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))

# are all zipcodes positive numbers?
all(restData$zipCode > 0)  

# inspecting values with specific characteristics
table(restData$zipCode %in% c("21212","21213"))
restData[restData$zipCode %in% c("21212","21213"),c(1:3)]

# Cross tabs
data(UCBAdmissions)
DF = as.data.frame(UCBAdmissions)
summary(DF)
# show frequency, broken down by Gender and Admit, for dataframe DF
xt <- xtabs(Freq ~ Gender + Admit,data=DF)
xt

# Flat tables
data(warpbreaks)
warpbreaks$replicate <- rep(1:9, len=54)  #append a column
xt = xtabs(breaks ~ .,data=warpbreaks)
ftable(xt)



