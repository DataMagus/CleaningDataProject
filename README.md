CleaningDataProject
===================

A Tidy dataset is generated via the analysis file tidyDataproject.R

Place the tidyDataproject.R in the /UCI HAR Dataset directory and source it

Step 1: 
  * a) The analysis file reads in the training data from the file \Test\X_test.txt
   
  * b) The analysis file reads in the activity data from the file \Test\Y_test.txt
   
  * c) The analysis file substitutes the activity index for the actual activity name for ease of readibility
   
  * d) The analysis file reads in the testing subject data from the file \Test\subject_test.txt

Step 2:  
  * a) The analysis file reads in the training data from the file \Train\X_train.txt
   
  * b) The analysis file reads in the activity data from the file \Train\Y_train.txt
   
  * c) The analysis file substitutes the activity index for the actual activity name for ease of readibility
   
  * d) The analysis file reads in the testing subject data from the file \Train\subject_train.txt

Step 3:
  * a) The analysis file combines the testing and training data sets by rbinding them vertically
   
  * b) The analysis file combines the test subject and train subject data sets by rbinding them vertically
   
  * c) The analysis file combines the test activity and train activity data sets by rbinding them vertically

Step 4:
  * a) Classify the feature names whether they include mean() or std() in their name
   
   b) Select the features from the combined dataframe that belong to the above category
   
   c) Subset the dataset selecting the columns corresponding to the category above

Step 5:

   a) Use the melt function to stacks the features value columns into a single column of features data.
   This functionality is provided by the reshape2 library

   b) use acast to cast the data into a 3d array that summarizes the data using the mean of each variable for each activity and each subject.  
   
   - The fist dimension of the array indexes the subjects
   - The second dimension of the array is indexed by the activities
   - The third dimension of the array indexes the features
    
Step 6
   a) Using plyer flatten the 3d array into a table

   b) shuffle the columns so that we have "subject","activity","feature label"1,"feature value"
   
   c) write the tidy data to tidyActivityRecognitionData.txt without row.names

