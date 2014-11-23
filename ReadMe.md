---
title: "ReadMe for run_analysis.R"
output: html_document
---

run_analysis.R imports data from locally stored files containing measurements from the Human Activity Recognition Using Smartphones Dataset.

The data spans several files:
1. "./UCI HAR Dataset/test/X_test.txt" - contains 561 measurements/calculations for each user/activity test

2. "./UCI HAR Dataset/test/Y_test.txt" - contains activity code for corresponding measurements in #1.

3. "./UCI HAR Dataset/train/X_train.txt" - contains 561 measurements/calculations for each user/activity test

4. "./UCI HAR Dataset/train/Y_train.txt" - contains activity code for corresponding measurements in #3.

5. "./UCI HAR Dataset/test/subject_test.txt" - contains user number for each measurement taken in #1

6. "./UCI HAR Dataset/train/subject_train.txt" - contains user number for each measurement taken in #3

7. "./UCI HAR Dataset/features.txt" - contains variable names for each of the mesaurements/calculations in #1,#3.

8. "./UCI HAR Dataset/activity_labels.txt" - contains descriptive name of each activity

The testing and training data are imported and combined and then the user numbers and activity numbers are attached to the data.

Data for 4 calculations are selected:
1. Average Body Acceleration Magnitude (feature name: "tBodyAccMag-mean()")
2. Standard deviation of Body Acceleration Magnitude (feature name: "tBodyAccMag-std()")
3. Average Gyroscopic Acceleration Magnitude (feature name: "tBodyGyroMag-mean()")
4. Standard deviation of Gyroscopic Acceleration Magnitude (feature name: "tBodyGyroMag-std()")

Because there are multiple instances of these calculations for each User/Activity combination, each quantity is then average for each User/Activity.

This summary of the averages for each measurement for User/Actitvity combinations is then outputted to a textfile (user_data.txt). Description of columns in user_data.txt can be found in CodeBook.txt
