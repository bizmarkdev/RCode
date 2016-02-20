

# lapply returns a list
x <- list(a=1:4,b=rnorm(10), c=rnorm(20,1), d=rnorm(100,5))
lapply(x,mean)

# sapply returns a vector
x <- list(a=1:4,b=rnorm(10), c=rnorm(20,1), d=rnorm(100,5))
sapply(x,mean)

# lapply often has anonymous functions
# this one gets first column from a list of matrices
x <- list(a=matrix(1:4,2,2), b=matrix(1:6,3,2))
lapply(x, function(elt) elt[,1])

# apply
x <- matrix(rnorm(200),20,10)  # 20 rows, 10 columns of random vars
apply(x,2,mean)  # collapses the rows and gives mean for each column
apply(x,1,sum)   # collapses the columns and gives sum for each row

apply(x,1,quantile,probs=c(0.25,0.75))

# rowSums, rowMeans, colSums, colMeans are optimized equivalent of the apply

a <- array(rnorm(2*2*10), c(2,2,10))
apply(a, c(1,2), mean)

# mapply applies 
list(rep(1,4), rep(2,3), rep(3,2), rep(4,1))
mapply(rep, 1:4, 4:1)

# tapply apply a function over subsets of a vector.
x <- c(rnorm(10), runif(10), rnorm(10,1))   # a vector with three groups (10 each)
f <- gl(3,10)   # three levels of factor variables (10 each)
tapply(x,f,mean, simplify=FALSE)   # return the mean for each of the three segments
tapply(x,f,range, simplify=FALSE)   # return the range for each of the three segments
