# Targets #
* Read provided data
* Merge (append) test data with training data set
* Select only some columns of the data (mean, std)
* Add columns for subject and activity available in separate files to the data set
* Add description of activity, not only the id
* Summarize this data into a new dataset containing means for all combinations of activity, subject

# Approach #
* _rbind_ was used for merging training and test data
* _grep_ was used to find columns of mean or std. Criterion is column name contains the string 'mean()' or 'std()'.
  * Note: I exploit the fact that 'std' and 'mean' never appeared together; otherwise this should have been handled differently to avoid duplication of features.
*  The resulting vector of features is used to subset the dataset
*  New columns are added to the data set: activity_id, subject
*  Data is merged (joined) with the activity_labels file to get the description of the activities
*  Finally the data is summarized using melting and dcasting to give the required means

# Dictionary
Variable name| Variable description
------------ | -------------
train_data                |  a data frame for training data
test_data                 |  a data frame for test data
f_data                    |  a data frame for features data
activity_train_data       |  a data frame for activity column loaded from training file
activity_test_data        |  a data frame for activity column loaded from testing file
subject_train_data        |  a data frame for subject column loaded from training file
subject_test_data         |  a data frame for subject column loaded from testing file
activity_lables_data      |  a data frame for labels(descriptions) of the activities
all_data                  |  a data frame for the union of both training and testing data
mean_features             |  a data frame for the features that contain string "mean" in its description
std_features              |  a data frame for the features that contain string "std" in its description
mean_std_features         |  a data frame for the features that contain string "mean" OR "std" in its description
my_data                   |  a data frame for the selected data (first output)
x, y                      |  dummy data frames 
my_data2                  |  a data frame for the summary (second output)
