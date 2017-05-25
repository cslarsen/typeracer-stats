# TypeRacer Statistics
#
# Copyright 2017 Christian Stigen Larsen
# Distributed under the LGPL v3 or later.

if (interactive()) {
  filename = "" # ENTER PATH TO race_data.zip HERE!
} else {
  args <- commandArgs(TRUE)

  println <- function(...) {
    cat(..., "\n", sep="")
  }

  if (length(args) == 0) {
    println("Usage: trstats.r race_data.csv")
    quit("no", 1)
  }

  wait <- function() {
    while (!is.null(dev.list())) {
      Sys.sleep(1)
    }
  }

  filename = args[1]
}

parse_csv <- function(filename) {
  read.table(filename, header=FALSE, skip=1000, sep=",", dec=".")
}

# Unzip and parse
if (endsWith(filename, ".zip")) {
  tmp <- tempdir()
  data <- parse_csv(unzip(filename, "race_data.csv", exdir=tmp))
  unlink(tmp)
} else {
  data <- parse_csv(filename)
}

# Massage data
names(data) <- c("race", "wpm", "accuracy", "rank", "racers", "text", "time")
data$time <- strptime(data$time, format="%Y-%m-%d %H:%M:%OS", tz="UTC")

wpm <- data$wpm
time <- data$time
acc <- data$accuracy

# Display summaries of most important metrics
summary(data[,c("wpm", "accuracy", "rank", "time")])

moving_averages <- function(x, n=5) {
  filter(x, rep(1/n, n), sides=2)
}

# Plots
if (!interactive()) {
  X11()
}

par(mfrow=c(3, 2))

# WPM per race
plot(wpm, main="WPM per Race", pch="x", xlab="Race", ylab="WPM")
# Show moving averages
lines(moving_averages(wpm, n=50), col="darkred", lwd=2)
# Show the mean
abline(h=mean(wpm, lwd=1), col="red")

# WPM per time
plot(time, wpm, main="WPM over Time", pch="x", ylab="WPM", xlab="Time")
lines(moving_averages(wpm, n=50), col="blue", lwd=2)
abline(h=mean(wpm, lwd=1), col="red")

# Histogram WPM
#hist(wpm, main="WPM Histogram", xlab="WPM")
hist(wpm, breaks=100, main="WPM Histogram", xlab="WPM", prob=TRUE)
points(wpm, dnorm(wpm, mean=mean(wpm), sd=sd(wpm)), col="red", pch="x")
abline(v=mean(wpm)-sd(wpm), col="blue")
abline(v=mean(wpm)+sd(wpm), col="blue")
abline(v=mean(wpm), col="red")

# Normal distribution of WPM
plot(wpm, dnorm(wpm, mean(wpm), sd(wpm)), pch="x", main="WPM Normal Plot", ylab="", xlab="WPM")
abline(v=mean(wpm), col="red")

# Accuracy vs WPM
plot(acc, wpm, ylab="WPM", xlab="Accuracy", main="WPM per Accuracy", pch="x")
abline(h=mean(wpm), col="red")

# Accuracy Normal
hist(acc, main="Accuracy Histogram")
#plot(acc, dnorm(acc, mean(acc), sd(acc)), ylab="", xlab="Accuracy", pch="x", main="Accuracy Normal Plot")
#abline(v=mean(acc), col="red")
#abline(h=mean(wpm), col="red")

if (!interactive()) {
  wait()
}
