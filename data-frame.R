# Notes on matrices and dataframes

# reading character data problem:
# if character data, it is loaded as a factor instead of as character.
options(stringsAsFactors = FALSE)
state_rank_df = data.frame(hospital = character(),state = character(),stringsAsFactors = FALSE)

## Build a matrix and then convert it to a data frame

#What is the Pearson product-moment correlation coefficient for the two variables? p.109
student<-c(1:7)
sat<-c(595,520,715,405,680,490,565)
gpa<-c(3.4,3.2,3.9,2.3,3.9,2.5,3.5)
cor(sat,gpa)

z<-cbind(student,sat,gpa)
cor(z$sat,z$gpa)  #returns: Error in z$sat : $ operator is invalid for atomic vectors because it's a matrix
class(z)
z=as.data.frame(z)  #transforms matrix to a dataframe
class(z)
cor(z$sat,z$gpa)


#from Data Frames. Important! vector & matrix vs list & dataframe
x<-data.frame(foo=1:4,bar=c(T,T,F,F))
x
ncol(x)  #number of columns in the dataframe


#Loop through a column
# get vector of states
states <- unique(measures$State)
states <- sort(states)
for(state in states){
  #get a subset of observations for each state.
  state_name = state
  state_measures <- measures[measures$State == state_name,]
  # Rank state subset by 30-day mortality, hospital name
  state_measures <- state_measures[with(state_measures, order(as.numeric(state_measures[,3]), state_measures[,1])),] 
}



