## Read mySQL

# http://biostat.mc.vanderbilt.edu/wiki/Main/RMySQL
install.packages("RMySQL")
library(RMySQL)

# connect to: http://genome.ucsc.edu and list databases 
ucscDb <- dbConnect(MySQL(),user="genome", host="genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb,"show databases;")
dbDisconnect(ucscDb)    # note that dbDisconnect returns: [1] TRUE
result

# connect to localhost (MAMP)   http://apknightcode.blogspot.com/2012/09/first-post.html
mampDb <- dbConnect(MySQL(),user="gipp", password="fr444d0m", host="localhost",unix.sock="/Applications/MAMP/tmp/mysql/mysql.sock")
result <- dbGetQuery(mampDb,"show databases;")
dbDisconnect(mampDb)
result
# connect to local database (MAMP)
mampDb <- dbConnect(MySQL(),user="gipp", password="fr444d0m", host="localhost",dbname="truthunity", unix.sock="/Applications/MAMP/tmp/mysql/mysql.sock")
allTables <- dbListTables(mampDb)
dbDisconnect(mampDb)

# list tables in a database
hg19 <- dbConnect(MySQL(),user="genome",db="hg19",host="genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
length(allTables)

# load a table into a data frame
dbListFields(hg19,"affyU133Plus2")   # get fields (columns) for affyU133Plus2 table
dbGetQuery(hg19,"select count(*) from affyU133Plus2")  # get number of records (rows) for affyU133Plus2 table
affyData <- dbReadTable(hg19, "affyU133Plus2")  #extract table to a data frame
head(affyData)

# select a subset of the data
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query)
quantile(affyMis$misMatches)
affyMisSmall <- fetch(query,n=10)
dbClearResult(query)   # should return: [1] TRUE
dim(affyMisSmall)
dbDisconnect(hg19)     # should return: [1] TRUE

# http://cran.r-project.org/web/packages/RMySQL/RMySQL.pdf
# http://www.pantz.org/software/mysql/mysqlcommands.html
# http://www.r-project.org/mysql-and-r/
