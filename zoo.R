library(zoo)
Sys.setlocale("LC_TIME", "C")

filename = "~/dl/race_data.csv"

races = read.zoo(filename, header=FALSE, sep=",", skip=1,
		index.colum = list("V7"), tz="UTC")
colnames(races) <- c("Race", "WPM", "Accuracy", "Rank", "Racers", "TextID")

z <- subset(races, time>"2017-05-01")
plot(z)

