Human Activity Recognition Using Smartphones
============================================
h2. Description
The _run_alaysis.R_ script will create a function `run_analysis(datadir = 'data', file = NULL)`. The `run_analysis` function will take raw phone data from the *Human Activity Recognition (HAR)* project and transform it into usable average `mean` and `std` information by `subject` and `activityType`.

Usage
-----
`run_analysis(datadir = 'data', file = NULL)`
* `datadir` - defaults to `data/`. This is the directory that is the source for the data. Expected here is the `HAR` data with the directory structure intact from the ZIP (i.e. do not change the HAR data names of directories or files).
* `file` - By default the function will not write the data to a file. If not present the data is simply returned from the function. If you specify `file` the results will be written to the file.

Results
-------
The `run_analysis(datadir = 'data', file = NULL)` extracts HAR data and summarizes the `mean`, `std` values for all of the measurements by subject and activity. See [Codebook](CodeBook.md).
