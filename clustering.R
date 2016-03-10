
# Hierarchical clustering - example
#   hclust is deterministic
set.seed(1234) 
par(mar = c(0, 0, 0, 0))
x <- rnorm(12, mean = rep(1:3, each = 4), sd = 0.2)
y <- rnorm(12, mean = rep(c(1, 2, 1), each = 4), sd = 0.2)
plot(x, y, col = "blue", pch = 19, cex = 2)
text(x + 0.05, y + 0.05, labels = as.character(1:12))
#
dataFrame <- data.frame(x=x,y=y)
?dist
dist(dataFrame)

# Hierarchical clustering - hclust - dendrograms
dataFrame <- data.frame(x = x, y = y) 
distxy <- dist(dataFrame) 

hClustering <- hclust(distxy) 
plot(hClustering)
?hclust
class(hClustering)
hClustering

# Prettier dendrograms
myplclust <- function(hclust, lab = hclust$labels, lab.col = rep(1, length(hclust$labels)), hang = 0.1, ...) {
  ## modifiction of plclust for plotting hclust objects *in colour*! Copyright
  ## Eva KF Chan 2009 Arguments: hclust: hclust object lab: a character vector
  ## of labels of the leaves of the tree lab.col: colour for the labels;
  ## NA=default device foreground colour hang: as in hclust & plclust Side
  ## effect: A display of hierarchical cluster with coloured leaf labels.
  y <- rep(hclust$height, 2)
  x <- as.numeric(hclust$merge)
  y <- y[which(x < 0)]
  x <- x[which(x < 0)]
  x <- abs(x)
  y <- y[order(x)]
  x <- x[order(x)]
  plot(hclust, labels = FALSE, hang = hang, ...)
  text(x = x, y = y[hclust$order] - (max(hclust$height) * hang), labels = lab[hclust$order], col = lab.col[hclust$order], srt = 90, adj = c(1, 0.5), xpd = NA, ...)
}

# calling myplclust requires determining # of clusters before running. It just provides a pretty dendrogram.
dataFrame <- data.frame(x = x, y = y)
distxy <- dist(dataFrame)
hClustering <- hclust(distxy)
myplclust(hClustering, lab = rep(1:3, each = 4), lab.col = rep(1:3, each = 4))

# Merging points - average and complete linkage

# heatmap()
#  performs hierarchical clustering on rows and columns
dataFrame <- data.frame(x = x, y = y) 
set.seed(143)
dataMatrix <- as.matrix(dataFrame)[sample(1:12), ] 
heatmap(dataMatrix)

# Rafa's presentation
# https://www.youtube.com/watch?v=wQhVWUcXM0A
# https://en.wikipedia.org/wiki/Principal_component_analysis


# Lesson 2: K-Means Clustering & Dimension Reduction
#   Requires picking a measure of distance. 
#     Continuous: correlation, eudlidean
#     Binary: manhattan
#   Requires picking number of clusters.
#     Get centroid for each cluster, assign things, recalculate
#   kmeans is not deterministic
# See slides 5-10 to see how clustering is an interative process:
#   1. Set strting centroid
#   2. Assign points to closest centroid
#   3. Recaculate centroids
#   4. Reassign values
#   5. Update centroids
# Elements of Statistical Learning p.459-
set.seed(1234) 
par(mar = c(0, 0, 0, 0))
x <- rnorm(12, mean = rep(1:3, each = 4), sd = 0.2)
y <- rnorm(12, mean = rep(c(1, 2, 1), each = 4), sd = 0.2) 
plot(x, y, col = "blue", pch = 19, cex = 2)
text(x + 0.05, y + 0.05, labels = as.character(1:12))

?kmeans
dataFrame <- data.frame(x,y)
kmeansObj <- kmeans(dataFrame, centers = 3)
names(kmeansObj)
kmeansObj
kmeansObj$cluster

# plot the cluster
par(mar = rep(0.2, 4))
plot(x, y, col = kmeansObj$cluster, pch = 19, cex = 2) 
points(kmeansObj$centers, col = 1:3, pch = 3, cex = 3, lwd = 3)

# heatmap the cluster
# http://stackoverflow.com/questions/5158790/data-frame-or-matrix
?image
?t
set.seed(1234)
dataMatrix <- as.matrix(dataFrame)[sample(1:12), ] 
kmeansObj2 <- kmeans(dataMatrix, centers = 3)
par(mfrow = c(1, 2), mar = c(2, 4, 0.1, 0.1)) 
image(t(dataMatrix)[, nrow(dataMatrix):1], yaxt = "n") 
image(t(dataMatrix)[, order(kmeansObj$cluster)], yaxt = "n")

# Principal Components Analysis and Singular Value Decomposition

# There are clusters of variables in the data that independently cause variation.
# As data scientists, we'd like to find a smaller set of multivariate variables 
# that are uncorrelated AND explain as much variance (or variability) of the data as possible.
# This is a statistical approach.

# noisy matrix data
set.seed(12345)
par(mar = rep(0.2, 4))
dataMatrix <- matrix(rnorm(400), nrow = 40) 
image(1:10, 1:40, t(dataMatrix)[, nrow(dataMatrix):1])
#
par(mar = rep(0.2, 4)) 
heatmap(dataMatrix)

# data with a pattern
set.seed(678910) 
for (i in 1:40) { 
  # flip a coin
  coinFlip <- rbinom(1, size = 1, prob = 0.5)
  # if coin is heads add a common pattern to that row 
  if (coinFlip) {
    dataMatrix[i, ] <- dataMatrix[i, ] + rep(c(0, 3), each = 5) }
}
#
par(mar = rep(0.2, 4))
image(1:10, 1:40, t(dataMatrix)[, nrow(dataMatrix):1])
#
par(mar = rep(0.2, 4)) 
heatmap(dataMatrix)
#
hh <- hclust(dist(dataMatrix))
dataMatrixOrdered <- dataMatrix[hh$order, ]
par(mfrow = c(1, 3))
image(t(dataMatrixOrdered)[, nrow(dataMatrixOrdered):1]) 
plot(rowMeans(dataMatrixOrdered), 40:1, , xlab = "Row Mean", ylab = "Row", pch = 19) 
plot(colMeans(dataMatrixOrdered), xlab = "Column", ylab = "Column Mean", pch = 19)


# What if there are more than two variables? And they are all somewhat dependent?
#   We then want a smaller set of variables.

# SVD components: u and v
?svd
svd1 <- svd(scale(dataMatrixOrdered))
svd1
par(mfrow = c(1, 3))
image(t(dataMatrixOrdered)[, nrow(dataMatrixOrdered):1])
plot(svd1$u[, 1], 40:1, , xlab = "Row", ylab = "First left singular vector", pch = 19)
plot(svd1$v[, 1], xlab = "Column", ylab = "First right singular vector", pch = 19)

# SVD - Variance explained
par(mfrow = c(1, 2))
plot(svd1$d, xlab = "Column", ylab = "Singular value", pch = 19) 
plot(svd1$d^2/sum(svd1$d^2), xlab = "Column", ylab = "Prop. of variance explained",pch = 19)

# Relationship to principal components
svd1 <- svd(scale(dataMatrixOrdered))
pca1 <- prcomp(dataMatrixOrdered, scale = TRUE)
plot(pca1$rotation[, 1], svd1$v[, 1], pch = 19, xlab = "Principal Component 1",ylab = "Right Singular Vector 1") 
abline(c(0, 1))

# Components of the SVD - variance explained
#   this shows that one component explains 40% of the variation.
constantMatrix <- dataMatrixOrdered*0
for(i in 1:dim(dataMatrixOrdered)[1]){constantMatrix[i,] <- rep(c(0,1),each=5)} 
svd1 <- svd(constantMatrix)
par(mfrow=c(1,3))
image(t(constantMatrix)[,nrow(constantMatrix):1]) 
plot(svd1$d,xlab="Column",ylab="Singular value",pch=19) 
plot(svd1$d^2/sum(svd1$d^2),xlab="Column",ylab="Prop. of variance explained",pch=19)

# What if we add a second pattern?
#   Create a matrix that has two patterns in the data (a coin flip within a coin flip)
set.seed(678910) 
for (i in 1:40) { 
  # flip a coin
  coinFlip1 <- rbinom(1, size = 1, prob = 0.5) 
  coinFlip2 <- rbinom(1, size = 1, prob = 0.5)
  # if coin is heads add a common pattern to that row 
  if (coinFlip1) {
    dataMatrix[i, ] <- dataMatrix[i, ] + rep(c(0, 5), each = 5) 
  }
  if (coinFlip2) {
    dataMatrix[i, ] <- dataMatrix[i, ] + rep(c(0, 5), 5)
  } 
}
hh <- hclust(dist(dataMatrix)) 
dataMatrixOrdered <- dataMatrix[hh$order, ]

# Run Singular Value Decomposition to display the exact, true pattern of the data just generated.
svd2 <- svd(scale(dataMatrixOrdered))
par(mfrow = c(1, 3))
image(t(dataMatrixOrdered)[, nrow(dataMatrixOrdered):1])
plot(rep(c(0, 1), each = 5), pch = 19, xlab = "Column", ylab = "Pattern 1") 
plot(rep(c(0, 1), 5), pch = 19, xlab = "Column", ylab = "Pattern 2")

# Run SVD to look for patterns in the data.
# v and patterns of variance in rows
#   It needs to pick-up on the two patterns in the data.
#   Note that every other point is either higher or lower.
svd2 <- svd(scale(dataMatrixOrdered))
par(mfrow = c(1, 3))
image(t(dataMatrixOrdered)[, nrow(dataMatrixOrdered):1])
plot(svd2$v[, 1], pch = 19, xlab = "Column", ylab = "First right singular vector") 
plot(svd2$v[, 2], pch = 19, xlab = "Column", ylab = "Second right singular vector")

# d and variance explained
svd1 <- svd(scale(dataMatrixOrdered))
par(mfrow = c(1, 2))
plot(svd1$d, xlab = "Column", ylab = "Singular value", pch = 19) 
plot(svd1$d^2/sum(svd1$d^2), xlab = "Column", ylab = "Percent of variance explained",pch = 19)

# SVD won't work with missing values
dataMatrix2 <- dataMatrixOrdered
## Randomly insert some missing data
dataMatrix2[sample(1:100, size = 40, replace = FALSE)] <- NA
svd1 <- svd(scale(dataMatrix2)) 
## Doesn't work! Returns: Error in svd(scale(dataMatrix2)) : infinite or missing values in 'x'

# One solution is to impute values
#  impute replaces missing value by K-Nearest neighbor from nearby rows.
source("https://bioconductor.org/biocLite.R")
biocLite("impute")
library(impute) ## Available from http://bioconductor.org 
?impute
dataMatrix2 <- dataMatrixOrdered 
dataMatrix2[sample(1:100,size=40,replace=FALSE)] <- NA 
dataMatrix2 <- impute.knn(dataMatrix2)$data
svd1 <- svd(scale(dataMatrixOrdered)) 
svd2 <- svd(scale(dataMatrix2)) par(mfrow=c(1,2))
plot(svd1$v[,1],pch=19)
plot(svd2$v[,1],pch=19)

# Face example
#  will show the value of decomposing values to a smaller set
load("data/face.rda") 
image(t(faceData)[, nrow(faceData):1])
#
svd1 <- svd(scale(faceData))
plot(svd1$d^2/sum(svd1$d^2), pch = 19, xlab = "Singular vector", ylab = "Variance explained")

# Face example - create approximations
svd1 <- svd(scale(faceData))
## Note that %*% is matrix multiplication 
# Here svd1$d[1] is a constant
approx1 <- svd1$u[, 1] %*% t(svd1$v[, 1]) * svd1$d[1]
# In these examples we need to make the diagonal matrix out of d
approx5 <- svd1$u[, 1:5] %*% diag(svd1$d[1:5]) %*% t(svd1$v[, 1:5]) 
approx10 <- svd1$u[, 1:10] %*% diag(svd1$d[1:10]) %*% t(svd1$v[, 1:10])
#
par(mfrow = c(1, 4))
image(t(approx1)[, nrow(approx1):1], main = "(a)")
image(t(approx5)[, nrow(approx5):1], main = "(b)") 
image(t(approx10)[, nrow(approx10):1], main = "(c)") 
image(t(faceData)[, nrow(faceData):1], main = "(d)") ## Original data

