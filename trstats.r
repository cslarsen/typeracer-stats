# TypeRacer Statistics
#
# Copyright 2017 Christian Stigen Larsen
# Distributed under the LGPL v3 or later.

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

parse_csv <- function(filename) {
  read.table(filename, header=FALSE, skip=1, sep=",", dec=".")
}

filename = args[1]

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

# Plot WPM against time
X11()
plot(data$time, data$wpm, xlab=c("Time"), ylab=c("WPM"), pch="x")
wait()
