Getting and Cleaning Data Course Project
================

The goal of the project is to combine data stored non-tidy format in different files. Two data sets are provided - "test" and "train".

Data for the project https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Script should load both "train" and "test" parts of data, select mean and std measurements and merge them with Subject and Activity Name. After that script should calculate mean for values of every measurement, subject and activity.

Output should be saved in tidy format.

How to run
================

1. Download data by the link https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Download run_analysis.R
3. Put unzipped data and R script into same directory
4. Execute run_analysis.R
3. Resulting tidy data set will be saved to file "./UCI HAR Dataset/tidy.txt"
