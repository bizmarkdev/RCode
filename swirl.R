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
