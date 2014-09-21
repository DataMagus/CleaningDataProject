# Getting and Cleaning Data Class project
# Generates a tidy data set for Human Activity Recognition
# A codebook for the dataset is available at https://github.com/DataMagus/CleaningDataProject.git
#
# The orginal data set was collected at UCI by
# Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto. 
# Smartlab - Non Linear Complex Systems Laboratory, UCI
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
###########################################################################################

library(reshape2) # Required to melt the data
library(plyr)     # used to flatten data into tidy data frame

# Read the Activity labels from base directory
activity.labels.df = read.table("activity_labels.txt")
# Read the feature labels into a data frame
features.df = read.table("features.txt")

# Get the Test data
setwd("./Test") 
# REad the data in
test.df = read.table("X_test.txt")
# Look at the dimensions of the data
dim(test.df)

#Read the activity
activity.test.df = read.table("y_test.txt")
activity.test.df$V1<-sub(1,"WALKING",activity.test.df$V1)
activity.test.df$V1<-sub(2,"WALKING_UPSTAIRS",activity.test.df$V1)
activity.test.df$V1<-sub(3,"WALKING_DOWNSTAIRS",activity.test.df$V1)
activity.test.df$V1<-sub(4,"SITTING",activity.test.df$V1)
activity.test.df$V1<-sub(5,"STANDING",activity.test.df$V1)
activity.test.df$V1<-sub(6,"LAYING",activity.test.df$V1)

# Read the subject data
subject.test.df = read.table("subject_test.txt")

# Change directory to Training data directory
setwd("../Train") 
train.df= read.table("X_train.txt")
# Look at the dimensions of the data
dim(train.df)

# Join both training and testing datasets vertically
combined.dataset.df <- rbind(train.df,test.df)
# Check the dimensions
dim(combined.dataset.df)

# Read the subject data
subject.train.df = read.table("subject_train.txt")
subjects.combined.df <- rbind(subject.train.df,subject.test.df)
# Check the dimensions
dim(subjects.combined.df)


#Read the activity
activity.train.df = read.table("y_train.txt")
activity.train.df$V1<-sub(1,"WALKING",activity.train.df$V1)
activity.train.df$V1<-sub(2,"WALKING_UPSTAIRS",activity.train.df$V1)
activity.train.df$V1<-sub(3,"WALKING_DOWNSTAIRS",activity.train.df$V1)
activity.train.df$V1<-sub(4,"SITTING",activity.train.df$V1)
activity.train.df$V1<-sub(5,"STANDING",activity.train.df$V1)
activity.train.df$V1<-sub(6,"LAYING",activity.train.df$V1)

activities.combined.df <- rbind(activity.train.df,activity.test.df)


# Go up one level to the directory with the feature labels file
setwd("../") 
# Assign the feature labels to the column names of the combined data frame
names(combined.dataset.df) <-as.character(features.df$V2)


# Lets extract only the measurements on the mean and standard deviation for each measurement. 
category <- grepl('mean()',as.character(features.df$V2)) | grepl('std()',as.character(features.df$V2))
# Select the measurements that meet the criteria
measurements.with.means_std = combined.dataset.df[,category]
names(measurements.with.means_std)<-paste("mean_",names(measurements.with.means_std),sep = "")
# Check out the dimensions
dim(measurements.with.means_std)

# Add the activities
measurements.with.means_std$activity <- activities.combined.df$V1
measurements.with.means_std$subject  <- subjects.combined.df$V1

# Melt the measurements
activityMelt <-melt(measurements.with.means_std,id=c("subject","activity"),measurement.vars=as.character(features.df$V2))

ac <- acast(activityMelt, subject ~ activity ~ variable,mean)
dimnames(ac)

# Use plyr to flatten array into a tidy data frame
aux.df <- adply(ac,c(3,2,1))

# Swap columns to have it by user by activity
tidydata <- aux.df[,c(3,2,1,4)] 
names(tidydata)<-c("subject","activity","feature.label","feature.value")
#check to make sure it is tidy by user by activity so it looks like 
#subject activity          feature.label feature.value
#1       1   LAYING mean_tBodyAcc-mean()-X    0.22159824
#2       1   LAYING mean_tBodyAcc-mean()-Y   -0.04051395
#3       1   LAYING mean_tBodyAcc-mean()-Z   -0.11320355
#4       1   LAYING  mean_tBodyAcc-std()-X   -0.92805647
#5       1   LAYING  mean_tBodyAcc-std()-Y   -0.83682741
#6       1   LAYING  mean_tBodyAcc-std()-Z   -0.82606140
head(tidydata)
# write the tidy data set
write.table(tidydata,file="tidyActivityRecognitionData.txt",row.names=FALSE)
