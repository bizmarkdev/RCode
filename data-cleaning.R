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

## Swirll: Getting and Cleaning Data course
ls()
rm(list=ls())
install.packages("swirl")
packageVersion("swirl")  #need 2.2.21 or later
install_from_swirl("Getting and Cleaning Data")
library("swirl")
swirl()
# Lesson 3: Tidying Data with tidyr
library(tidyr)
# read Hadley's paper: http://vita.had.co.nz/papers/tidy-data.pdf

# The first problem is when you have column headers that are values, not variable names.
#> students
#grade male female
#1     A    1      5
#2     B    5      0
#3     C    5      2
#4     D    5      5
#5     E    7      4
?gather
gather(students,sex,count,-grade)
#grade    sex count
#1      A   male     1
#2      B   male     5
#3      C   male     5
#4      D   male     5
#5      E   male     7
#6      A female     5
#7      B female     0
#8      C female     2
#9      D female     5
#10     E female     4
#Each row of the data now represents exactly one observation, 
#characterized by a unique combination of the grade and sex variables. 
#Each of our variables (grade, sex, and count) occupies exactly one column. That's tidy data!

# The second messy data case we'll look at is when multiple variables are stored in one column.
# grade male_1 female_1 male_2 female_2
#1     A      3        4      3        4
#2     B      6        4      3        5
#3     C      7        4      3        8
#4     D      4        0      8        1
#5     E      1        1      2        7
#
res <- gather(students2,sex_class,count,-grade)
res
#   grade sex_class count
#1      A    male_1     3
#2      B    male_1     6
#3      C    male_1     7
#4      D    male_1     4
#5      E    male_1     1
#6      A  female_1     4
#7      B  female_1     4
#8      C  female_1     4
#9      D  female_1     0
#10     E  female_1     1
#11     A    male_2     3
#12     B    male_2     3
#13     C    male_2     3
#14     D    male_2     8
#15     E    male_2     2
#16     A  female_2     4
#17     B  female_2     5
#18     C  female_2     8
#19     D  female_2     1
#20     E  female_2     7
?separate
separate(data = res,col=sex_class,into=c("sex","class"))
#  grade    sex class count
#1      A   male     1     3
#2      B   male     1     6
#3      C   male     1     7
#4      D   male     1     4
#5      E   male     1     1
#6      A female     1     4
#7      B female     1     4
#8      C female     1     4
#9      D female     1     0
# Conveniently, separate() was able to figure out on its own how to separate the sex_class column. 
# Unless you request otherwise with the 'sep' argument, it splits on non-alphanumeric values.
#
# you can use the %>% operator to chain multiple function calls together.
students2 %>%
  gather(sex_class, count, -grade) %>%
  separate(col=sex_class , into=c("sex", "class")) %>%
  print

# A third symptom of messy data is when variables are stored in both rows and columns.
#    name    test class1 class2 class3 class4 class5
#1  Sally midterm      A   <NA>      B   <NA>   <NA>
#2  Sally   final      C   <NA>      C   <NA>   <NA>
#3   Jeff midterm   <NA>      D   <NA>      A   <NA>
#4   Jeff   final   <NA>      E   <NA>      C   <NA>
#5  Roger midterm   <NA>      C   <NA>   <NA>      B
#6  Roger   final   <NA>      A   <NA>   <NA>      A
#7  Karen midterm   <NA>   <NA>      C      A   <NA>
#8  Karen   final   <NA>   <NA>      C      A   <NA>
#9  Brian midterm      B   <NA>   <NA>   <NA>      A
#10 Brian   final      B   <NA>   <NA>   <NA>      C
#
students3 %>%
  gather(test, count, -name, na.rm = TRUE) %>%
  print
# The first variable, name, is already a column and should remain as it is. 
# The headers of the last five columns, class1 through class5, are all different values of what should be a class variable. 
# The values in the test column, midterm and final, should each be its own variable containing the respective grades for each student.

students3 %>%
  gather(class, grade, class1:class5, na.rm = TRUE) %>%
  spread( test, grade) %>%
  print

#
students3 %>%
  gather(class, grade, class1:class5, na.rm = TRUE) %>%
  spread(test, grade) %>%
  mutate(class = extract_numeric(class)) %>%
  print


# The fourth messy data problem we'll look at occurs when multiple observational units are stored in the same table.
#    id  name sex class midterm final
#1  168 Brian   F     1       B     B
#2  168 Brian   F     5       A     C
#3  588 Sally   M     1       A     C
#4  588 Sally   M     3       B     C
#5  710  Jeff   M     2       D     E
#6  710  Jeff   M     4       A     C
#7  731 Roger   F     2       C     A
#8  731 Roger   F     5       B     A
#9  908 Karen   M     3       C     C
#10 908 Karen   M     4       A     A


student_info <- students4 %>%
  select(id, name, sex) %>%
  unique %>%
  print

# The fifth and final messy data scenario that we'll address is when a single observational unit is stored in multiple tables.
passed <- passed %>% mutate(status = 'passed') 
failed <- failed %>% mutate(status = 'failed')
bind_rows(passed,failed)


# Accomplish the following three goals:
#
# 1. select() all columns that do NOT contain the word "total",
# since if we have the male and female data, we can always
# recreate the total count in a separate column, if we want it.
# Hint: Use the contains() function, which you'll
# find detailed in 'Special functions' section of ?select.
#
# 2. gather() all columns EXCEPT score_range, using
# key = part_sex and value = count.
#
# 3. separate() part_sex into two separate variables (columns),
# called "part" and "sex", respectively. You may need to check
# the 'Examples' section of ?separate to remember how the 'into'
# argument should be phrased.
#
sat %>%
  select(-contains("total")) %>%
  gather(part_sex, count, -score_range) %>%
  separate(part_sex, c("part", "sex")) %>%
  print
