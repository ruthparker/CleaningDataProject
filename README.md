# CleaningDataProject
This repository is for the Coursera/Johns Hopkins "Getting and Cleaning Data" course project

The project required the following from the wearables data provided from Samsung Galaxy smartphone accelerometers:

1.	Merge the training and the test sets to create one data set.

	To achieve this, the code does the following:
	- Reads the "features.txt" file provided to get the feature names
	- Extracts a vector of the feature names from this file
	- Reads the file containing subject data from both the test and train directories provided
	- Reads the file containing y-axis data (activity) from both the test and train directories provided
	- Reads the file containing x-axis data (measurements) from both the test and train directories provided, using the features vector prepared earlier
	- Put the subject, y-axis, and x-axis data together for both the test and train data using column bind
	- Put the resultant test and train datasets into a new combined dataset using row bind
	- Result is a single data set as per instructions, containing one variable per column and one observation per row
	- The code does some tidying up here to remove all the intermediate datasets
	
2.	Extract only the measurements on the mean and standard deviation for each measurement. 

	To achieve this, the code uses the select() statement of the dplyr library, utilising the "contains" clause.  
	
3.	Use descriptive activity names to name the activities in the data set	

	To achieve this, the code does the following:
	- Set up an "activities" vector containing the activity descriptions obtained from the file "activity_labels.txt" provided
	- Uses the dplyr mutate function to apply this vector to the activity column of our working dataframe
	
4.	Appropriately label the data set with descriptive variable names.

	Descriptive variable names had already been applied to the dataset during initial import (the features names, plus column names for the subject and activity.)
	However, in order to tidy the names further, the names of the working dataset (names(df)) were exported using write.file, and then edited manually.
	Edited names were then read back into R, and a vector created, which was applied back to names(df).
	
5.	From the data set in step 4, create a second, independent tidy data set tes56t with the average of each variable for each activity and each subject.
	To achieve this, the colde does the following:
	- Uses the melt function (library reshape2) to convert the wide data to a dataset stacked on subject and activity
	- Uses the group_by function to create a dplyr grouped dataframe by subject and activity
	- Uses the dplyr summarise_each function to find the mean of each stacked variable, renaming the column to "Mean" and dropping everything else
	- Result is a tidy data set, containing a single average reading per subject/activity combination (180 records - 30 subjects x 6 activities)
