# download the data
if (!file.exists("dataset.zip")){
	fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
	download.file(fileURL, "dataset.zip")
}  
if (!file.exists("UCI HAR Dataset")) { 
	unzip("dataset.zip")
}

features <- read.table(file = "UCI HAR Dataset/features.txt",
					   col.names = c("featureID", "featureName"))

# read and merge test/training data
testData <- read.table(file = "UCI HAR Dataset/test/X_test.txt")
trainData <- read.table(file = "UCI HAR Dataset/train/X_train.txt")
data <- rbind(testData, trainData)

# change the names of columns in data, according to feature list
names(data) <- features$featureName

# only keep the features that end with "-mean()" or "-std()"
allCols <- names(data)
colsToKeep <- grep("-mean\\(\\)|-std\\(\\)", allCols)
data <- data[,colsToKeep]

# clean column names
names(data) <- gsub("\\(\\)", "", names(data))
names(data) <- gsub("\\-", ".", names(data))
names(data) <- gsub(".mean(.)?", "Mean", names(data))
names(data) <- gsub(".std(.)?", "Std", names(data))

# read and merge test/training activities
testActivities <- read.table(file = "UCI HAR Dataset/test/y_test.txt",
							 col.names = c("Activity"))
trainActivities <- read.table(file = "UCI HAR Dataset/train/y_train.txt",
							  col.names = c("Activity"))
activities <- rbind(testActivities, trainActivities)

# add activities to data
data <- cbind(data, activities)

# read and merge test/training subjects
testSubjects <- read.table(file = "UCI HAR Dataset/test/subject_test.txt",
							 col.names = c("SubjectID"))
trainSubjects <- read.table(file = "UCI HAR Dataset/train/subject_train.txt",
							  col.names = c("SubjectID"))
subjects <- rbind(testSubjects, trainSubjects)

# add subjects to data
data <- cbind(data, subjects)

# read activity labels and change the main data to use them like a factor
activityLabels <- read.table(file = "UCI HAR Dataset/activity_labels.txt",
							 col.names = c("ActivityID", "ActivityName"))

# change the type of the Activity colmn into a factor, based on the activity labels
data$Activity <- factor(data$Activity, levels=activityLabels$ActivityID, labels=activityLabels$ActivityName)

library(dplyr)

# group the data by subject ID and activity label, and then summarize all variables
summarizedData <- data %>% group_by(SubjectID, Activity) %>% summarize_all(mean)

# Take the data and write it to a file
write.table(summarizedData, file="tidy.txt", row.names = FALSE)