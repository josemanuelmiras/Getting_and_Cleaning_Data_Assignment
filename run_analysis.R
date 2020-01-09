####################################################################################
####### Script for performing the Getting and Cleaning Data Course Project #########
####### Title of the project: "My way for getting and cleaning a dataset"  #########
####### Authored by José Manuel Mirás Avalos in January 2020               #########
####################################################################################


#####################################################################################################################
#######This are the instructions for performing the assignment. They have been directly copied from the Coursera website.
#The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
#The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. 
#You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 
#You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

#One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
  
#  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Here are the data for the project:
  
#  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# You should create one R script called run_analysis.R that does the following.

#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement.
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names.
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
############################################################################################################################################################

## LET'S BEGIN!


###Setting the working directory
getwd()
setwd(getwd())

###Loading the required packages
library(dplyr)

###This code is to check if the file already exists in the working directory. If not, this will download the dataset from the internet.
filename <- "Rawdata.zip"
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename)
}  

###This code is for Checking whether folder exists. If not, it will unzip the file and create the "UCI HAR Dataset" directory.
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}


###Assigning names to the activities and features
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))

###Reading the subject information from the downloaded files, either from the train or the test datasets. 
###These files are assigned to variables named trainsubject and testsubject respectively.
###Both are data.frames with a single column holding the ID numbers of the subjects participating in the study.
trainsubject <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
testsubject <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

###Reading the activity information from the downloaded files, either from the train or the test datasets.
###These files are assigned to variables named trainactiv and testactiv, respectively.
###Both are data.frames with a single column holding the index number of the activities.
trainactiv <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
testactiv <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

###Reading the information from the X_train and X_test files. 
###These files are assigned to variables named traindata and testdata, respectively.
###Both are data frames with 561 columns containing the measurements.
traindata <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
testdata <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)


###Merging the train and test datasets into a single data frame named completedata.
X <- rbind(traindata, testdata)
Y <- rbind(trainactiv, testactiv)
Subject <- rbind(trainsubject, testsubject)
completedata <- cbind(Subject, Y, X)

###Extracting the measurements on the mean and standard deviation for each measurement.
DataTidy <- completedata %>% select(subject, code, contains("mean"), contains("std"))

###Inserting descriptive activity names for the activities in the data set.
DataTidy$code <- activities[DataTidy$code, 2]

###Labelling the data set with descriptive variable names.
names(DataTidy)[2] = "activity"
names(DataTidy)<-gsub("Acc", "Accelerometer", names(DataTidy))
names(DataTidy)<-gsub("Gyro", "Gyroscope", names(DataTidy))
names(DataTidy)<-gsub("BodyBody", "Body", names(DataTidy))
names(DataTidy)<-gsub("Mag", "Magnitude", names(DataTidy))
names(DataTidy)<-gsub("^t", "Time", names(DataTidy))
names(DataTidy)<-gsub("^f", "Frequency", names(DataTidy))
names(DataTidy)<-gsub("tBody", "TimeBody", names(DataTidy))
names(DataTidy)<-gsub("mean", "Mean", names(DataTidy), ignore.case = TRUE)
names(DataTidy)<-gsub("std", "Standard Deviation", names(DataTidy), ignore.case = TRUE)
names(DataTidy)<-gsub("-freq()", "Frequency", names(DataTidy), ignore.case = TRUE)
names(DataTidy)<-gsub("angle", "Angle", names(DataTidy))
names(DataTidy)<-gsub("gravity", "Gravity", names(DataTidy))

###Creating an independent tidy data set with the average of each variable for each activity and subject.
Finaldata <- DataTidy %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(Finaldata, "Finaldata.txt", row.name=FALSE)

str(Finaldata)
Finaldata
