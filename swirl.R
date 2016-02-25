#swirl notes

# swirl setup
install.packages("swirl")
library(swirl)
install_from_swirl("R Programming")
swirl()
Mark

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


# swirl 13: simulation
?sample
sample(1:6, 4, replace=TRUE)  # simulation of six-sided dice
sample(1:20, 10)
LETTERS
sample(LETTERS)
flips <- sample(c(0,1),100,replace=TRUE,prob=c(0.3,0.7))
flips
sum(flips)
?rbinom
rbinom(1, size = 100, prob = 0.7)
flips2 <- rbinom(100, size = 1, prob = 0.7)
flips2
sum(flips2)
?rnorm
rnorm(10)
rnorm(10,100,25)  #10 observations, mean=100,sd=25
rpois(5,10)       #Generate 5 random values from a Poisson distribution with mean 10.
my_pois <- replicate(100, rpois(5,10)) #do the same 100 times
my_pois
cm <- colMeans(my_pois)
hist(cm)

# swirl 15: Base Graphics
data(cars)
?cars
head(cars)
plot(cars)
?plot
plot(x=cars$speed,y=cars$dist)
plot(x=cars$dist,y=cars$speed)
plot(x = cars$speed, y = cars$dist, xlab="Speed")
plot(x = cars$speed, y = cars$dist, ylab="Stopping Distance")
plot(x = cars$speed, y = cars$dist, xlab="Speed", ylab="Stopping Distance")
plot(cars, main="My Plot")
plot(cars, sub="My Plot Subtitle")
plot(cars, col=2)
plot(cars, xlim = c(10, 15))
plot(cars, pch=2)

data(mtcars)   # load the mtcars data frame
?boxplot
boxplot(mpg ~ cyl,mtcars)
hist(mtcars$mpg)

## Getting and Cleaning Data course
ls()
rm(list=ls())
install.packages("swirl")
packageVersion("swirl")  #need 2.2.21 or later
install_from_swirl("Getting and Cleaning Data")
library("swirl")
swirl()
Mark
mydf <- read.csv(path2csv,stringsAsFactors=FALSE)
dim(mydf)
head(mydf)
library(dplyr)
packageVersion("dplyr")
cran <- tbl_df(mydf)  #load a dataframe into a data frame tbl_df
rm("mydf")
cran  #"The main advantage to using a tbl_df over a regular data frame is the printing."
# dplyr supplies five 'verbs' that cover most fundamental data manipulation tasks: select(), filter(), arrange(), mutate(), and summarize()

#select
?select
select(cran, ip_id, package, country)  #select only the ip_id, package, and country variables from the cran dataset.
5:20  #return a sequence of numbers
select(cran,r_arch:country)  #select all columns starting from r_arch and ending with country.
select(cran,country:r_arch)
cran
select(cran,-time)  #print all columns except time
-5:20
-(5:20)
select(cran, -(X:size))  #select a subset of columns, excluding any between X and size

#filter
# package == "swirl" returns a vector of TRUEs and FALSEs. filter() then returns only the rows of cran corresponding to the TRUEs.
filter(cran, package == "swirl")    #select all rows for which the package variable is equal to "swirl".
filter(cran, r_version == "3.1.1", country == "US") 
filter(cran, r_version <= "3.0.2", country == "IN")
filter(cran, country == "US" | country == "IN")
filter(cran, size > 100500, r_os == "linux-gnu")
is.na(c(3,5,NA,10))
!is.na(c(3,5,NA,10))
filter(cran, !is.na(r_version))

#arrange
cran2 <- select(cran,size:ip_id)
arrange(cran2,ip_id)
arrange(cran2,desc(ip_id))
arrange(cran2,package,ip_id)
arrange(cran2,country,desc(r_version),ip_id)

#mutate
cran3 <- select(cran,ip_id,package,size)
cran3
mutate(cran3, size_mb = size / 2^20)
mutate(cran3, size_mb = size / 2^20, size_gb = size_mb / 2^10)
mutate(cran3, correct_size = size+1000)

#summarize
summarize(cran, avg_bytes = mean(size))


# Lesson 2: Grouping and Chaining with dplyr
library(swirl)
swirl()
Mark
cran <- tbl_df(mydf)
rm("mydf")
cran

#
?group_by
by_package <- group_by(cran,package)
by_package   # note Groups: package [6023] at top
summarize(by_package,mean(size))

# Compute four values, in the following order, from
# the grouped data:
#
# 1. count = n()
# 2. unique = n_distinct(ip_id)     n_distinct is same as length(unique(x))
# 3. countries = n_distinct(country)
# 4. avg_bytes = mean(size)
#
# A few thing to be careful of:
#
# 1. Separate arguments by commas
# 2. Make sure you have a closing parenthesis
# 3. Check your spelling!
# 4. Store the result in pack_sum (for 'package summary')
#
# You should also take a look at ?n and ?n_distinct, so
# that you really understand what is going on.

pack_sum <- summarize(by_package, count = n(),unique = n_distinct(ip_id),countries = n_distinct(country),avg_bytes = mean(size))
pack_sum

quantile(pack_sum$count, probs = 0.99)   #gives the top 1% of downloads
top_counts <- filter(pack_sum,count > 679)
top_counts
View(top_counts)
top_counts_sorted <- arrange(top_counts,desc(count))
View(top_counts_sorted)
quantile(pack_sum$unique, probs = 0.99)   #gives the top 1% of UNIQUE downloads
top_unique <- filter(pack_sum,unique > 465)
top_unique
View(top_unique)
top_unique_sorted <- arrange(top_unique,desc(unique))
View(top_unique_sorted)

# Chaining allows you to string together multiple function calls in a way that is compact and readable, 
# while still accomplishing the desired result. To make it more concrete, let's compute our last popularity metric from scratch, 
# starting with our original data.
by_package <- group_by(cran, package)
pack_sum <- summarize(by_package,count = n(),unique = n_distinct(ip_id),countries = n_distinct(country),avg_bytes = mean(size))
# Here's the new bit, but using the same approach we've been using this whole time.
top_countries <- filter(pack_sum, countries > 60)
result1 <- arrange(top_countries, desc(countries), avg_bytes)
# Print the results to the console.
print(result1)

# We'd like to accomplish the same result as the last script, but avoid saving our intermediate results. 
# This requires embedding function calls within one another.
result2 <-
  arrange(
    filter(
      summarize(
        group_by(cran,
                 package
        ),
        count = n(),
        unique = n_distinct(ip_id),
        countries = n_distinct(country),
        avg_bytes = mean(size)
      ),
      countries > 60
    ),
    desc(countries),
    avg_bytes
  )
print(result2)

# In this script, we've used a special chaining operator, %>%, which was originally introduced in the magrittr R package 
# and has now become a key component of dplyr. You can pull up the related documentation with ?chain. 
# The benefit of %>% is that it allows us to chain the function calls in a linear fashion. 
# The code to the right of %>% operates on the result from the code to the left of %>%.
result3 <-
  cran %>%
  group_by(package) %>%
  summarize(count = n(),
            unique = n_distinct(ip_id),
            countries = n_distinct(country),
            avg_bytes = mean(size)
  ) %>%
  filter(countries > 60) %>%
  arrange(desc(countries), avg_bytes)
# Print result to console
print(result3)
View(result3)

#test script:1
cran %>%
  select(ip_id, country, package, size) %>%
  mutate(size_mb = size / 2^20) %>%
  filter(size_mb <= 0.5) %>%
  arrange(desc(size_mb))

# swirll
# Lesson 1: Dates and Times with lubridate
# go to Getting and Cleaning Data

library(swirl)
install_from_swirl("Dates and Times with lubridate")
swirl()
Mark
2
1

Sys.getlocale("LC_TIME")
library(lubridate)
help(package=lubridate)

today()
this_day <- today()
this_day
year(this_day)
wday(this_day)
wday(this_day,label=TRUE)
this_moment <- now()
this_moment
minute(this_moment)

my_date <- ymd("1989-05-17")
my_date
class(my_date)

ymd("1989 May 17")
mdy("March 12, 1975")
dmy(25081985)
ymd("192012")
ymd("1902/1/2")
ymd("1920/1/2")
dt1
ymd_hms(dt1)
hms("03:22:14")
dt2
ymd(dt2)
update(this_moment, hours = 8, minutes = 34, seconds = 55)
this_moment
this_moment <- update(this_moment, hours = 8, minutes = 34, seconds = 55)
this_moment

nyc <- now(tzone = "America/New_York")
nyc
depart <- nyc + days(2)
depart
depart <- update(depart,hours=17,minutes=34)
depart
arrive <- depart + hours(15) + minutes(50)
arrive <- with_tz(arrive,tzone="Asia/Hong_Kong")
arrive
last_time <- mdy("June 17, 2008",tz="Singapore")
last_time
?new_interval
how_long <- new_interval(last_time,arrive)
as.period(how_long)
stopwatch()
2
rSEeAshNDgF3gxqq
