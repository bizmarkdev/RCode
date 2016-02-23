# Sorting

set.seed(13435)
x <- data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
x <-x[sample(1:5),]
x$var2[c(1,3)] = NA
x

# sorting a vector
sort(x$var1)
sort(x$var1,decreasing=TRUE)
sort(x$var2)
sort(x$var2,na.last=TRUE)

# ordering a dataframe
x
x[order(x$var1),]
x[order(x$var1,x$var3),]

# ordering with plyr
# http://www.r-bloggers.com/a-fast-intro-to-plyr-for-r/
# dplyr supplies five 'verbs' that cover most fundamental data manipulation tasks: 
#   select(), filter(), arrange(), mutate(), and summarize()
install.packages("plyr")
library(plyr)
arrange(x,var1)
arrange(x,desc(var1))
