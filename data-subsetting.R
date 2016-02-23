# Subsetting and Sorting. May need to go into cleaning-data.R

set.seed(13435)
x <- data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
x <-x[sample(1:5),]
x$var2[c(1,3)] = NA
x

# quick subsetting
x[,1]
x[,"var1"]
x[1:2,"var2"]

# subsetting by logicals
x[(x$var1 <= 3 & x$var3 > 11),]
x[(x$var1 <= 3 | x$var3 > 15),]


