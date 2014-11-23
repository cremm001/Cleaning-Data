#Before running this script, go to the website below and download the
#zipped files to your working directory
#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# Set working directory
setwd("C:/Users/W440513/datasciencecoursera")

# Need to load dplyr library
library(dplyr)

#Reference zipped files on working directory and unzip them
unzip(zipfile=".\\getdata-projectfiles-UCI HAR Dataset.zip", files = NULL, list = FALSE, overwrite = TRUE,
      junkpaths = FALSE, exdir = getwd(), unzip = "internal",
      setTimes = FALSE)

#Read in features files and transpose
features <- read.table("./UCI HAR Dataset/features.txt", header=FALSE)
newhead <- t(features)
#Create file with the 561 colnames for the data files
names <- newhead[2,1:561]
#Clean up the variable names
names2 <- gsub("-", "", names)
names3 <- gsub(",", "_", names2)
names4 <- gsub("(", "", names3, fixed="TRUE")
names5 <- gsub(")", "", names4, fixed="TRUE")
#Read in test data sets
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt",
                    header = FALSE, col.names=names5)
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt",
                    header = FALSE, col.names="Labels")
subtest <- read.table("./UCI HAR Dataset/test/subject_test.txt",
                      header = FALSE, col.names="Subject")
#Combine test data sets
testdat <- cbind(subtest, ytest, xtest)
#Read in test data sets
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt",           
                     header = FALSE, col.names=names5)
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt",           
                     header = FALSE, col.names="Labels")
subtrain <- read.table("./UCI HAR Dataset/train/subject_train.txt",           
                     header = FALSE, col.names="Subject")
activity <- read.table("./UCI HAR Dataset/activity_labels.txt",           
                       header = FALSE, col.names=c("Labels", "Activity"))
#Combine train data sets
traindat <- cbind(subtrain, ytrain, xtrain)
#Combine test and train data sets
alldat <- rbind(testdat, traindat)
#Keep only Mean and STD related variables
finaldat <- select(alldat, 1, 2, contains("mean", ignore.case=TRUE),
                   contains("std", ignore.case=TRUE))
#Merge Activity names
finaldat2 <- merge(finaldat,activity, by="Labels", all=TRUE)
#Reorder variables and drop the "Labels" variable
finaldat3 <- finaldat2[,c(2,89,3:88)]
# Creates a data set with the average of each variable for each 
#activity and each subject
final_mean <- aggregate(finaldat3, by=list(Subject=finaldat3$Subject, 
                Activity=finaldat3$Activity), mean)
#Drop added column created in the aggregate function
final_mean <- final_mean[,-c(3,4)]
#  write.table() using row.name=FALSE
write.table(final_mean, file="TidyDataProject.txt", row.name=FALSE)