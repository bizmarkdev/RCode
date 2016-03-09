# Data types

# Factors
#  Factors in R are stored as a vector of integer values 
#  with a corresponding set of character values to use when the factor is displayed.
#  http://www.r-bloggers.com/data-types-part-3-factors/

# Using subsets to display different colors (see plot-base.R)
#   quantitative variables
x <- rnorm(100)
y <- x + rnorm(100)
#   grouping (factor) variables
?gl    # see data-types.R for info on factor variables
g <- gl(2,50,labels = c("Male","Female"))

x                 #100 quantitative values (no gender)
str(g)
g                 #100 values, 2 levels, 1-50 are Male, 51-100 are Female
x[g=="Female"]    #returns 51-100 values for x

#   Display subsets with different colors
par(mfrow = c(1,1))
plot(x,y,type = "n")
?points
points(x[g=="Male"], y[g=="Male"], col="green")
points(x[g=="Female"], y[g=="Female"], col="blue")