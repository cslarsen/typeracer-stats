Prediction intervals
====================

Since there is a high correlation between WPM and accuracy, one can give a
WPM prediction interval based on a given accuracy.

For example, given that your accuracy is exactly `mean(acc)`, then the
predicted WPM interval will be:

    wpm = c(...)
    acc = c(...)
    predict(lm(wpm ~ acc),
            data.frame(acc=mean(acc)),
            interval="predict");
