# Dates

# Working with dates

d1 = date()
class(d1)         # date() returns a character class
d2 = Sys.Date()
class(d2)         # Sys.Date() returns a date class

format(d2,"%a %A %m %b %y %Y %d")

# creating dates
x = c("1jan1960", "2jan1960")
z = as.Date(x, "%d%b%Y")
z
class(z)

# time difference in dates
z[1] - z[2]
class(z[1]-z[2])
as.numeric(z[1]-z[2])
class(as.numeric(z[1]-z[2]))

weekdays(d2)      #wday in lubridate
months(d2)
julian(d2)

# http://www.r-statistics.com/2012/03/do-more-with-dates-and-times-in-r-with-lubridate-1-1-0/
# install.packages("lubridate")
library(lubridate)
Sys.getlocale("LC_TIME")
help(package=lubridate)

d3 = ymd("20140108")
class(ymd)   # ymd is a function!
class(d3)    # [1] "POSIXct" "POSIXt"

mdy("08/04/2013")
dmy("27-06-1953")
d4 = ymd("2016-03-14")
ymd_hms("2011-08-03 10:15:03")
ymd_hms("2011-08-03 10:15:03",tz="Pacific/Auckland")

wday(d3)    #weekdays in base R
wday(d3,label=TRUE)

?Sys.timezone
?POSIXlt
# http://en.wikipedia.org/wiki/List_of_tz_database_time_zones
?with_tz
