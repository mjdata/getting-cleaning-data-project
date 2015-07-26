##Files in this project

#Data file: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#

## Getting and Cleaning Data Project


Git repo for the submission of the course project for the Johns Hopkins Getting and Cleaning Data course.

### Overview
This project serves to demonstrate the collection and cleaning of a tidy data set that can be used for subsequent
analysis. A full description of the data used in this project can be found at [The UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

[The source data for this project can be found here.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

### Assumptions of the script
Please ensure you set the working directory to the location of these code files on your computer. The unzipped dataset folder `UCI HAR Dataset` should be contained within this folder.
eg: `setwd("~/Documents/coursera/gettingCleaningData/assign")`




### Project Summary
The following is a summary description of the project instructions

You should create one R script called run_analysis.R that does the following. 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

### Additional Information
Additional information about the variables, data and transformations can be found in the CodeBook.md file.

# Getting and Cleaning Data - Course Project

This is the course project for the Getting and Cleaning Data Coursera course.
The R script, `run_analysis.R`, works as follows:

1. Loads the relevant data files and adds appropriate column headers
2. Loads both the training and test datasets, retaining only those columns which
   reflect a mean or standard deviation
3. Loads the activity and subject data for each dataset, and merges those
   columns with the dataset
4. Merges the two datasets
5. Looks up the activity names substituting these for the activityId
6. Creates a tidy dataset that consists of the mean value of each
   variable for each subject and activity pair.

The end result is shown in the file `tidydata.txt`.
