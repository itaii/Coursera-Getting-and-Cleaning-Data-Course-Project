Description of the attached script (run_analysis.R)
===========================================================
This script tidies up data collected by smartphones as they were worn by humans performing everyday activities (see study design in CodeBook.md)

The data is described here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
And downloaded from here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

run_analysis.R takes the following steps to produce tidy data:
- Read raw data from the test set and training set (X_test.txt, X_train.txt). We assume they're both located in the working directory of R
- Merge them into one main dataframe
- Rename the columns of the dataframe according to the variable names file (features.txt)
- Keep only columns that represent an average or standard deviation, by searching for column names with the suffix "-mean()" or "-std()"
- Change the names of the columns to a tidy form (no dots and proper capitalization)
- Read the activity ID variable from the test set and training set (y_test.txt, y_train.txt)
- Attach the activity ID's to the main dataframe
- Read the subject ID variable from the test set and training set (subject_test.txt, subject_train.txt)
- Attach the subject ID's to the main dataframe
- Change the activity ID column of the main dataframe to a factor of 6 values using the values in activity_labels.txt
- Group the data by subjects and activity type, and calculate the average of all variables in each group
- Write the result of the previous step into a text file named tidy.txt

Variables in the tidy dataset
=============================
The variables in the tidy dataset are described in the codebook (CodeBook.md). You can find CodeBook.md in the same directory as this file