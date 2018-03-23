# setwd("Coursera/GettingData/Week4Project")
# library(tidyverse)

# read in the y-train.txt column file giving the number of the training activities
act_train <- read_table(choose.files(), col_names = FALSE)
# read in the y-test.txt column file giving the number corresponding to each of the training activities
act_test <- read_table(choose.files(), col_names = FALSE)

# read in the activity_labels.txt file labels for activity names (without header)
act_lbl <- read_table(choose.files(), col_names = FALSE)

# use JOIN to match labels with activity numbers, joining on subject identifier 
act_train_lbl <- left_join(act_train, act_lbl, by = "X1")
act_test_lbl <- left_join(act_test, act_lbl, by = "X1")

# create a vector of column variable names from features.txt
# read features.txt to create vector containing descriptors of the 561 measurements taken
# Note: read.table used instead of read_table so that two columns are created (separating the line number indicator)
features <- read.table(choose.files())
# extract V2 from features to create vector containing measurement names
feature_labels <- features$V2

# read in the X-train.txt and X_test.txt data from the training/test set, creating column names from feature_labels 
x_train <- read.table(choose.files(), col.names = feature_labels)
x_test <- read.table(choose.files(), col.names = feature_labels)
# x_train and x_test now contain the data with appropriate column names to indicate measurements
# extract only the columns containing "mean()" and "std"

mean1 <- grep("mean()", feature_labels, fixed = TRUE)
# Mean1 contains 33 indicies for labels containing ""mean()"
std1 <- grep("std", feature_labels)
# found 33 st. dev. here. Seems to be all of them


# extract columns of x_train and x_test corresponding to mean() and row bind into one set
mean_data <- rbind(x_train[,mean1], x_test[, mean1])

# extract columns of x_train and x_test corresponding to std and row bind into one set:
std_data <- rbind(x_train[, std1], x_test[, std1] )

# need subject numbers appended to each of above. Row bind subject files, then mutate to mean_data and std_data
# using subject_train.txt and subject_test.txt files. Label column as "subject"
subject_train <- read.table(choose.files(), col.names = "subject")
subject_test <- read.table(choose.files(), col.names = "subject")
subject_data <- rbind(subject_train, subject_test)
# the above file contains subject identifiers only in
# a single column: e.g. 1 appears 347 times, 2 appears 341 times

act_data <- rbind(act_train_lbl,act_test_lbl)

# Need to add subject_data and act_data columns to mean_data and std_data using column bind or mutate
subj_mean_std <- cbind(subject_data,mean_data,std_data)
act_subj_mean_std <- cbind(act_data, subj_mean_std)

# remove column referencing activity by number
act_subj_mean_std <- select(act_subj_mean_std, -X1)
# add column name to new first column: "activity"
names(act_subj_mean_std)[1] = "activity"

# I'm done! Call your work "data" 

data <- act_subj_mean_std

# check that every subject did every activity 
two_way <- table(data$subject, data$activity)

# Make the summary table of the means of all variables

sum_data <- data %>% group_by(subject, activity) %>% summarize_all(mean)

write.table(sum_data, file = "sum_data")


