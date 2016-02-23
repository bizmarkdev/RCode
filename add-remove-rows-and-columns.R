# Add/Remove rows and columns

set.seed(13435)
x <- data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
x <-x[sample(1:5),]
x$var2[c(1,3)] = NA
x

x$var4 <- rnorm(5)
x

# cbind
y <- cbind(x,rnorm(5))
y

# rbind
