# Course-Project-GCD
Course Project for Getting and Cleaning Data


The original data are the measurements of physical activity from 30 subjects, using smartphones.
- There are 561 variables measured, described in /UCI HAR Dataset/features_info.txt.
- There are 6 types of activity:
	o 1 WALKING
	o 2 WALKING_UPSTAIRS
	o 3 WALKING_DOWNSTAIRS
	o 4 SITTING
	o 5 STANDING
	o 6 LAYING
- There are data from 30 volunteers divided in two groups:
	o test group – 9 volunteers 
	o train group – 21 volunteers
- All data from test and train were loaded and merged into a single data frame resulting in:
	o 10299 observations
	o 81 variables:
		- Volunteer_id
		- Activity
		- 79 measurements – from the 561 original, only the mean and standard deviations were maintained.
- The data frame was converted into a Tidy dataset with the mean of the 79 measurements variables, separated by volunteer id and type of activity resulting in a new data set with the same 81 variables but only 180 observations (mean), saved in Tidy_data.txt
