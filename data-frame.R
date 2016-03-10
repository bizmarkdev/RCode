# Notes on matrices, dataframes, datatables

# reading character data problem:
# if character data, it is loaded as a factor instead of as character.
#
# Factors represent a very efficient way to store character values, 
# because each unique character value is stored only once, 
# and the data itself is stored as a vector of integers. 
# Because of this, read.table will automatically convert character variables to factors 
# unless the as.is= argument is specified. See Section  for details.
options(stringsAsFactors = FALSE)
state_rank_df = data.frame(hospital = character(),state = character(),stringsAsFactors = FALSE)

## Build a matrix and then convert it to a data frame

#What is the Pearson product-moment correlation coefficient for the two variables? p.109
student<-c(1:7)
sat<-c(595,520,715,405,680,490,565)
gpa<-c(3.4,3.2,3.9,2.3,3.9,2.5,3.5)
cor(sat,gpa)

z<-cbind(student,sat,gpa)
cor(z$sat,z$gpa)  #returns: Error in z$sat : $ operator is invalid for atomic vectors because it's a matrix
class(z)
z=as.data.frame(z)  #transforms matrix to a dataframe
class(z)
cor(z$sat,z$gpa)


#from Data Frames. Important! vector & matrix vs list & dataframe
x<-data.frame(foo=1:4,bar=c(T,T,F,F))
x
ncol(x)  #number of columns in the dataframe


#Loop through a column
# get vector of states
states <- unique(measures$State)
states <- sort(states)
for(state in states){
  #get a subset of observations for each state.
  state_name = state
  state_measures <- measures[measures$State == state_name,]
  # Rank state subset by 30-day mortality, hospital name
  state_measures <- state_measures[with(state_measures, order(as.numeric(state_measures[,3]), state_measures[,1])),] 
}

###########################################################################

# Data Tables

## data.table
#    Enhanced data.frame
#    Inherets from data.frame (nearly identical syntax)
#    written in C so it is much faster at subsetting, group and updating
# http://stackoverflow.com/questions/13618488/what-you-can-do-with-data-frame-that-you-cant-in-data-table
# https://github.com/raphg/Biostat-578/blob/master/Advanced_data_manipulation.Rmd
library(data.table)
df = data.frame(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
head(df,20)
dt = data.table(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
head(dt,20)
tables()  #list all tables in memory

## subsetting data.table data.frame
#    if subset is only one index, then it subsets on the rows
dt[2,]
dt[dt$y=="a",]
dt[c(2,3)]  #return rows 2 and 3
#    after the comma, is an expression, not the column. An expression is anthing in {} brackets
dt[,list(mean(x),sum(z))]  # return mean of x values and sum of z values
dt[,table(y)]  # return a table of y values

## adding variables and copying data tables
#    very fast and efficient way to add a variable. colon (:) means to add or change a column
dt[,w:=z^2] 
#    does not create a copy of the data, so it is efficent use of memory
dt2 <- dt    #does not copy, but rather assigns dt2 to dt (pointer)
dt[,y:=2]    #this change will apply to dt2 as well!
head(dt2,n=3)

## multi-step operations on data tables
dt[,m:={tmp <- (x+2); log2(tmp+5)}]   #applies operation to each row, adding a 'm' variable
dt    # note that it is the last operation (log2(tmp+5)) that is applied to the 'm' variable 

## plyer like operations on tables
#    by
dt[,a:=x>0]  # new variable a is TRUE or FALSE, based on if x>0
dt
dt[,b:=mean(x+w),by=a]  # new variable b is mean(x+w), based on if a is TRUE or FALSE (by=a)
dt

## data.table special variables
#    1E5 is 1e+05, about 100,000
#    sample takes a sample of the specified size from the elements of x using either with or without replacement.
#    .N gives a count of values in the group (x is 1,2 or 3) and in this case is about 100,000
1E5
set.seed(123)
dt <- data.table(x=sample(letters[1:3], 1E5, TRUE))
dt[, .N, by=x]

## data.table keys
#    when a key is set the operation is more rapid
dt <- data.table(x=rep(c("a","b","c"),each=100),y=rnorm(300))  #x is a,b or c
setkey(dt,x)  #set a key for subsetting the table based on x
dt['a']       #subset the table for x='a'
#    using a key to merge two tables
dt1 <- data.table(x=c('a','a','b','dt1'),y=1:4)
dt2 <- data.table(x=c('a','b','dt2'),z=5:7)
setkey(dt1,x); setkey(dt2,x)  # two statements on same line!
merge(dt1,dt2)  #merge observations that have a common value in x

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


