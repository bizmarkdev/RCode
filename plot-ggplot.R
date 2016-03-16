
# ggplot2 package

# Factors indicte subsets of data; they should be labeled.
library(ggplot2)
str(mpg)        #mpg comes with ggplot2
class(mpg$manufacturer)  #not a factor!
class(mpg$drv)  #not a factor!

qplot(displ,hwy,data=mpg)
qplot(displ,hwy,data=mpg,color=drv)
# adding a geom:
#   smooth gives blue line and grey is 95% confidence interval:
qplot(displ,hwy,data=mpg,geom=c("point","smooth"))

# histogram by specifying only one variable
#   subset by drv
qplot(hwy,data=mpg,fill=drv)

# facets (like panels)
#   . indicates only one row
#   drv indicates columns by drv
qplot(displ,hwy,data=mpg,facets=.~drv)
qplot(hwy, data = mpg, facets = drv ~ ., binwidth = 2)

# Mouse allergen and Asthma Cohort Study (Baltimore City)
maacs <- readRDS("maacs_env.rds")
qplot(log(eno), data = maacs)
qplot(log(eno), data = maacs, fill = mopos)
qplot(log(eno), data = maacs, geom = "density")
qplot(log(eno), data = maacs, geom = "density", color = mopos)

load("maacs.Rda")

##############################################################################################
# Ordering barplots

# http://stackoverflow.com/questions/5208679/order-bars-in-ggplot2-bar-graph
#The key with ordering is to set the levels of the factor in the order you want;

# http://stackoverflow.com/questions/25664007/reorder-bars-in-geom-bar-ggplot2
ggplot(corr.m, aes(x=reorder(miRNA,-value), y=value, fill=variable)) + 
  geom_bar(stat="identity")

# dplyer arrange will order the rows, but does not change the factor. Factor is what orders the plot.

# HOWEVER! The order can be set in the call to ggplot (see aes(x=reorder ...))

sd.melt.econ <- melt(sd, id.vars="EVCAT", measure.vars=c("PROPDMG", "CROPDMG"), variable.name = "IMPACT")
ggplot(sd.melt.econ,aes(x=reorder(factor(EVCAT),-value),y=value/1000,fill=factor(IMPACT)), color=factor(IMPACT)) + 
  labs(title="Economic Impacts of Atmospheric Events (Thousands)")+labs(x="Atmospheric Event",y="Economic Impact (Thousands)") +
  theme(axis.text.x=element_text(size=04)) +
  stat_summary(fun.y=mean,position="stack",geom="bar")
##############################################################################################

# CHEATSHEET FOR BARPLOTS
#   open this to see plots: http://www.r-bloggers.com/ggplot2-cheatsheet-for-barplots/
#   other cheatsheets by same author: http://www.r-bloggers.com/author/slawa-rokicki/

library(ggplot2)
library(gridExtra)
mtc <- mtcars

########################## 

# BASIC BARPLOT:

ggplot(mtc, aes(x = factor(gear))) + 
  geom_bar(stat = "count")

##########################

# SUMMARIZING DATA FOR BARPLOT

#   method 1: summarize data beforehand:
#     summarize using aggregate:
ag.mtc<-aggregate(mtc$wt, by=list(mtc$gear), FUN=mean)
ag.mtc
#     or summarize using using tapply
summary.mtc <- data.frame(
  gear=levels(as.factor(mtc$gear)),
  meanwt=tapply(mtc$wt, mtc$gear, mean))
summary.mtc
#     or summarize using dplyr and summarize

#  plot using summarized dataframe:
ggplot(summary.mtc, aes(x = factor(gear), y = meanwt)) + 
  geom_bar(stat = "identity")

#   method 2: use stat_summary
ggplot(mtc,aes(x=factor(gear), y=wt)) + 
  stat_summary(fun.y=mean, geom="bar")

#########################

# HORIZONTAL BARS, COLORS, WIDTH OF BARS

#1. horizontal bars
ggplot(mtc,aes(x=factor(gear),y=wt)) + 
  stat_summary(fun.y=mean,geom="bar") + 
  coord_flip()
#2. change colors of bars
ggplot(mtc,aes(x=factor(gear),y=wt,fill=factor(gear))) +  
  stat_summary(fun.y=mean,geom="bar") + 
  scale_fill_manual(values=c("purple", "blue", "darkgreen"))
#3. change width of bars
ggplot(mtc,aes(x=factor(gear),y=wt)) + 
  stat_summary(fun.y=mean,geom="bar", aes(width=0.5))
#4. change width of bars (if summarizing manually)
ggplot(summary.mtc, aes(x = factor(gear), y = meanwt)) + 
  geom_bar(stat = "identity", width=0.2)

# You can also use scale_fill_brewer() to fill the bars with a scale of one color (default is blue). 
# This R cookbook site is particularly useful for understanding how to get the exact colors you want:
#   http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/

#########################

# SPLIT AND COLOR BY ANOTHER VARIABLE

# We can do this in three ways: bars next to each other, bars stacked, 
# or using 'faceting' which is making multiple graphs at once. 
# We would like to know the mean weight by both gear and engine type (vs). 
# Stacking is a particularly bad idea in this example, but I'll show it for completeness.

#1. next to each other
ggplot(mtc,aes(x=factor(gear),y=wt,fill=factor(vs)), color=factor(vs)) +  
  stat_summary(fun.y=mean,position=position_dodge(),geom="bar")
#2. stacked
ggplot(mtc,aes(x=factor(gear),y=wt,fill=factor(vs)), color=factor(vs)) + 
  stat_summary(fun.y=mean,position="stack",geom="bar")
#3. with facets
ggplot(mtc,aes(x=factor(gear),y=wt,fill=factor(vs)), color=factor(vs)) + 
  stat_summary(fun.y=mean, geom="bar") +
  facet_wrap(~vs)

# change order of stacking by re-ordering levels of the fill variable
mtc$vs2<-factor(mtc$vs, levels = c(1,0))
ggplot(mtc,aes(x=factor(gear),y=wt,fill=factor(vs2)), color=factor(vs2)) + 
  stat_summary(fun.y=mean,position="stack",geom="bar")

#########################

# ADD TEXT TO THE BARS, LABEL AXES, AND LABEL LEGEND

ag.mtc<-aggregate(mtc$wt, by=list(mtc$gear,mtc$vs), FUN=mean)
colnames(ag.mtc)<-c("gear","vs","meanwt")
ag.mtc
#
#1. basic
ggplot(ag.mtc, aes(x = factor(gear), y = meanwt, fill=factor(vs),color=factor(vs))) + 
  geom_bar(stat = "identity", position=position_dodge()) + 
  geom_text(aes(y=meanwt, ymax=meanwt, label=meanwt),position= position_dodge(width=0.9), vjust=-.5)

#2. fixing the yaxis problem, changing the color of text, legend labels, and rounding to 2 decimals
ggplot(ag.mtc, aes(x = factor(gear), y = meanwt, fill=factor(vs))) + 
  geom_bar(stat = "identity", position=position_dodge()) + 
  geom_text(aes(y=meanwt, ymax=meanwt, label=round(meanwt,2)), position= position_dodge(width=0.9), vjust=-.5, color="black") + 
  scale_y_continuous("Mean Weight",limits=c(0,4.5),breaks=seq(0, 4.5, .5)) + 
  scale_x_discrete("Number of Gears") + scale_fill_discrete(name ="Engine", labels=c("V-engine", "Straight engine"))

#########################

# ADD ERROR BARS OR BEST FIT LINE

#   method 1: summarize first:
summary.mtc2 <- data.frame(gear=levels(as.factor(mtc$gear)), meanwt=tapply(mtc$wt, mtc$gear, mean), sd=tapply(mtc$wt, mtc$gear, sd))
summary.mtc2
ggplot(summary.mtc2, aes(x = factor(gear), y = meanwt)) + 
  geom_bar(stat = "identity", position="dodge", fill="lightblue") +
  geom_errorbar(aes(ymin=meanwt-sd, ymax=meanwt+sd), width=.3, color="darkblue")

# And if you were really cool and wanted to add a linear fit to the barplot, you can do it in two ways. 
# You can evaluate the linear model yourself, and then use geom_abline() with an intercept and slope indicated. 
# Or you can take advantage of the stat_summary() layer to summarize the data 
#   and the geom_smooth() layer to add a linear model instantly.
#summarize data
summary.mtc3 <- data.frame( hp=levels(as.factor(mtc$hp)), meanmpg=tapply(mtc$mpg, mtc$hp, mean))

#run a model
l<-summary(lm(meanmpg~as.numeric(hp), data=summary.mtc3))

#manually entering the intercept and slope
f1<-ggplot(summary.mtc3, aes(x = factor(hp), y = meanmpg)) + 
  geom_bar(stat = "identity",  fill="darkblue")+
  geom_abline(aes(intercept=l$coef[1,1], slope=l$coef[2,1]), color="red", size=1.5)

#using stat_smooth to fit the line for you
f2<-ggplot(summary.mtc3, aes(x = factor(hp), y = meanmpg)) + 
  geom_bar(stat = "identity",  fill="darkblue")+
  stat_smooth(aes(group=1),method="lm", se=FALSE, color="orange", size=1.5)

grid.arrange(f1, f2, nrow=1)

##############################################################################################################

#swirl Week 2 Lesson 8: GGPlot2 Part1
str(mpg)
qplot(displ,hwy,data=mpg)
qplot(displ,hwy,data=mpg,color=drv)
qplot(displ,hwy,data=mpg,color=drv,geom=c("point","smooth"))
qplot(y=hwy,data=mpg,color=drv)
myhigh
qplot(drv,hwy,data=mpg,geom="boxplot")
qplot(drv,hwy,data=mpg,geom="boxplot",color=manufacturer)
qplot(hwy,data=mpg,fill=drv)
qplot(displ,hwy,data=mpg,facets = .~drv)
qplot(hwy,data=mpg,facets=drv~.,binwidth=2)
2

#swirl Week 2 Lesson 8: GGPlot2 Part2
qplot(displ,hwy,data=mpg,geom=c("point","smooth"),facets=.~drv)
g<-ggplot(mpg,aes(displ,hwy))
summary(g)
g+geom_point()
g+geom_point()+geom_smooth()
g+geom_point()+geom_smooth(method="lm")
g+geom_point()+geom_smooth(method="lm")+facet_grid(.~drv)
g+geom_point()+geom_smooth(method="lm")+facet_grid(.~drv)+ggtitle("Swirl Rules!")
g+geom_point(color="pink",size=4,alpha=1/2)
g+geom_point(aes(color=drv),size=4,alpha=1/2)
g+geom_point(aes(color=drv))+labs(title="Swirl Rules!")+labs(x="Displacement",y="Hwy Mileage")
g+geom_point(aes(color=drv),size=2,alpha=1/2)+geom_smooth(size=4,linetype=3,method="lm",se=FALSE)
g+geom_point(aes(color=drv))+theme_bw(base_family="Times")
plot(myx,myy,type="l",ylim=c(-3,3))
g<-ggplot(testdat,aes(x=myx,y=myy))
g+geom_line()
g+geom_line()+ylim(-3,3)
g+geom_line()+coord_cartesian(ylim=c(-3,3))
#
g<-ggplot(mpg,aes(x=displ,y=hwy,color=factor(year)))
g+geom_point()
g+geom_point()+facet_grid(drv~cyl,margins=TRUE)
g+geom_point()+facet_grid(drv~cyl,margins=TRUE)+geom_smooth(method="lm",se=FALSE,size=2,color="black")
g+geom_point()+facet_grid(drv~cyl,margins=TRUE)+geom_smooth(method="lm",se=FALSE,size=2,color="black")+labs(x="Displacement",y="Highway Mileage",title="Swirl Rules!")

#swirl Week 2 Lesson 8: GGPlot2 Extras
str(diamonds)
qplot(price,data=diamonds)
range(diamonds$price)
qplot(price,data=diamonds,binwidth=18497/30)
brk
counts
qplot(price,data=diamonds,binwidth=18497/30,fill=cut)
qplot(price,data=diamonds,geom="density")
qplot(price,data=diamonds,geom="density",color=cut)
#
qplot(carat,price,data=diamonds)
qplot(carat,price,data=diamonds,shape=cut)
qplot(carat,price,data=diamonds,color=cut)
#
qplot(carat,price,data=diamonds, color=cut) + geom_smooth(method="lm")
qplot(carat,price,data=diamonds, color=cut,facets=.~cut) + geom_smooth(method="lm")
#
g<-ggplot(diamonds,aes(depth,price))
summary(g)
g+geom_point(alpha=1/3)
cutpoints<-quantile(diamonds$carat,seq(0,1,length=4),na.rm=TRUE)
cutpoints
diamonds$car2<-cut(diamonds$carat,cutpoints)
g<-ggplot(diamonds,aes(depth,price))
g+geom_point(alpha=1/3)+facet_grid(cut~car2)
diamonds[myd,]
g+geom_point(alpha=1/3)+facet_grid(cut~car2)+geom_smooth(method="lm",size=3,color="pink")
ggplot(diamonds,aes(carat,price))+geom_boxplot()+facet_grid(.~cut)

##############################################################################################