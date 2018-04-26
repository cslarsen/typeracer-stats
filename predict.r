# Usage: Rscript predict.r ~/.wpm.csv
# Gives a prediction interval given that you type exactly at the mean accuracy

println <- function(...) {
  cat(..., "\n", sep="")
}

parse_csv <- function(filename) {
  data <- read.table(filename, header=FALSE, skip=0, sep=",", dec=".")
  names(data) <- c("race", "wpm", "accuracy", "rank", "racers", "text_id", "time", "db", "keyboard")
  data$time <- strptime(data$time, format="%Y-%m-%d %H:%M:%OS", tz="UTC")
  return (data)
}

parse_diffs <- function(filename) {
  data <- read.table(filename, header=FALSE, skip=0, sep=",", dec=".")
  names(data) <- c("wpm", "acc", "diff", "len")
  return (data)
}

args <- commandArgs(TRUE)
if (length(args) == 0) {
  results <- parse_csv("~/.wpm.csv")
} else {
  filename <- args[1]
  results <- parse_csv(filename)
}

wpm = results$wpm

acc = results$acc

println("WPM summary")
summary(wpm)

println("\nAccuracy summary")
summary(acc)

println("\nPredicted WPM interval given mean accuracy of ", mean(acc))
predict(lm(wpm ~ acc), data.frame(acc=mean(acc)), interval="predict")
