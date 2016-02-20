# Is it categorical data? If so, do not use linear regression!

# swirl 12: Looking at data
ls()
class(plants)
dim(plants)
nrow(plants)
ncol(plants)
object.size(plants)
names(plants)
head(plants)
head(plants,10)
tail(plants,15)
summary(plants)
table(plants$Active_Growth_Period)
str(plants)

# exploring a dataset
head(flags)
dim(flags)
class(flags)
cls_list <- lapply(flags,class)  # a data.frame is a list of vectors
cls_list  # displays as a list (allows multiple classes of data)
as.character(cls_list)   # displays as a vector (requires all to be of the same class)
?sapply
sapply(flags,class)
cls_vect <- sapply(flags,class)

sum(flags$orange)
flag_colors <- flags[,11:17]  # extract all rows, columns 11-17 (colums for the colors)
head(flag_colors)
lapply(flag_colors,sum)       # sum the columns as a list
sapply(flag_colors,sum)       # sum the columns as a vector
sapply(flag_colors,mean)
flag_shapes <- flags[, 19:23]
lapply(flag_shapes,range)
shape_mat <- sapply(flag_shapes,range)  # note that it returns a matrix (not a vector)
shape_mat                     # displays the min and max of each shape amongs the flags

unique(c(3,4,5,5,5,5,6,6))
unique_vals <- lapply(flags,unique)
sapply(unique_vals, length)
lapply(unique_vals, function(elem) elem[2])

vapply(flags,unique,numeric(1))  # throws an error
vapply(flags, class, character(1))

table(flags$landmass)   # table of landmass for each part of the world (1-6)
table(flags$animate)    # table of flags with animate objects
tapply(flags$animate, flags$landmass, mean) # proportion of countries with animate objects, by each part of the world
