# Lesson 1 Lattice Plotting System
#   good for hi-dimensional data and hi-density plots

# example:
#   Look at the scatter plot of y and x for every value of f and g (categorical variables)
xyplot( y ~ x | f * g, data)

library(lattice)
library(datasets)
xyplot(Ozone ~ Wind, data = airquality)

library(lattice)
library(datasets)
class(airquality$Month)
airquality <- transform(airquality, Month = factor(Month))
class(airquality$Month)
xyplot(Ozone ~ Wind | Month, data = airquality, layout = c(5,1))

# lattice functions return an object of class trellis
#   trellis is then sent to the printer (auto-printed).
#   trellis can be stored
p <- xyplot(Ozone ~ Wind, data = airquality)  # no printing
print(p)

# Panel functions in lattice

#  1. calling without custom panel:
set.seed(10)
x <- rnorm(100)
f <- rep(0:1, each=50)
y <- x + f - f * x + rnorm(100,sd = 0.5)
f <- factor(f, labels = c("Group 1", "Group 2"))
xyplot(y ~ x | f, labyout = c(2,1))   # Plot with 2 panels

#  2. calling with custom panel function to show median:
xyplot(y ~ x | f, panel = function(x, y, ...){
  panel.xyplot(x, y, ...)
  panel.abline(h = median(y), lty = 2)
})

#  3. calling with custom panel function to show regression line:
xyplot(y ~ x | f, panel = function(x, y, ...){
  panel.xyplot(x, y, ...)
  panel.lmline(x, y, col = 2)
})

# Mouse allergen and Asthma Cohort Study (Baltimore City)
maacs <- readRDS("maacs_env.rds")

############################################################################

#swirl Week 2 Lesson 3: Latice Plotting System
library(swirl)
install_from_swirl("Exploratory Data Analysis")
swirl()

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

xyplot(price~carat|color*cut,data=diamonds,pch=20,xlab=myxlab,ylab=myylab,main=mymain)

