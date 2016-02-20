## Simulation

# rnorm generates random numbers in a normal distribution
# runif generates random numbers in a uniform distribution


# Simulation
rnorm(10)
hist(rnorm(10,20,10))
set.seed(1)      # to reproduce the random numbers
rnorm(10)

# poisson  lamda is average number of eveents per interval  https://en.wikipedia.org/wiki/Poisson_distribution
rpois(10,1)       
hist(rpois(10,1))
ppois(2,2)  # cummulaltive [1] 0.6766764  if the rate is 2, probability of a variable of 2 or less
ppois(4,2)  # cummulaltive [1] 0.947347  if the rate is 2, probability of a variable of 4 or less

# simulation of a linear model
set.seed(20)
x <- rnorm(100)
e <- rnorm(100, 0, 2)  # error
y <- 0.5 + 2 * x + e
summary(y)
plot(x,y)

# simulation of a binary linear model
set.seed(20)
x <- rbinom(100, 1, 0.5)  # binary distribution
e <- rnorm(100, 0, 2)
y <- 0.5 + 2 * x + e
summary(y)
plot(x,y)

# simulation of poisson linear model
set.seed(1)
x <- rnorm(100)
log.mu <- 0.5 + 0.3 * x
y <- rpois(100, exp(log.mu))
summary(y)
plot(x,y)

# random sampling
set.seed(1)
sample(1:10,4)
sample(letters, 5)
sample(1:10)  ##permutation
sample(1:10)
sample(1:10, replace=TRUE)  ## Sample w/replacement
