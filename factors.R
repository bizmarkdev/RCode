Factors

# Factors: categorical data
x<-factor(c("yes","yes","no","yes","no"))
x
# Factors are really integers with ann additional attribute of Levels
class(x)
unclass(x)
# because no is lower in alphabetical order, it gets 1
