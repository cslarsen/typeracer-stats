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

zipfile = args[1]

# Unzip and parse
tmp <- tempdir()
csvfile <- unzip(zipfile, "race_data.csv", exdir=tmp)
data <- read.table(csvfile, header=FALSE, skip=1, sep=",")
unlink(tmp)

# Massage data
names(data) <- c("race", "wpm", "accuracy", "rank", "racers", "text", "time")

# Display summaries of most important metrics
summary(data[,c("wpm", "accuracy", "rank")])

X11()
plot(data$wpm, xlab=c("Race"), ylab=c("WPM"), pch="x")

# TODO: Plot with TIME on x-axis, as it gives a better impression of
# progression (especially if we add moving averages)

wait()

#plot(data[,c("accuracy", "wpm")])
