# Course Project: Getting & Cleaning Data
# Submitted: 20150726

# Clean workspace & load packages
rm(list = ls())

## Now load up all the relevant data files (excluding the Inertial Data): 
features <- read.table(file = "./UCI HAR Dataset/features.txt", colClasses = "character", header = FALSE)
activityTypes <- read.table(file = "./UCI HAR Dataset/activity_labels.txt", header = FALSE)
colnames(activityTypes) <- c('activityId','activityType')
xTrain <- read.table(file = "./UCI HAR Dataset/train/X_train.txt", header = FALSE)
colnames(xTrain) <- features[,2]
yTrain <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
colnames(yTrain) <- "activityId"

# - 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
subjectTrain <- read.table(file = "./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
colnames(subjectTrain)  <- "subjectId"

xTest <- read.table(file = "./UCI HAR Dataset/test/X_test.txt", header = FALSE)
colnames(xTest) <- features[,2]
yTest <- read.table(file = "./UCI HAR Dataset/test/y_test.txt", header = FALSE)    # - 'test/y_test.txt': Test labels.
colnames(yTest) <- "activityId"

# - 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
subjectTest <- read.table(file = "./UCI HAR Dataset/test/subject_test.txt", header = FALSE)

# Assign column names to the test data imported above
colnames(subjectTest) <- "subjectId"

## Collate training & test data seperately
trainSet <- cbind(yTrain, subjectTrain, xTrain)
testSet <- cbind(yTest, subjectTest, xTest)


## 1. Merge the training and the test sets to create one data set
mergedSet <- rbind(trainSet, testSet)


## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
colNames <- colnames(mergedSet)


# make a logical vector to index the required columns
lVec <- (
    grepl("activity..",colNames) | 
        grepl("subject..",colNames) | 
        grepl("-mean..",colNames) & 
        !grepl("-meanFreq..",colNames) & 
        !grepl("mean..-",colNames) | 
        grepl("-std..",colNames) & 
        !grepl("-std()..-",colNames)
)

extractedSet <- mergedSet[lVec == TRUE]


## 3. Uses descriptive activity names to name the activities in the data set

colnames(extractedSet)[colnames(extractedSet) == "activityId"] <- "activity"
extractedSet[["activity"]] <- activityTypes[ match(extractedSet[['activity']], activityTypes[['activityId']] ) , 'activityType']


## 4. Appropriately labels the data set with descriptive variable names. 

names(extractedSet)<-gsub("^t", "Time", names(extractedSet))
names(extractedSet)<-gsub("^f", "Frequency", names(extractedSet))
names(extractedSet)<-gsub("Acc", "Accelerometer", names(extractedSet))
names(extractedSet)<-gsub("Gyro", "Gyroscope", names(extractedSet))
names(extractedSet)<-gsub("Mag", "Magnitude", names(extractedSet))
names(extractedSet)<-gsub("BodyBody", "Body", names(extractedSet))

# show new descriptive names
names(extractedSet) 


## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## Export to txt file for submission: write.table(  , row.name = FALSE)

library(data.table)
d <- data.table(extractedSet)
tidy <- d[, lapply(.SD, mean), by = c("subjectId", "activity")]
write.table(tidy, "tidydata.txt", row.names = FALSE, quote = FALSE, sep = '\t')



