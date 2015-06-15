# CodeBook
This is a codebook that describes the dataset, variables and transformations have been performed to clean up the data according to the requirment of the course project

## Data source

    Original data: 
    	https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
    Original description of the dataset: 
    	http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Process and Transformations
	1. read in all the data files using read.table: 
		s is for the subject file; 
		X is for the variable measurements; 
		Y is for types of activities
	2. import 'reshape2' library
	3. use rbind to combind the 'test' files and 'train' files
	4. read in the 'features' file, so the variable names in X can be replaced by appropriate feature names
	5. extract measurements on mean and standard deviation, using grep and then subset dataframe X
	6. read in the 'activity_labels' file, so the activities can be labeled with proper names in dataframe Y
	7. combine the 3 dataframes 's', 'X' and 'Y' into a big dataframe, using cbind. This file is also saved as 'combined_activity'
	8. to generate dataframe with each variable for each activity and each subject, melt from 'reshape2' is used:
		data is melt using the combination of 'subject' and 'activity' as ID variables and the measure variables are all the measurements. the melted data was then split by ID variables and the mean of measure variables were calculated to generate the tidy_data.
	9. The tidy_data is in total 180 rows, since there are 30 subjects and 6 activities.




