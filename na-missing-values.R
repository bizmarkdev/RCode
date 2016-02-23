# NA. Missing values

set.seed(13435)
x <- data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
x <-x[sample(1:5),]
x$var2[c(1,3)] = NA
x

# are there any missing values?
sum(is.na(x$var2))
any(is.na(x$var2))
colSums(is.na(x))

# dealing with missing values
# http://stackoverflow.com/questions/6918657/whats-the-use-of-which
x[(x$var2 > 8),]       # note the problem!
x[which(x$var2 > 8),]  #

