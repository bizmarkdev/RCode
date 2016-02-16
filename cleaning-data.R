# Cleaning data

# Clean data and compute mean
if (pollutant == 'sulfate') {
  pollution_data <- pollution_data[complete.cases(pollution_data[,2]),]
  pollution_mean <- mean(pollution_data$sulfate)
} else if (pollutant == 'nitrate') {
  pollution_data <- pollution_data[complete.cases(pollution_data[,3]),]
  pollution_mean <- mean(pollution_data$nitrate)
} else {
  pollution_data <- pollution_data[complete.cases(pollution_data),]
  pollution_mean <- "select either sulfate or nitrate"
}

# remove NA values
x<-c(1,2,NA,4,NA,5)
x
bad<-is.na(x)
bad
x[!bad]

x<-c(1,2,NA,4,NA,5)
y<-c("a","b",NA,"d",NA,"f")
good<-complete.cases(x,y)
x[good]
y[good]

