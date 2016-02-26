

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

####################################################################################
# Regular Expressions in R

# Metacharacters: Start/End of a line:
#   ^i think                  ^: Start of a line
#   morning$                  $: End of a line
#   9.11                      .: Any character. Any 9, any char, any 11
#   flood|fire                |: Either/or
#   ^([Gg]ood|[Bb]ad)         |: Good or Bad at beginning of line
#   [Gg]eo( [Ww]\.)? [Bb]ush  ?: Optional. Geo Bush or Geo W. Bush. 
#   (.*)                      *: repetition: zero or more chars inside ()
#   [0-9]+                    +: repetition: at least one number.
#   Bush() +[^ ]+ +){1,5} de  {}: repetition: 1 to 5 times: Bush space, not a space, space, debate
#                             {}: m,n at least but not more; m exactly; m, at least
#    +([a-zA-Z]+) +\1 +       \1: repetition. Match last matched phrase. " So So" or " blah blah"
#   ^s(.*)s                   * is greedy. Will match all of "sitting at starbucks"
#   ^s(.*?)s$                 *? not greedy.
#   
# Character class:
#   [Bb] [Uu] [Ss] [Hh]   Character classes match anywhere will match
#   ^[Ii]                 Uppper or lower "i" at start of line
#   ^[0-9][a-zA-Z]        Start of line, any number, followed by any letter
#   [^?.]$                ^ in class negates: at end of line, any char other than ? or .

####################################################################################

# Remove thousand separator from a column
url.csv <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
file.csv <- file.path(getwd(), "getdata-data-GDP.csv")
download.file(url.csv, file.csv)
gdp <- read.csv("getdata-data-GDP.csv",skip=4,nrows=190)
gdp$X.4 <- as.numeric(gsub(",", "", as.character(gdp$X.4)))
