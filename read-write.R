
# Write R code for writing out objects
dput(x,file="dumpfile.txt")

#========================================================
# Read all files in a directory into one dataframe

pollutantmean<-function(directory,id=1:332){
  # change to the requested directory
  home_wd<-getwd()
  setwd(directory)
  #debug print(getwd())
  #debug flush.console()
  
  # Construct data frame
  file_list <- list.files()
  #debug file_list_id <- as.numeric(substring(file_list,1,3)) 
  #debug files_processed<-0
  
  for (file in file_list){
    file_number <- as.numeric(substring(file,1,3))
    if (file_number %in% id){
      #debug files_processed<-append(files_processed, file_number)
      if (!exists("pollution_data")){
        pollution_data <- read.csv(file)
      }
      else if (exists("pollution_data")){
        temp_dataset <-read.csv(file)
        pollution_data<-rbind(pollution_data, temp_dataset)
        rm(temp_dataset)
      }
    }
  }
  
  #return to home directory
  setwd(home_wd)
  
  #debug return(files_processed)
  #debug return(id)
  #debug return(file_list_id)
  #debug return(file_list)
  #debug return(pollution_data)
}
#========================================================

## data.table fast reading from disk
#    create a big file
#    place that file in temp directory
#    /var/folders/f6/mqbr5p497nlcz5314nltm2340000gn/T/RtmphX6sbl
big_df <- data.frame(x=rnorm(1E6),y=rnorm(1E6))
tempdir()   #the temp directory for this session of R
file <- tempfile()  #create a file in the tempdir
write.table(big_df,file=file,row.names=FALSE, col.names=TRUE, sep="\t",quote=FALSE)
#    read the file as a data frame. elapsed time is 0.298 seconds.
system.time(fread(file))
#    read the file as a data table. elapsed time is 6.470 seconds.
system.time(read.table(file,header=TRUE,sep="\t"))
#========================================================

# Read an XML file
library(XML)
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(fileURL, destfile=tf <- tempfile(fileext=".xml"))
doc <- xmlParse(tf)
zip <- xpathSApply(doc, "/response/row/row/zipcode", xmlValue)
sum(zip == "21231")

## Download a CSV file from the web
#      curl method needed if https and called from a mac
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile="american-community-survey.csv",method="curl")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf"
download.file(fileUrl, destfile="american-community-survey.pdf",method="curl")
dateDownloaded <- date()
dateDownloaded

## Reading local files
#    read.table(), read.csv(), read.csv2()
#    important parameters: quote, na.strings, nrows, skip. 
acs <- read.csv("american-community-survey.csv")
head(acs)
dim(acs)

## remove variables not wanted
acs <- acs[c("VAL","FES")]
# acs <- subset(acs, select = c("VAL","FES"))

## Download a Excel file from the web
#      curl method needed if https and called from a mac
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile="natural-gas-aquisition.xlsx",method="curl")
# inspect the file with Excel
library(xlsx)
dat <- read.xlsx("natural-gas-aquisition.xlsx",sheetIndex=1,rowIndex=c(18:23),colIndex=c(7:15),header=TRUE)
head(nga)
dim(nga)
sum(dat$Zip*dat$Ext,na.rm=T)

## Download a CSV file from the web
#    get the URL for scripting a download:
#      https://data.baltimorecity.gov/Transportation/Baltimore-Fixed-Speed-Cameras/dz54-2aru
#      > Export > CSV > link address
#      curl method needed if https and called from a mac
if (!file.exists("data")){dir.create("data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile="./data/cameras.csv",method="curl")
list.files("./data")
dateDownloaded <- date()
dateDownloaded

## Reading local files
#    read.table(), read.csv(), read.csv2()
#    important parameters: quote, na.strings, nrows, skip. 
cameraData <- read.table("./data/cameras.csv", sep=",", header = TRUE)
cameraData <- read.csv("./data/cameras.csv")
head(cameraData)

## Download an Excel file from the web
#    requires xlsx package. xlsx package requires legacy Java 6 runtime for OS X
#      https://support.apple.com/kb/DL1572?locale=en_US
#    get the URL for scripting a download:
#      https://data.baltimorecity.gov/Transportation/Baltimore-Fixed-Speed-Cameras/dz54-2aru
#      > Export > Excel > link address
#      curl method needed if https and called from a mac
if (!file.exists("data")){dir.create("data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
download.file(fileUrl, destfile="./data/cameras.xlsx",method="curl")
list.files("./data")
dateDownloaded <- date()
dateDownloaded
library(xlsx)
cameraData <- read.xlsx("./data/cameras.xlsx",sheetIndex=1,header=TRUE)
head(cameraData)

## Reading specific rows (read.xlsx only)
colIndex <- 2:3
rowIndex <- 1:4
cameraData <- read.xlsx("./data/cameras.xlsx",sheetIndex=1,colIndex=colIndex,rowIndex=rowIndex)

## Further notes on Excel files
#     XLConnect package has more options. Use for complex cases
#     write.xlsx to write out

## Reading XML files
#    requires XML package
library(XML)
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileUrl,useInternal=TRUE)
rootNode <- xmlRoot(doc)
rootNode
xmlName(rootNode)
names(rootNode)
#    access parts of the XML document
rootNode[[1]]
rootNode[[1]][[1]]
xmlSApply(rootNode,xmlValue)

## Using XPath to access
#    http://www.stat.berkeley.edu/~statcur/Workshop2/Presentations/XML.pdf
#    xpath, dom, sax
#    scraping html, zillow, PubMed, itunes, 
xpathSApply(rootNode,"//name",xmlValue)
xpathSApply(rootNode,"//price",xmlValue)

# slide 13
# http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens
fileUrl <- "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"
doc <- htmlTreeParse(fileUrl,useInternal=TRUE)
scores <- xpathSApply(doc,"//div[@class='score']",xmlValue)
teams <- xpathSApply(doc,"//div[@class='game-info']",xmlValue)

## JSON
#    http://www.r-bloggers.com/new-package-jsonlite-a-smarter-json-encoderdecoder/
#    https://cran.r-project.org/web/packages/jsonlite/vignettes/json-aaquickstart.html
library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
names(jsonData$owner)
jsonData$owner$login

myjson <- toJSON(iris, pretty=TRUE)  #transform to a JSON dataset
cat(myjson)
iris2 <- fromJSON(myjson) #convert into a dataframe
head(iris2)


