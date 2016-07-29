# Assignment: Getting and Cleaning Data

## Instructions to run script:
1. Download dataset and extract into working directory.
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Open the run_analysis.R file in RStudio.
3. The script generates a tidy_dataset.txt file.

## R Script:
1. The R script first reads the list of activities and features from
   their respective files.
2. Only the relevant features are filtered out using grep.
3. Using the indices of the relevant features, only those values are
   read from the test and train datasets
4. After merging and the two datasets, the 'activity' and 'subject'
   columns are converted to factors.
5. The mean values of each feature are calculated for a pair of 
   each activity and subject.
6. These mean values are written out to a tidy dataset.
