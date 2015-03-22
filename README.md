Course project for "Getting and Cleaning Data" course; part of data science series of courses

All code is in one file: "run_analysis.R" Output of steps 1-4 is in my_data Final Output of step 5 is in my_data2 Both the script file "run_analysis.R" and "UCI HAR Dataset" data subfolder should be in the current working directory

Target is to :

    Read provided data
    merge (append) test data with training data set
    Select only some columns of the data (mean, std)
    Add columns for subject and activity available in separate files to the data set
    Add description of activity, not only the id
    summarize this data into a new dataset containing means for all combinations of activity, subject

Approach:

    rbind was used for merging training and test data
    grep was used to find columns of mean or std. Criterion is column name contains the string 'mean()' or 'std()'.
        Note: I exploit the fact that 'std' and 'mean' never appeared together; otherwise this should have been handled differently to avoid duplication of features.
    The resulting vector of features is used to subset the dataset
    New columns are added to the data set: activity_id, subject
    Data is merged (joined) with the activity_labels file to get the description of the activities
    Finally the data is summarized using melting and dcasting to give the required means
