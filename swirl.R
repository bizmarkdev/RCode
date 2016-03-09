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

#######################################################################################
# GETTIGN AND CLEANING DATA
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

# swirl
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

#######################################################################################
# EXPLORATORY DATA ANALYSIS

# Swirl: 
install.packages("swirl")
library(swirl)
install_from_swirl("Exploratory Data Analysis")
swirl()
# https://github.com/DataScienceSpecialization/courses/
head(pollution)
dim(pollution)
summary(pollution$pm25)
3
quantile(ppm)
3                  # quantile does not provide a mean
boxplot(ppm,col="blue")
4
abline(h=12)
1
hist(ppm,col="green")
1
rug(ppm)
low
high
hist(ppm,col="green",breaks=100)
1
rug(ppm)
hist(ppm,col="green")
abline(v=median(ppm),lwd=4,col="magenta")
names(pollution)
reg<-table(pollution$region)
reg
barplot(reg,col="wheat",main="Number of Counties in Each Region")
3
# multiple boxplots, by region
boxplot(pm25 ~ region, data = pollution, col = "red")
# multiple histograms
par(mfrow=c(2,1),mar=c(4,4,2,1))
east<-subset(pollution,region=="east")
head(east)
hist(east$pm25,col="green")
hist(subset(pollution,region=="west")$pm25,col="green")
with(pollution,plot(latitude,pm25))
abline(h=12,lwd=2,lty=2)
plot(pollution$latitude,ppm,col=pollution$region)
2
abline(h=12,lwd=2,lty=2)
par(mfrow = c(1, 2), mar = c(5, 4, 2, 1))
west<-subset(pollution,region=="west")
plot(west$latitude,west$pm25,main="West")
plot(east$latitude,east$pm25,main="East")

#swirl Lesson 3: Graphics Devices in R
?Devices
with(faithful,plot(eruptions,waiting))
title(main="Old Faithful Geyser data")
dev.cur()
pdf(file="myplot.pdf")
with(faithful,plot(eruptions,waiting))
title(main="Old Faithful Geyser data")
dev.cur()
dev.off()
dev.cur()
with(faithful, plot(eruptions, waiting))
title(main = "Old Faithful Geyser data")
dev.copy(png,file="geyserplot.png")
dev.off()

#swirl Lesson 4: Plotting Systems
2
head(cars)
with(cars,plot(speed,dist))
text(mean(cars$speed),max(cars$dist),"SWIRL rules!")
head(state)
table(state$region)
xyplot(Life.Exp ~ Income | region,data=state, layout = c(4,1))
1
xyplot(Life.Exp ~ Income | region,data=state, layout = c(2,2))
head(mpg)
dim(mpg)
table(mpg$model)
qplot(displ,hwy,data=mpg)

#swirl Lesson 5: Base Plotting System
2
head(airquality)
range(airquality$Ozone,na.rm=TRUE)
hist(airquality$Ozone)
4
table(airquality$Month)
boxplot(Ozone~Month,airquality)
boxplot(Ozone~Month,airquality,xlab="Month",ylab="Ozone (ppb)",col.axis="blue",col.lab="red")
title(main="Ozone and Wind in New York City")
with(airquality,plot(Wind,Ozone))
title(main="Ozone and Wind in New York City")
length(par())
names(par())
par()$pin
3
par("fg")
1
2
par("pch")
2
par("lty")
2
4
plot(airquality$Wind, airquality$Ozone,type="n")
title(main="Wind and Ozone in NYC")
may<-subset(airquality,Month==5)
points(may$Wind,may$Ozone,col="blue",pch=17)
notmay<-subset(airquality,Month!=5)
points(notmay$Wind,notmay$Ozone,col="red",pch=8)
legend("topright",pch=c(17,8),col=c("blue","red"),legend = c("May","Other Months"))
abline(v=median(airquality$Wind),lty=2,lwd=2)
par(mfrow=c(1,2))
plot(airquality$Wind,airquality$Ozone,main="Ozone and Wind")
plot(airquality$Ozone,airquality$Solar.R,main="Ozone and Solar Radiation")
par(mfrow = c(1,3), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
plot(airquality$Wind,airquality$Ozone,main="Ozone and Wind")
plot(airquality$Solar.R,airquality$Ozone,main="Ozone and Solar Radiation")
plot(airquality$Temp,airquality$Ozone,main="Ozone and Temperature")
mtext("Ozone and Weather in New York City",outer=TRUE)

#swirl Week 2 Lesson 3: Latice Plotting System
library(swirl)
install_from_swirl("Exploratory Data Analysis")
swirl()
Mark
3
2
6  # Lattice plotting System
2  # box and whisker
head(airquality)
xyplot(Ozone~Wind,data=airquality)
xyplot(Ozone~Wind,data=airquality,col="red",pch=8,main="Big Apple Data")
xyplot(Ozone~Wind | as.factor(Month),data=airquality, layout=c(5,1))
1
xyplot(Ozone~Wind | Month,data=airquality, layout=c(5,1))
p <- xyplot(Ozone~Wind,data=airquality)
print(p)
names(p)
mynames[myfull]
p[["formula"]]
p[["x.limits"]]
table(f)
xyplot(y~x|f,layout=c(2,1))
v1
v2

#
myedit("plot1.R")
#
p <- xyplot(y ~ x | f, panel = function(x, y, ...) {
  panel.xyplot(x, y, ...)  ## First call the default panel function for 'xyplot'
  panel.abline(h = median(y), lty = 2)  ## Add a horizontal line at the median
})
print(p)
invisible()
#
source(pathtofile("plot1.R"),local=TRUE)
#

myedit("plot2.R")
#
p2 <- xyplot(y ~ x | f, panel = function(x, y, ...) {
  panel.xyplot(x, y, ...)  ## First call default panel function
  panel.lmline(x, y, col = 2)  ## Overlay a simple linear regression line
})
#
print(p2)
invisible()
source(pathtofile("plot2.R"),local=TRUE)

3
str(diamonds)
table(diamonds$color)
table(diamonds$color,diamonds$cut)
1

myedit("myLabels.R")
#
myxlab <- "Carat"
myylab <- "Price"
mymain <- "Diamonds are Sparkly!
#
source(pathtofile("myLabels.R"),local=TRUE)
xyplot(price~carat|color*cut,data=diamonds,strip=FALSE,pch=20,xlab=myxlab,ylab=myylab,main=mymain)
1
xyplot(price~carat|color*cut,data=diamonds,pch=20,xlab=myxlab,ylab=myylab,main=mymain)
1
2
2
2
2
2
2
2

#swirl Week 2 Lesson 3: Colors
library(swirl)
sample(colors(),10)
pal <- colorRamp(c("red","blue"))
pal(0)
pal(1)
2
pal(seq(0,1,len=6))
p1<-colorRampPalette(c("red","blue"))
p1(2)
p1(6)
0xcc
p2<-colorRampPalette(c("red","yellow"))
p2(2)
p2(10)
showMe(p1(20))
showMe(p2(20))
showMe(p2(2))
p1
?rgb
4
p3<-colorRampPalette(c("blue","green"),alpha=.5)
p3(5)
plot(x,y,pch=19,col=rgb(0,.5,.5))
plot(x,y,pch=19,col=rgb(0,.5,.5,.3))
cols<-brewer.pal(3,"BuGn")
showMe(cols)
pal<-colorRampPalette(cols)
showMe(pal(20))
image(volcano,col=pal(20))
image(volcano,col=p1(20))

#swirl Week 2 Lesson 8: GGPlot2 Part1
str(mpg)
qplot(displ,hwy,data=mpg)
qplot(displ,hwy,data=mpg,color=drv)
qplot(displ,hwy,data=mpg,color=drv,geom=c("point","smooth"))
qplot(y=hwy,data=mpg,color=drv)
myhigh
qplot(drv,hwy,data=mpg,geom="boxplot")
qplot(drv,hwy,data=mpg,geom="boxplot",color=manufacturer)
qplot(hwy,data=mpg,fill=drv)
qplot(displ,hwy,data=mpg,facets = .~drv)
qplot(hwy,data=mpg,facets=drv~.,binwidth=2)
2

#swirl Week 2 Lesson 8: GGPlot2 Part2
qplot(displ,hwy,data=mpg,geom=c("point","smooth"),facets=.~drv)
g<-ggplot(mpg,aes(displ,hwy))
summary(g)
g+geom_point()
g+geom_point()+geom_smooth()
g+geom_point()+geom_smooth(method="lm")
g+geom_point()+geom_smooth(method="lm")+facet_grid(.~drv)
g+geom_point()+geom_smooth(method="lm")+facet_grid(.~drv)+ggtitle("Swirl Rules!")
g+geom_point(color="pink",size=4,alpha=1/2)
g+geom_point(aes(color=drv),size=4,alpha=1/2)
g+geom_point(aes(color=drv))+labs(title="Swirl Rules!")+labs(x="Displacement",y="Hwy Mileage")
g+geom_point(aes(color=drv),size=2,alpha=1/2)+geom_smooth(size=4,linetype=3,method="lm",se=FALSE)
g+geom_point(aes(color=drv))+theme_bw(base_family="Times")
plot(myx,myy,type="l",ylim=c(-3,3))
g<-ggplot(testdat,aes(x=myx,y=myy))
g+geom_line()
g+geom_line()+ylim(-3,3)
g+geom_line()+coord_cartesian(ylim=c(-3,3))
#
g<-ggplot(mpg,aes(x=displ,y=hwy,color=factor(year)))
g+geom_point()
g+geom_point()+facet_grid(drv~cyl,margins=TRUE)
g+geom_point()+facet_grid(drv~cyl,margins=TRUE)+geom_smooth(method="lm",se=FALSE,size=2,color="black")
g+geom_point()+facet_grid(drv~cyl,margins=TRUE)+geom_smooth(method="lm",se=FALSE,size=2,color="black")+labs(x="Displacement",y="Highway Mileage",title="Swirl Rules!")

#swirl Week 2 Lesson 8: GGPlot2 Extras
str(diamonds)
qplot(price,data=diamonds)
range(diamonds$price)
qplot(price,data=diamonds,binwidth=18497/30)
brk
counts
qplot(price,data=diamonds,binwidth=18497/30,fill=cut)
qplot(price,data=diamonds,geom="density")
qplot(price,data=diamonds,geom="density",color=cut)
#
qplot(carat,price,data=diamonds)
qplot(carat,price,data=diamonds,shape=cut)
qplot(carat,price,data=diamonds,color=cut)
#
qplot(carat,price,data=diamonds, color=cut) + geom_smooth(method="lm")
qplot(carat,price,data=diamonds, color=cut,facets=.~cut) + geom_smooth(method="lm")
#
g<-ggplot(diamonds,aes(depth,price))
summary(g)
g+geom_point(alpha=1/3)
cutpoints<-quantile(diamonds$carat,seq(0,1,length=4),na.rm=TRUE)
cutpoints
diamonds$car2<-cut(diamonds$carat,cutpoints)
g<-ggplot(diamonds,aes(depth,price))
g+geom_point(alpha=1/3)+facet_grid(cut~car2)
diamonds[myd,]
g+geom_point(alpha=1/3)+facet_grid(cut~car2)+geom_smooth(method="lm",size=3,color="pink")
ggplot(diamonds,aes(carat,price))+geom_boxplot()+facet_grid(.~cut)


#swirl Week 3 Lesson 4: Hierarchical Clustering
library(swirl)
install_from_swirl("Exploratory Data Analysis")
swirl()
Mark
3
dist(dataFrame)
hc<-hclust(distxy)
plot(hc)
plot(as.dendrogram(hc))
abline(h=1.5,col="blue")
abline(h=.4,col="red")
5  #cuts
abline(h=.05,col="green")
dist(dFsm)
hc
heatmap(dataMatrix,col=cm.colors(25))
heatmap(mt)
mt
plot(denmt)
distmt

#swirl Week 3 Lesson 4: K Means Clustering
cmat
points(cx,cy,col=c("red","orange","purple"),pch=3,cex=2,lwd=2)
mdist(x,y,cx,cy)
distTmp
apply(distTmp,2,which.min)
points(x,y,pch=19,cex=2,col=cols1[newClust])
tapply(x,newClust,mean)
tapply(y,newClust,mean)
points(newCx,newCy,col=cols1,pch=8,cex=2,lwd=2)
mdist(x,y,newCx,newCy)
distTmp2
2
apply(distTmp2,2,which.min)
points(x,y,pch=19,cex=2,col=cols1[newClust2])
tapply(x,newClust2,mean)
tapply(y,newClust2,mean)
points(finalCx,finalCy,col=cols1,pch=9,cex=2,lwd=2)
kmeans(dataFrame,centers=3)
kmObj$iter
plot(x,y,col=kmObj$cluster,pch=19,cex=2)
points(kmObj$centers,col=c("black","red","green"),pch=3,cex=3,lwd=3)
plot(x,y,col=kmeans(dataFrame,6)$cluster,pch=19,cex=2)
plot(x,y,col=kmeans(dataFrame,6)$cluster,pch=19,cex=2)
plot(x,y,col=kmeans(dataFrame,6)$cluster,pch=19,cex=2)

#swirl Week 3 Lesson 4: Dimension Reduction
head(dataMatrix)
heatmap(dataMatrix)
myedit("addPatt.R")
#
set.seed(678910)
for (i in 1:40) {
  # flip a coin
  coinFlip <- rbinom(1,size = 1,prob = 0.5)
  # if coin is heads add a common pattern to that row
  if (coinFlip) {
    dataMatrix[i,] <- dataMatrix[i,] + rep(c(0,3),each = 5)
  }
}
#
source("addPatt.R",local=TRUE)
heatmap(dataMatrix)
mat
svd(mat)
matu%*%diag%*%t(matv)
svd(scale(mat))
prcomp(scale(mat))
svd1$v[,1]
svd1$d
head(constantMatrix)
svd2$d
svd2$v[,1:2]
svd2$d
dim(faceData)
a1 <- (svd1$u[,1]*svd1$d[1])%*%t(svd1$v[,1])
myImage(a1)
a2 <- svd1$u[,1:2] %*% diag(svd1$d[1:2]) %*% t(svd1$v[,1:2])
myImage(a2)
myImage(svd1$u[,1:5] %*% diag(svd1$d[1:5]) %*% t(svd1$v[,1:5]))
myImage(svd1$u[,1:10] %*% diag(svd1$d[1:10]) %*% t(svd1$v[,1:10]))

#swirl Week 3 Lesson 4: Clustering Example
dim(ssd)
names(ssd[562:563])
table(ssd$subject)
sum(table(ssd$subject))
table(ssd$activity)
sub1 <- subset(ssd,subject==1)
dim(sub1)
names(sub1[1:12])
myedit("showXY.R")
#
par(mfrow=c(1, 2), mar = c(5, 4, 1, 1))
plot(sub1[, 1], col = sub1$activity, ylab = names(sub1)[1])
plot(sub1[, 2], col = sub1$activity, ylab = names(sub1)[2])
legend("bottomright",legend=unique(sub1$activity),col=unique(sub1$activity), pch = 1)
par(mfrow=c(1,1))
#
showMe(1:6)
mdist <- dist(sub1[,1:3])
hclustering <- hclust(mdist)
myplclust(hclustering,lab.col=unclass(sub1$activity))
mdist <- dist(sub1[,10:12])
hclustering <- hclust(mdist)
myplclust(hclustering,lab.col=unclass(sub1$activity))
svd1 <- svd(scale(sub1[,-c(562,563)]))
dim(svd1$u)
maxCon <- which.max(svd1$v[,2])
mdist <- dist(sub1[,c(10:12,maxCon)])
hclustering <- hclust(mdist)
myplclust(hclustering,lab.col = unclass(sub1$activity))
kClust <- kmeans(sub1[,-c(562,563)],centers=6)
table(kClust$cluster,sub1$activity)
kClust <- kmeans(sub1[,-c(562,563)],centers=6,nstart=100)
table(kClust$cluster,sub1$activity)
dim(kClust$centers)
laying <- which(kClust$size==29)
plot(kClust$centers[laying,1:12],pch=19,ylab="Laying Cluster")
names(sub1[1:3])
walkdown <- which(kClust$size==49)
plot(kClust$centers[walkdown,1:12],pch=19,ylab="Walkdown Cluster")
