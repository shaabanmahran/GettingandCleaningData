# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.

# Download the data and decompress it
download.file(url="http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", dest="UCI_HAR_Dataset.zip")
unzip("UCI_HAR_Dataset.zip")

# Read data, assign column names if necessary
train_data                  <- read.table("UCI HAR Dataset/train/X_train.txt")
test_data                   <- read.table("UCI HAR Dataset/test/X_test.txt")
f_data                      <- read.table("UCI HAR Dataset/features.txt")
names(f_data)               <- c("fid", "fname")
activity_train_data         <- read.table("UCI HAR Dataset/train/y_train.txt")
names(activity_train_data)  <- c("activity_id")
activity_test_data          <- read.table("UCI HAR Dataset/test/y_test.txt")
names(activity_test_data)   <- c("activity_id")
subject_train_data          <- read.table("UCI HAR Dataset/train/subject_train.txt")
names(subject_train_data)   <- c("subject")
subject_test_data           <- read.table("UCI HAR Dataset/test/subject_test.txt")
names(subject_test_data)    <- c("subject")
activity_lables_data        <- read.table("UCI HAR Dataset/activity_labels.txt")
names(activity_lables_data) <- c("activity_id", "activity_name")

# Merge training and test data
all_data <- rbind(train_data,test_data)

# Extract mean features , std features using grep command. then merge them
mean_features <- f_data[grep("mean\\(\\)", f_data$fname) ,]
std_features  <- f_data[grep("std\\(\\)", f_data$fname) ,]
mean_std_features <- rbind(mean_features, std_features)

# Subset columns to mean and std columns only, and label them with corresponding names
my_data <- all_data[, mean_std_features$fid]
names(my_data ) <- mean_std_features$fname

# Add activity column, subject column
x <- rbind(activity_train_data, activity_test_data)
my_data$activity_id <- unlist(x)
y <- rbind(subject_train_data, subject_test_data)
my_data$subject     <- unlist(y)

# Join the data set with the activity labels 
my_data <- merge(my_data, activity_lables_data, by.x="activity_id", by.y="activity_id")

# Summarized the data into a new data set
library(reshape2)
my_data2 <- melt(my_data, id=c("activity_id", "activity_name", "subject"))
my_data2 <- dcast(my_data2, activity_id + activity_name + subject ~ variable, mean)

# Save the dataset as a file
write.table(my_data2,"my_data2.txt", row.names=FALSE)
