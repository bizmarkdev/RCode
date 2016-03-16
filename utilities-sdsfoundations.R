# linFit is from:
# SDSFoundations, a Collection of functions and data
# for the University of Texas Department of Statistics MOOC: Foundations of Data Analysis
linFit2 <- function (x, y, sub.title = NULL, xlab = deparse(substitute(x)), 
          ylab = deparse(substitute(y))) 
{
  y1 <- as.numeric(y)
  x1 <- as.numeric(x)
  lin_model <- summary(lm(y1 ~ x1))
  b0 <- lin_model$coef[1]
  b1 <- lin_model$coef[2]
  r2 <- lin_model$r.squared
  plot(x1, y1, main = "Linear", pch = 16, xlab = xlab, ylab = ylab)
  abline(lm(y1 ~ x1))
  mtext(sub.title, 3)
  lin.out <- list(Intercept = b0, Slope = b1, r_sq = r2)
  cat("Linear Fit", "\n", "Intercept = ", round(b0, 5), "\n", 
      "Slope = ", round(b1, 5), "\n", "R-squared = ", round(r2, 5))
  return(invisible(lin.out))
}

# expFit is from:
# SDSFoundations, a Collection of functions and data
# for the University of Texas Department of Statistics MOOC: Foundations of Data Analysis
expFit2 <- function (x, y, sub.title = NULL, xlab = deparse(substitute(x)), 
          ylab = deparse(substitute(y))) 
{
  y1 <- as.numeric(y)
  x1 <- as.numeric(x)
  y1[y1 == 0] <- 1e-09
  ylog <- log(y1)
  lin_model <- summary(lm(ylog ~ x1))
  lin_int <- lin_model$coef[1]
  lin_slope <- lin_model$coef[2]
  a <- exp(lin_int)
  b <- exp(lin_slope)
  r2 <- lin_model$r.squared
  lotx <- seq(min(x1), max(x1), length = 100)
  fity <- a * (b^lotx)
  plot(x1, y1, main = "Exponential", pch = 16, xlab = xlab, 
       ylab = ylab)
  lines(lotx, fity)
  mtext(sub.title, 3)
  exp.out <- list(a = a, b = b, r_sq = r2)
  cat("Exponential Fit", "\n", "a = ", round(a, 5), "\n", "b = ", 
      round(b, 5), "\n", "R-squared = ", round(r2, 5))
  return(invisible(exp.out))
}

# logisticFit is from:
# SDSFoundations, a Collection of functions and data
# for the University of Texas Department of Statistics MOOC: Foundations of Data Analysis
logisticFit2 <- function (x, y, sub.title = NULL, xlab = deparse(substitute(x)), 
                    ylab = deparse(substitute(y))) 
{
  y1 <- as.numeric(y)
  x1 <- as.numeric(x)
  y1[y1 == 0] <- 1e-09
  log.ss <- nls(y1 ~ SSlogis(x1, phi1, phi2, phi3))
  C <- summary(log.ss)$coef[1]
  a <- (exp((summary(log.ss)$coef[2]) * (1/summary(log.ss)$coef[3])))
  b <- exp((1/summary(log.ss)$coef[3]))
  lotx <- seq(min(x1), max(x1), length = 100)
  plot(x1, y1, main = "Logistic Function", pch = 16, xlab = xlab, 
       ylab = ylab)
  pred <- predict(log.ss, data.frame(x1 = lotx))
  lines(lotx, pred)
  mtext(sub.title, 3)
  r1 <- sum((y1 - mean(y1, na.rm = TRUE))^2, na.rm = TRUE)
  r2 <- sum(residuals(log.ss)^2)
  r_sq <- (r1 - r2)/r1
  log.out <- list(C = C, a = a, b = b, r_sq = r_sq)
  cat("Logistic Fit", "\n", "C = ", round(C, 5), "\n", "a = ", 
      round(a, 5), "\n", "b = ", round(b, 5), "\n", "R-squared = ", 
      round(r_sq, 5))
  return(invisible(log.out))
}

# tripleFit is from:
# SDSFoundations, a Collection of functions and data
# for the University of Texas Department of Statistics MOOC: Foundations of Data Analysis
tripleFit2 <- function (x, y, xlab = deparse(substitute(x)), ylab = deparse(substitute(y))) 
{
  y1 <- as.numeric(y)
  x1 <- as.numeric(x)
  y1[y1 == 0] <- 1e-09
  plot(x1, y1, main = "Three fits", pch = 16, xlab = xlab, 
       ylab = ylab)
  abline(lm(y1 ~ x1), lty = 1)
  lin_model <- summary(lm(y1 ~ x1))
  lin.r2 <- lin_model$r.squared
  ylog <- log(y1)
  lin_model.2 <- summary(lm(ylog ~ x1))
  a <- exp(lin_model.2$coef[1])
  b <- exp(lin_model.2$coef[2])
  gx <- seq(min(x1, na.rm = TRUE), max(x1), length = 100)
  gfit <- a * (b^gx)
  lines(gx, gfit, lty = 2)
  exp.r2 <- lin_model.2$r.squared
  log.ss <- nls(y1 ~ SSlogis(x1, phi1, phi2, phi3))
  gx <- seq(min(x1, na.rm = TRUE), max(x1), length = 100)
  pred <- predict(log.ss, data.frame(x1 = gx))
  lines(gx, pred, lty = 3)
  r1 <- sum((y1 - mean(y1, na.rm = TRUE))^2, na.rm = TRUE)
  r2 <- sum(residuals(log.ss)^2)
  log.r2 <- (r1 - r2)/r1
  legend("topleft", legend = c("Linear", "Exponential", "Logistic"), 
         lty = c(1, 2, 3))
  mtext(paste("Linear R2: ", round(lin.r2, 3), " | Exponential R2: ", 
              round(exp.r2, 3), " | Logistic R2: ", round(log.r2, 3), 
              sep = ""), 3)
  fits <- list(linear = lin.r2, exponential = exp.r2, logistic = log.r2)
  return(invisible(fits))
}


# linFitPred is from:
# SDSFoundations, a Collection of functions and data
# for the University of Texas Department of Statistics MOOC: Foundations of Data Analysis
linFitPred2 <- function (x, y, xval, xlab = deparse(substitute(x)), ylab = deparse(substitute(y))) 
{
  y1 <- as.numeric(y)
  x1 <- as.numeric(x)
  lin_model <- summary(lm(y1 ~ x1))
  b0 <- lin_model$coef[1]
  b1 <- lin_model$coef[2]
  gx <- seq(min(x1, xval, na.rm = TRUE), max(c(x1, xval, na.rm = TRUE)), 
            length = 100)
  gfit <- b0 + (b1 * gx)
  plot(x1, y1, main = "Linear", pch = 16, xlim = c(min(gx), 
                                                   max(c(gx, xval))), ylim = c(min(gfit), max(c(y1, gfit), 
                                                                                              na.rm = TRUE)), xlab = xlab, ylab = ylab)
  lines(gx, gfit)
  predy <- b0 + (b1 * xval)
  points(xval, predy, pch = 16, col = "red")
  mtext(paste("Predicted value: ", round(predy, 3), sep = ""), 
        3)
  pred.value <- round(predy, 2)
  return(invisible(pred.value))
}

# expFitPred is from:
# SDSFoundations, a Collection of functions and data
# for the University of Texas Department of Statistics MOOC: Foundations of Data Analysis
expFitPred2 <- function (x, y, xval, xlab = deparse(substitute(x)), ylab = deparse(substitute(y))) 
{
  y1 <- as.numeric(y)
  x1 <- as.numeric(x)
  y1[y1 == 0] <- 1e-09
  ylog <- log(y1)
  lin_model <- summary(lm(ylog ~ x1))
  lin_int <- lin_model$coef[1]
  lin_slope <- lin_model$coef[2]
  a <- exp(lin_int)
  b <- exp(lin_slope)
  gx <- seq(min(x1, na.rm = TRUE), max(c(x1, xval)), length = 100)
  gfit <- a * (b^gx)
  plot(x1, y1, main = "Exponential", pch = 16, xlim = c(min(gx), 
                                                        max(c(gx, xval))), ylim = c(min(gfit), max(c(y1, gfit), 
                                                                                                   na.rm = TRUE)), xlab = xlab, ylab = ylab)
  lines(gx, gfit)
  predy <- a * (b^xval)
  points(xval, predy, pch = 16, col = "red")
  mtext(paste("Predicted value: ", round(predy, 3), sep = ""), 
        3)
  pred.value <- round(predy, 3)
  return(invisible(pred.value))
}

 