#--
# Setting up libraries required for the project
setwd("C:/Users/142503/Documents/R")
library(plyr)
library(dplyr)
library(reshape)
library(RCurl)

# Download the project file
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
temp <- tempfile()
download.file(fileURL, temp, method = "libcurl")
unzip(temp)

# Read the required files and merge training and test dataset independently
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE)
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE)
x_data <- merge(x_train, x_test, all = TRUE)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE)
y_data <- rbind(y_train, y_test)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)
subject_data <- merge(subject_train, subject_test, all = TRUE)

# Read features file and add it as column names to x_data
features <- read.table("./UCI HAR Dataset/features.txt", header=FALSE)
feat_transpose <- t(features$V2)
colnames(x_data) <- feat_transpose

# Identify mean|std columns and filter it from the x_data
features_meanstd <- filter(features, grepl('mean()|std()', features$V2))
feat_meanstd_c <- as.vector(features_meanstd$V2)
x_data <- select(x_data[ , !duplicated(colnames(x_data))], one_of(feat_meanstd_c))

# Read activity labels file and substitute numeric values with descriptions
act_lbl <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE)
y_act_lbl <- join(y_data, act_lbl, by="V1", type="left")
colnames(y_act_lbl) <- c("y", "Activity")
colnames(subject_data) <- c("Subject_Id")

# Merge all data together
Mstr_Data <- cbind(subject_data, y_act_lbl$Activity, x_data)
Mstr_Data <- rename(Mstr_Data, c("y_act_lbl$Activity" = "Activity"))

# Tidy data set with average of each variable for each activity and each subject
Smry_Data <- Mstr_Data %>% group_by(Subject_Id, Activity)
Tidy_Data <- Smry_Data %>% summarise_each(funs(mean))

write.table(Tidy_Data, "./Tidy_Dataset.csv", sep=",", row.names=FALSE)

