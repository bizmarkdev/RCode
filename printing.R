# Printing

print_line <- c('##', ' ', ' id', 'nobs')
cat(sprintf("%6s", print_line), fill=TRUE)

print_line <- c('##', toString(i), toString(file_number), toString(nrow(temp_dataset)) )
cat(sprintf("%6s", print_line), fill=TRUE)