Peer-graded Assignment: Getting and Cleaning Data Course Project
This repository is the José Manuel Mirás Avalos submission for Getting and Cleaning Data course project. 
I entitled the project as "My way for getting and cleaning a dataset".

Dataset
Human Activity Recognition Using Smartphones by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto and Xavier Parra.
Available at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Files
CodeBook.md a code book that describes the variables, the data, and the transformations performed to clean up the data

run_analysis.R carries out different tasks for preparing the data (sertting the working directory, load packages, download the files). Then, it follows the 5 steps required in the definition of the assignment:
1. Merges the training and the test sets to create a single data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Finaldata.txt is the exported text file with the final data after going through all the sequences described above.