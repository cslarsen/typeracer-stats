# Usage: Rscript predict.r ~/.wpm.csv
# Gives a prediction interval given that you type exactly at the mean accuracy

println <- function(...) {
  cat(..., "\n", sep="")
}

parse_csv <- function(filename) {
  data <- read.table(filename, header=FALSE, skip=0, sep=",", dec=".")
  names(data) <- c("race", "wpm", "accuracy", "rank", "racers", "text", "time")
  data$time <- strptime(data$time, format="%Y-%m-%d %H:%M:%OS", tz="UTC")
  return (data)
}

args <- commandArgs(TRUE)
filename <- args[1]
results <- parse_csv(filename)

wpm = results$wpm

acc = results$acc

println("WPM summary")
summary(wpm)

println("\nAccuracy summary")
summary(acc)

println("\nPredicted WPM interval given mean accuracy of ", mean(acc))
predict(lm(wpm ~ acc), data.frame(acc=mean(acc)), interval="predict")
