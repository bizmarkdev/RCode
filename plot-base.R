# Base Plotting System

# initialize the plot
plot(x,y)
hist(x)

# reset global parameters
dev.off()
plot.new()

# Hierarchical clustering - example
#   hclust is deterministic
set.seed(1234) 
par(mar = c(0, 0, 0, 0))
x <- rnorm(12, mean = rep(1:3, each = 4), sd = 0.2)
y <- rnorm(12, mean = rep(c(1, 2, 1), each = 4), sd = 0.2)
plot(x, y, col = "blue", pch = 19, cex = 2)
text(x + 0.05, y + 0.05, labels = as.character(1:12))


library(datasets)
hist(airquality$Ozone)    ## Draw a new plot

libary(datasets)
with(airquality,plot(Wind,Ozone))

library(datasets)
airquality <- transform(airquality, Month = factor(Month))
boxplot(Ozone ~ Month, airquality, xlab = "Month", ylab = "Ozone (ppb)")

# display two boxplots of pm25, one for each region:
boxplot(pm25 ~ region, data = pollution, col = "red")

# Useful Base Graphic Parameters
# pch: plotting symbol
# lty: line type
# lwd: line width
# col: plotting color
# xlab: x-axis label
# ylab: y-axis label

?par
# set global graphics parameters that affect plots in an R session.
# overridden when used as arguments in specific plotting functions

# las: orientation of the axis labels
# bg: background color
# mar: margin size
# oma: outer margin size
# mfrow: number of plots per row, column (plots are filled row-wise)
# mfcol: number of plots per row, column (plots are filled column-wise)

par(mfrow = c(1,2), mar= c(5,4,3,2), lwd=2, lty=2)
par("lty")        # line type = [1] "dashed"
par("lwd")        # line width
par("mar")        # bottom,left,top,right
par("mfrow")      # [1] 1 2 means one row, two columns


# Base plotting functions
# plot
# lines: add lines to a plot
# points: add points to a plot
# text: add text labels to a plot
# title: add annotations to x,y axis
# mtext: add arbirary text to the margins
# axis: adding axis ticks/labels

library(datasets)
with(airquality,plot(Wind,Ozone))
title(main="Ozone and Wind in New York City")   # Add a title
title(main="Ozone and Wind in New York City.")  # Change a title (messes things up)

with(airquality,plot(Wind,Ozone, main="Ozone and Wind in New York City."))
with(subset(airquality,Month==5),points(Wind,Ozone,col="blue"))

with(airquality,plot(Wind,Ozone,main="Ozone and Wind in New York City",type="n"))
with(subset(airquality,Month==5), points(Wind,Ozone,col="blue"))
with(subset(airquality,Month!=5), points(Wind,Ozone,col="red"))
legend("topright",pch=1,col=c("blue","red"),legend = c("May","Other Months"))

with(airquality,plot(Wind,Ozone,main="Ozone and Wind in New York City",pch=20))
model <-lm(Ozone ~ Wind, airquality)
abline(model,lwd=2)

par(mfrow = c(1,2))
with(airquality,{
  plot(Wind,Ozone,main="Ozone and Wind")
  plot(Solar.R,Ozone,main="Ozone and Solar Radiation")
})

par(mfrow = c(1, 3), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0)) 
with(airquality, {
  plot(Wind, Ozone, main = "Ozone and Wind")
  plot(Solar.R, Ozone, main = "Ozone and Solar Radiation") 
  plot(Temp, Ozone, main = "Ozone and Temperature") 
  mtext("Ozone and Weather in New York City",outer = TRUE)
})

# Base Plotting Demonstration

# margins
x <- rnorm(100)
hist(x)
# defaults are: x,Frequency for x,y labels
y<-rnorm(100)
plot(x,y)
par("mar")    # margins are = [1] 5.1 4.1 4.1 2.1 (bottom,left,top,right)
par(mar=c(4,4,2,2))
plot(x,y)

# points
example(points)
plot(x,y,pch=20)
plot(x,y,pch=19)
plot(x,y,pch=2)
plot(x,y,pch=3)
plot(x,y,pch=4)

x <- rnorm(100)
y<-rnorm(100)
plot(x,y)
title("Scatterplot")
text(-2,-2,"Label")
legend("topleft",legend="Data")
legend("topleft",legend="Data",pch=20)
fit <- lm(y ~x)
abline(fit, lwd=3, col = "blue")
plot(x,y,xlab="Weight", ylab = "Height", main="Scatterplot",pch=20)
legend("topright",legend="Data",pch=20)
fit <- lm(y~x)
abline(fit,lwd=3,col="red")

z <- rpois(100,2)
par(mfrow=c(2,1))   # two rows, one column
plot(x,y,pch=20)
plot(x,z,pch=19)
par("mar")
par(mar = c(2,2,1,1))
plot(x,y,pch=20)
plot(x,z,pch=20)

# Using subsets to display different colors
#   quantitative variables
x <- rnorm(100)
y <- x + rnorm(100)
#   grouping (factor) variables
?gl    # see data-types.R for info on factor variables
g <- gl(2,50,labels = c("Male","Female"))

#   subsetting based on grouping variables
x                 #100 quantitative values (no gender)
str(g)
g                 #100 values, 2 levels, 1-50 are Male, 51-100 are Female
x[g=="Female"]    #returns 51-100 values for x

#   Display subsets with different colors
par(mfrow = c(1,1))
plot(x,y,type = "n")
?points
points(x[g=="Male"], y[g=="Male"], col="green")
points(x[g=="Female"], y[g=="Female"], col="blue", pch=19)


# Lesson 4: What is a Graphics Device?
dev.cur()                               # current plotting device
?Devices
library(datasets)
pdf(file="myplot.pdf")                  # Open PDF device
with(faithful,plot(eruptions,waiting))
title(main="Old Faithful Geyser data")
dev.off()                               # Close PDF device

# vector devices (pdf, svg, win.metafile, postscript)
# bitmap devices (png, jpeg, tiff, bmp)

# may open multiple graphical devices, but plotting can occur on one graphics at a time
# dev.set(<integer>) to set the current device.

# Copy a plot (dev.copy, dev.copy2pdf)
library(datasets)
with(faithful,plot(eruptions,waiting))
title(main="Old Faithful Geyser data")
dev.copy(png, file="geyserplot.png")
dev.off()         

