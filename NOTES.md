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

Predicting WPM for unseen texts
===============================

Given the above, we should also find a metric of the text difficulty. Length is
the obvious one, but number of special symbols, upper-case characters and so on
will affect this. Such things could be weighted, and a good metric for text
difficulty could be created.

When a difficulty metric has been established, it should be calculated for each
text, then to a linear regression as above and then new texts could give a
prediction interval for the WPM based on it.

For example, the WPM for C code should be expected to be very low, while a
short text with only lowercase letters should be high.
