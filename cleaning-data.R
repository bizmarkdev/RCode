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