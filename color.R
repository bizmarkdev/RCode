
# Working with Color
dev.off()
# colorRamp returns a function
#   that will interpret a color between 0 and 1

pal <- colorRamp(c("red","blue"))
pal(0)   # return red (0)
pal(1)   # return blud (1)
pal(.5)
# return a palette of 10 colors from red to blue
x <- pal(seq(0,1,len=10))
x

# colorRampPalette also returns a function
#  returns hex value between lo and hi parameters
pal <- colorRampPalette(c("red","yellow"))
pal(2)
pal(10)

# RColorBrewer
library(RColorBrewer)
dev.off()
# see all palettes available from the package
#   Sequential: first set are for ordered, numerical data
#   Qualitative: second set are not ordered. Used for categorical data.
#   Diverging: diverge from center
display.brewer.all()   

# get a set of three colors from the BuGn palette in the package:
?brewer.pal()
cols <- brewer.pal(3,"BuGn") 
cols
# use those three colors to paint an image:
pal <- colorRampPalette(cols)
image(volcano, col=pal(20))

# smoothScatter uses brewer palette:
#   2-D histogram for large number of points
?smoothScatter
x <- rnorm(10000)
y <- rnorm(10000)
smoothScatter(x,y)

# Other plotting notes:
# rgb may be used to create a specific color:
?rgb  
rgb(0, 1, 0)
# colorspace package can be used for a different control over colors

# adding transparency will improve scatterplots:
plot(x,y,col=rgb(0,0,0,0.05),pch=19)


##############################################################################################

#swirl Week 2 Lesson 3: Colors
library(swirl)
sample(colors(),10)
pal <- colorRamp(c("red","blue"))
pal(0)
pal(1)
2
pal(seq(0,1,len=6))
p1<-colorRampPalette(c("red","blue"))
p1(2)
p1(6)
0xcc
p2<-colorRampPalette(c("red","yellow"))
p2(2)
p2(10)
showMe(p1(20))
showMe(p2(20))
showMe(p2(2))
p1
?rgb
4
p3<-colorRampPalette(c("blue","green"),alpha=.5)
p3(5)
plot(x,y,pch=19,col=rgb(0,.5,.5))
plot(x,y,pch=19,col=rgb(0,.5,.5,.3))
cols<-brewer.pal(3,"BuGn")
showMe(cols)
pal<-colorRampPalette(cols)
showMe(pal(20))
image(volcano,col=pal(20))
image(volcano,col=p1(20))
