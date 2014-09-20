CleaningDataProject
===================

Repository for the Getting and Cleaning Data class project

A Tidy dataset is generated via the analysis file tidyDataproject.R

Step 1: 
a) The analysis file reads in the training data from the file \Test\X_test.txt
b) The analysis file reads in the activity data from the file \Test\Y_test.txt
c) The analysis file substitutes the activity index for the actual activity name for ease of readibility
d) The analysis file reads in the testing subject data from the file \Test\subject_test.txt

Step 2: 
a) The analysis file reads in the training data from the file \Train\X_train.txt
b) The analysis file reads in the activity data from the file \Train\Y_train.txt
c) The analysis file substitutes the activity index for the actual activity name for ease of readibility
d) The analysis file reads in the testing subject data from the file \Train\subject_train.txt

Step 3:
a) The analysis file combines the testing and training data sets by rbinding them vertically
b) The analysis file combines the test subject and train subject data sets by rbinding them vertically
c) The analysis file combines the test activity and train activity data sets by rbinding them vertically

