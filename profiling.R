
# Profiler
system.time(readLines("http://www.jhsph.edu"))  # Elapsed time > user time
hilbert <- function(n){
  i <- 1:n
  1 / outer(i-1, i, "+")
}
x <- hilbert(1000)
system.time(svd(x))   # svd function makes use of multiple cores on a mac. Elapsed time < user time.

system.time({
  n <- 1000
  r <- numeric(n)
  for (i in 1:n){
    x <- rnorm(n)
    r[1] <- mean(x)
  }
})

# Rprof
# http://www.stat.berkeley.edu/~nolan/stat133/Fall05/lectures/profilingEx.html
funAgg = function(x) {
  # initialize res 
  res = NULL
  n = nrow(x)
  
  for (i in 1:n) {
    if (!any(is.na(x[i,]))) res = rbind(res, x[i,])
  }
  res
}
funLoop = function(x) {
  # Initialize res with x
  res = x
  n = nrow(x)
  k = 1
  
  for (i in 1:n) {
    if (!any(is.na(x[i,]))) {
      res[k, ] = x[i,]
      k = k + 1
    }
  }
  res[1:(k-1), ]
}
#Make up large test case
xx = matrix(rnorm(200000),10000,20)
xx[xx>2] = NA
x = as.data.frame(xx)
# Call the R code profiler and give it an output file to hold results
Rprof("exampleAgg.out")
# Call the function to be profiled
y = funAgg(xx)
Rprof(NULL)
summaryRprof("exampleAgg.out")
#
Rprof("exampleLoop.out")
y = funLoop(xx)
Rprof(NULL)
# 
summaryRprof("exampleLoop.out")


