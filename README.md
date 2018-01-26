TypeRacer stats in R
====================

Shows some statistic on your TypeRacer data.

Prerequisites
=============

You need the statistical package R.

How to use
==========

Download your zipped CSV file from TypeRacer, then

    $ Rscript trstats.r race_data.zip

You can also point directly to a CSV file:

    $ Rscript trstats.r race_data.csv

If you supply an additional integer value, it will skip the first N lines:

    $ Rscript trstats.r race_data.csv 1234

This is useful if you want to get stats on the latest scores.

Author and license
==================

Copyright 2017 Christian Stigen Larsen  
Distributed under the LGPL v3 or later.
