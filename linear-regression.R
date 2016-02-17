## Notes on Linear regression

# http://www.r-tutor.com/elementary-statistics/numerical-measures/correlation-coefficient


## Why using a data frame is important
#What is the Pearson product-moment correlation coefficient for the two variables? p.109
student<-c(1:7)
sat<-c(595,520,715,405,680,490,565)
gpa<-c(3.4,3.2,3.9,2.3,3.9,2.5,3.5)
cor(sat,gpa)
plot(sat,gpa)

z<-cbind(student,sat,gpa)
cor(z$sat,z$gpa)  #returns: Error in z$sat : $ operator is invalid for atomic vectors because it's a matrix
class(z)
z=as.data.frame(z)  #transforms matrix to a dataframe
class(z)
cor(z$sat,z$gpa)

## Four things that that mess-up linear relationships:
# Lack of linearity. could be curvilinear. Performance anxiety improves performance (good stress)
# outliers
# homogeniety of the group (sampling from a similar group)
# sample size


#Using plot and abline to find linear relationships
library(SDSFoundations)
bull <- BullRiders
#try out various plots to fish for a relationship
plot(bull$YearsPro, bull$BuckOuts14,xlab="Years Pro",ylab="Buckouts",main="Plot of Years Pro")
abline(lm(bull$BuckOuts14~bull$YearsPro))  #weak
plot(bull$Events14~bull$BuckOuts14,xlab="No of Events",ylab="Buckouts",main="Events vs Buckouts")
abline(lm(bull$BuckOuts14~bull$Events14))  #strong relationship