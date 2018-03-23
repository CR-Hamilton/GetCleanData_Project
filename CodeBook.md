---
title: "CodeBook"
author: "Carolyn Hamilton"
date: "March 22, 2018"
output: html_document
---
## CodeBook for Getting and Cleaning Data Course Project 

Note: Summarized data for Step 5 can be downloaded and read using the following commands in R:
  * fileURL <- "https://raw.githubusercontent.com/CR-Hamilton/GetCleanData_Project/master/sum_data"
  * download.file(fileURL, destfile = "mydata")
  * my_data <- read.table("mydata")


The following is a summary of the data and procedures used in this project. 

Tidyness:

The final data is tidy: Each row contains measurements of a single observation of one subject performing one task.
Each column contains values for a single measurement, such as tBodyGyro-mean()-X. Each cell represents a value of a variable. 

The original data set had 30 volunteers divided into two groups: 
21 training volunteers numbered:  1,3,5,6,7,8,11,14,15,16,17,19,21,22,23,2,26,27,28,29,30. 
9 testing volunteers numbered:  2,4,9,10,12,13,18,20,24.
Subject identifiers are contained in the "subject" column [X2].


The 30 volunteers repeatedly performed each of six activities:
1 = WALKING           
2 = WALKING_UPSTAIRS  
3 = WALKING_DOWNSTAIRS
4 = SITTING           
5 = STANDING          
6 = LAYING

The original data used numerical values ranging from 1 to 6 to represent the activities, for instance "1" = "WALKING". 
Activity names (e.g. WALKING) have been substituted in place of the numbers to make the data more human-friendly. 
The activities are contained in column [X2] which has been descriptively labeled "activity."

These training and testing data were combined into a single data set for this project using rbind to preserve the ordering of the data.
Training data appear in the first 7,352 rows, followed by 2,947 rows of testing data.

Activity_train and Activity_test were combined into a single object using rbind to preserve the ordering.
Subject_train and Subject_test were combined into a single object using rbind to preserve the ordering. 
Activity, Subject, and the measurement data were then combined using cbind. 
Appropriate descriptive column names were supplied.

The short descriptors of the 561 original measurements (contained in features.txt) were stored as a vector and used as column labels when reading the data into R. 
The matching, ordered, column labels preserved the ordering of the columns when data was combined with rbind.
Measurement variables corresponding to means and standard deviations were extracted by selecting columns containing "mean()" and "std()". 

Columns that were not true means, for instance MeanFreq, are not included in this data set.

The following measurements are provided for each record:

	33 means:

[1] tBodyAcc-mean()-X            tBodyAcc-mean()-Y          
[3] tBodyAcc-mean()-Z            tGravityAcc-mean()-X       
[5] tGravityAcc-mean()-Y         tGravityAcc-mean()-Z       
[7] tBodyAccJerk-mean()-X        tBodyAccJerk-mean()-Y      
[9] tBodyAccJerk-mean()-Z        tBodyGyro-mean()-X         
[11] tBodyGyro-mean()-Y          tBodyGyro-mean()-Z         
[13] tBodyGyroJerk-mean()-X      tBodyGyroJerk-mean()-Y     
[15] tBodyGyroJerk-mean()-Z      tBodyAccMag-mean()         
[17] tGravityAccMag-mean()       tBodyAccJerkMag-mean()     
[19] tBodyGyroMag-mean()         tBodyGyroJerkMag-mean()    
[21] fBodyAcc-mean()-X           fBodyAcc-mean()-Y          
[23] fBodyAcc-mean()-Z           fBodyAccJerk-mean()-X      
[25] fBodyAccJerk-mean()-Y       fBodyAccJerk-mean()-Z      
[27] fBodyGyro-mean()-X          fBodyGyro-mean()-Y         
[29] fBodyGyro-mean()-Z          fBodyAccMag-mean()         
[31] fBodyBodyAccJerkMag-mean()  fBodyBodyGyroMag-mean()    
[33] fBodyBodyGyroJerkMag-mean()

	33 standard deviations:

[1] tBodyAcc-std()-X           tBodyAcc-std()-Y          
[3] tBodyAcc-std()-Z           tGravityAcc-std()-X       
[5] tGravityAcc-std()-Y        tGravityAcc-std()-Z       
[7] tBodyAccJerk-std()-X       tBodyAccJerk-std()-Y      
[9] tBodyAccJerk-std()-Z       tBodyGyro-std()-X         
[11] tBodyGyro-std()-Y          tBodyGyro-std()-Z         
[13] tBodyGyroJerk-std()-X      tBodyGyroJerk-std()-Y     
[15] tBodyGyroJerk-std()-Z      tBodyAccMag-std()         
[17] tGravityAccMag-std()       tBodyAccJerkMag-std()     
[19] tBodyGyroMag-std()         tBodyGyroJerkMag-std()    
[21] fBodyAcc-std()-X           fBodyAcc-std()-Y          
[23] fBodyAcc-std()-Z           fBodyAccJerk-std()-X      
[25] fBodyAccJerk-std()-Y       fBodyAccJerk-std()-Z      
[27] fBodyGyro-std()-X          fBodyGyro-std()-Y         
[29] fBodyGyro-std()-Z          fBodyAccMag-std()         
[31] fBodyBodyAccJerkMag-std()  fBodyBodyGyroMag-std()    
[33] fBodyBodyGyroJerkMag-std()

Column 1 contains the Activity and Column 2 contains the Subject identifier.

The variables representing means are contained in columns 3 - 35, followed by the variables representing standard deviations in columns 36 - 68. 

Each type of measurement (e.g. fbodyAccJerk-Y) has a variable for the mean ([25] fBodyAccJerk-mean()-Y ) and a variable for the standard deviation ([25] fBodyAccJerk-std()-Y).
Numbering [25] used above is included so that users can readily see the correspondence among the variables. 
Note that the actual numberings of the columns bFodyAccJerk-mean() and fBodyAccJerk-std() in the final data are [27] and [60], respectively. 

Most, but not all, of the measurements had separate X, Y, and Z components and gathering the variables into a key column (measurement) and a value column (X, Y, or Z) was considered, 
then rejected in order to avoid introducing NA values in the measurements not having X, Y and Z components (see [30] fBodyAccMag above, for instance). 
Means and standard deviations were placed in separate variables rather than using key = "statistic" and value = c("mean", "std") in order to better facilitate the required averaging in Step 5.

A two-way table of activity vs. subject showing the number of times each subject performed each activity is provided below.

   LAYING SITTING STANDING WALKING WALKING_DOWNSTAIRS WALKING_UPSTAIRS
  1      50      47       53      95                 49               53
  2      48      46       54      59                 47               48
  3      62      52       61      58                 49               59
  4      54      50       56      60                 45               52
  5      52      44       56      56                 47               47
  6      57      55       57      57                 48               51
  7      52      48       53      57                 47               51
  8      54      46       54      48                 38               41
  9      50      50       45      52                 42               49
  10     58      54       44      53                 38               47
  11     57      53       47      59                 46               54
  12     60      51       61      50                 46               52
  13     62      49       57      57                 47               55
  14     51      54       60      59                 45               54
  15     72      59       53      54                 42               48
  16     70      69       78      51                 47               51
  17     71      64       78      61                 46               48
  18     65      57       73      56                 55               58
  19     83      73       73      52                 39               40
  20     68      66       73      51                 45               51
  21     90      85       89      52                 45               47
  22     72      62       63      46                 36               42
  23     72      68       68      59                 54               51
  24     72      68       69      58                 55               59
  25     73      65       74      74                 58               65
  26     76      78       74      59                 50               55
  27     74      70       80      57                 44               51
  28     80      72       79      54                 46               51
  29     69      60       65      53                 48               49
  30     70      62       59      65                 62               65

