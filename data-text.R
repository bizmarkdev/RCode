

# typical load data set:
if (!file.exists("data")){dir.create("data")}
url <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
f <- file.path(getwd(), "./data/cameras.csv")
download.file(url, f, method="curl")
cameraData <- read.csv("./data/cameras.csv")

# Finding values: grep(),grepl()
# which rows have "Alameda" in it's intersection variable?
grep("Alameda",cameraData$intersection)
# logical vector (TRUE/FALSE) for all 80 observations regarding "Alameda" in their intersection variable.
grepl("Alameda",cameraData$intersection)
table(grepl("Alameda",cameraData$intersection))
# return dataset of cameraData where "Alameda" does not appear in intersection
cameraData2 <- cameraData[!grepl("Alameda",cameraData$intersection),]

# more on grep()
# return the actual values, not just the element number:
grep("Alameda",cameraData$intersection,value=TRUE)
# return number of times the value is found:
grep("JeffStreet",cameraData$intersection)
# return the length. If zero, then the value is not in the content.
length(grep("JeffStreet",cameraData$intersection))

# Useful string functions
library(stringr)
nchar("Mark Hicks")
#
substr("Mark Hicks",1,7)  #[1] "Mark Hi"
#
paste("Mark","Hicks")     #[1] "Mark Hicks"
paste0("Mark","Hicks")    #[1] "MarkHicks"
#
str_trim("Mark    ")      #[1] "Mark"

