
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