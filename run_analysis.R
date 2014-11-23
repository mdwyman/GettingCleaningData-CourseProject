#required libraries
library(dplyr)

## 1. Merge training and test sets into one dataset
fn_test_x <- "./UCI HAR Dataset/test/X_test.txt"
fn_test_y <- "./UCI HAR Dataset/test/Y_test.txt"

fn_train_x <- "./UCI HAR Dataset/train/X_train.txt"
fn_train_y <- "./UCI HAR Dataset/train/Y_train.txt"

fn_test_usr <- "./UCI HAR Dataset/test/subject_test.txt"
fn_train_usr <- "./UCI HAR Dataset/train/subject_train.txt"

fn_dat_names <- "./UCI HAR Dataset/features.txt"

raw_test_d <- read.table(file = fn_test_x)
raw_train_d <- read.table(file = fn_train_x)

raw_test_act <- read.table(file = fn_test_y)
raw_test_usr <- read.table(file = fn_test_usr)

raw_train_act <- read.table(file = fn_train_y)
raw_train_usr <- read.table(file = fn_train_usr)

features <- read.table(file = fn_dat_names)

usrs <- rbind(raw_train_usr, raw_test_usr)
acts <- rbind(raw_train_act, raw_test_act)

usr_act <- data.frame(usrs, acts)
names(usr_act)<- c("User","Activity")

raw_d <- data.frame(rbind(raw_train_d,raw_test_d))
names(raw_d) <- features[,2]

all_dat <- data.frame(usr_act, raw_d)
rm(usr_act, raw_d) #clear some memory

## 2. Extract only the measurements on the mean and std for the measurement

# Getting only mean and stdev for Body Acceleration Magnitude and Body Gyro Magnitude
dats <- c(1,2,c(grep("tBodyAccMag-mean()",features[,2])+2,
                grep("tBodyAccMag-std()",features[,2])+2,
                grep("tBodyGyroMag-mean()",features[,2])+2,
                grep("tBodyGyroMag-std()",features[,2])+2))
means <- data.frame(all_dat[dats])
rm(all_dat) #clear some memory

## 3. Use descriptive activity names to name the activities in the data set
#Using names from activity_labels.txt

fn_act_lab <- "./UCI HAR Dataset/activity_labels.txt"
labels <- read.table(file = fn_act_lab)
means$Activity <- labels[means$Activity,2]

## 4. Appropriately label the data set with descriptive variable names

names(means)[3:6] <- c("Average_Body_Acceleration_Magnitude"
                       ,"Std_Dev_Body_Acceleration_Magnitude"
                       ,"Average_Body_Gyroscopic_Magnitude"
                       ,"Std_Dev_Body_Gyroscopic_Magnitude")

## 5. Create a second independent data set with the average of each variable 
## for each subject and activity
tdat <- group_by(means, User, Activity)
udat <- summarise(tdat, mean(Average_Body_Acceleration_Magnitude, na.rm = TRUE)
                  ,mean(Std_Dev_Body_Acceleration_Magnitude, na.rm = TRUE)
                  ,mean(Average_Body_Gyroscopic_Magnitude, na.rm = TRUE)
                  ,mean(Std_Dev_Body_Gyroscopic_Magnitude, na.rm = TRUE))

names(udat)[3:6] <- c("Average_Body_Acceleration_Magnitude"
                       ,"Std_Dev_Body_Acceleration_Magnitude"
                       ,"Average_Body_Gyroscopic_Magnitude"
                       ,"Std_Dev_Body_Gyroscopic_Magnitude")


write.table(udat, file = "user_data.txt", row.names=FALSE)
