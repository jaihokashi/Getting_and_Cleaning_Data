# Load "dplyr" package.
library(dplyr)

# Read features.txt file.
features <- read.csv("UCI HAR Dataset/features.txt", sep=" ", header=FALSE)

# Retrieve 2nd column from features_list to append as column name in both Test and Train data set.
column_name <- features[,2]

# Read Train and Test datasets.
TrainDataSet <- read.csv("UCI HAR Dataset/train/X_train.txt", header=FALSE, colClasses="numeric", sep="", fill=TRUE)
TestDataSet <- read.csv("UCI HAR Dataset/test/X_test.txt", header=FALSE, colClasses="numeric", sep="", fill=TRUE)

# Append column names on both Train and Test data set.
names(TrainDataSet) <- column_name
names(TestDataSet) <- column_name

# Read subject_train file and append at into Train data set.
train_subject <- read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)
TrainDataSet <- cbind(train_subject, TrainDataSet)

# Read subject_test file and append at into Test data set.
test_subject <- read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)
TestDataSet <- cbind(test_subject, TestDataSet)

# Read activity_labels file to retrieve activity descriptions.
activity_labels <- read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)
activity <- activity_labels[,2]

# Read Y_train.txt file. Then, update Train activity data with proper description.
TrainActivity <- read.csv("UCI HAR Dataset/train/Y_train.txt", sep=" ", header=FALSE, colClasses="numeric")
TrainActivity <- factor(TrainActivity$V1, labels = activity)

# Read Y_test.txt file. Then, update Test activity data with proper description.
TestActivity <- read.csv("UCI HAR Dataset/test/Y_test.txt", sep=" ", header=FALSE, colClasses="numeric")
TestActivity <- factor(TestActivity$V1, labels = activity) 

# Append Activity column into both Train and Test data sets.
TrainDataSet <- cbind(TrainActivity, TrainDataSet)
TestDataSet <- cbind(TestActivity, TestDataSet)

# Sync Column names so as to merge 2 data sets.
names(TestDataSet) <- names(TrainDataSet)

# Merge Train and Test data sets.
mergedData <- rbind(TrainDataSet, TestDataSet)

# Update proper column names from merged data sets.
colnames(mergedData)[1:2] <- c("Subject", "Activity")

# Extracts only the measurements on the mean and standard deviation for each measurement
TidyDataset <- mergedData %>% select(Subject, Activity, contains("*mean*|*std*")) 

# New data set with the average of each variable for each activity and each subject.
TidyDataset <- TidyDataset %>% group_by(Subject, Activity) %>% summarise_each(funs(mean))

# Export data
write.table(TidyDataset, "TidyDataset.txt", row.name=FALSE)
