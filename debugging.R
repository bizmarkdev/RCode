## Debugging

#DEBUGGING
# this function suppresses the stop on NA and handles it.
printmessage <- function(x){
  if(is.na(x)) print("x is a missing value!")
  else if (x>0) print("x is greater than zero")
  else print("x is less than or equal to zero")
  invisible(x)  #return from a function with the printing not sent to console
}
printmessage(1)

# stop
stop()  # stops execution of the current expression and executes an error action

# traceback
rm(x)
mean(x)
traceback()

lm(y ~x)
traceback()

# debug
debug(lm)
lm(y~x)   #browser now opens

# recover
options(error=recover)
read.csv("nosuchfile")
