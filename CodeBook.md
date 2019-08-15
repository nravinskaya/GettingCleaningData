
## Initial data

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones> 

## R script

To prepare tidy data set run_analysis.R does the following:  

- downloads the data file (if it does not already exist) and extracts the content of the archive  
- reads the data into R while assigning the corresponding names to the variables (columns) and automatically replaces non-alphabetic characters in column names by points  
- adds subject columns and activity lables columns to the training and the test sets  
- merges the training and the test sets to create one data set  
- extracts variable names with mean() and std() as they were named in the source file features.txt  
- reads the data for activity lables while assigning the corresponding names to the variables (columns)  
- uses activity names instead of numbers (labels)  
- creates an independent wide tidy data set with the average of each variable for each activity and each subject  
- creates a long-format tidy data set  
- writes out the long-format tidy data set in file X_tidy_long.txt  

## Notes

1. Extracting "only the measurements on the mean and standard deviation for each measurement" sounds ambiguous. As I understood from the discussions on the forums of this course, the student decides for himself which variables to choose. My choice was to extract only variables with mean() and std() in their names.   

2. Descriptive variable names were assigned to the dataset while reading data and all special characters like underscores, dashes and parentheses was replaced by points. To tidy the column names, I could use tolower() and gsub() to remove points but I think in this case the column names would be hard to read for people. So I decided to leave the names as that formed when reading data into R: "tBodyAcc.mean...X", "fBodyAccMag.std.." etc.  

3. Both data sets (wide and long) are tidy, as they correspond to the three basic principles of tidy data:  
  - each variable forms a column  
  - each observation forms a row  
  - each type of observational unit forms a table  

Depending on the problem we are trying to solve, we can use wide-format data for some types of data analysis and long-format data for others.

## Columns in the final long-format data set 

- **subject** - participant who performed the activity  
	* numbered from 1 to 30  

- **label** - activity undertaken during data collection  
	* WALKING  
	* WALKING_UPSTAIRS  
	* WALKING_DOWNSTAIRS  
	* SITTING  
	* STANDING  
	* LAYING  

- **variable** - all possible variable types with mean() and std()  
	* Body linear acceleration, time domain, XYZ components, mean and standard deviation  
		1 tBodyAcc.mean...X  
		2 tBodyAcc.mean...Y  
		3 tBodyAcc.mean...Z  
		4 tBodyAcc.std...X  
		5 tBodyAcc.std...Y  
		6 tBodyAcc.std...Z  

	* Gravitational acceleration, time domain, XYZ components, mean and standard deviation  
		7 tGravityAcc.mean...X  
		8 tGravityAcc.mean...Y  
		9 tGravityAcc.mean...Z  
		10 tGravityAcc.std...X  
		11 tGravityAcc.std...Y  
		12 tGravityAcc.std...Z  
	* Body linear jerk, time domain, XYZ components, mean and standard deviation  
		13 tBodyAccJerk.mean...X  
		14 tBodyAccJerk.mean...Y  
		15 tBodyAccJerk.mean...Z  
		16 tBodyAccJerk.std...X  
		17 tBodyAccJerk.std...Y  
		18 tBodyAccJerk.std...Z  
	* Body angular velocity, time domain, XYZ components, mean and standard deviation  
		19 tBodyGyro.mean...X  
		20 tBodyGyro.mean...Y  
		21 tBodyGyro.mean...Z  
		22 tBodyGyro.std...X  
		23 tBodyGyro.std...Y  
		24 tBodyGyro.std...Z  
	* Body angular jerk, time domain, XYZ components, mean and standard deviation  
		25 tBodyGyroJerk.mean...X  
		26 tBodyGyroJerk.mean...Y  
		27 tBodyGyroJerk.mean...Z  
		28 tBodyGyroJerk.std...X  
		29 tBodyGyroJerk.std...Y  
		30 tBodyGyroJerk.std...Z  
	* Body linear acceleration, time domain, magnitude, mean and standard deviation  
		31 tBodyAccMag.mean..  
		32 tBodyAccMag.std..  
	* Gravitational acceleration, time domain, magnitude, mean and standard deviation  
		33 tGravityAccMag.mean..  
		34 tGravityAccMag.std..  
	* Body linear jerk, time domain, magnitude, mean and standard deviation  
		35 tBodyAccJerkMag.mean..  
		36 tBodyAccJerkMag.std..  
	* Body angular velocity, time domain, magnitude, mean and standard deviation  
		37 tBodyGyroMag.mean..  
		38 tBodyGyroMag.std..  
	* Body angular jerk, time domain, magnitude, mean and standard deviation  
		39 tBodyGyroJerkMag.mean..  
		40 tBodyGyroJerkMag.std..  
	* Body angular jerk, time domain, magnitude, mean and standard deviation  
		41 tBodyGyroJerkMag.mean..  
		42 tBodyGyroJerkMag.std..  
	* Body linear acceleration, frequency domain, XYZ components, mean and standard deviation  
		43 fBodyAcc.mean...X  
		44 fBodyAcc.mean...Y  
		45 fBodyAcc.mean...Z  
		46 fBodyAcc.std...X  
		47 fBodyAcc.std...Y  
		48 fBodyAcc.std...Z  
	* Body linear jerk, frequency domain, XYZ components, mean and standard deviation  
		49 fBodyAccJerk.mean...X  
		50 fBodyAccJerk.mean...Y  
		51 fBodyAccJerk.mean...Z  
		52 fBodyAccJerk.std...X  
		53 fBodyAccJerk.std...Y  
		54 fBodyAccJerk.std...Z  
	* Body angular velocity, frequency domain, XYZ components, mean and standard deviation  
		55 fBodyGyro.mean...X  
		56 fBodyGyro.mean...Y  
		57 fBodyGyro.mean...Z  
		58 fBodyGyro.std...X  
		59 fBodyGyro.std...Y  
		60 fBodyGyro.std...Z  
	* Body linear acceleration, frequency domain, magnitude, mean and standard deviation  
		61 fBodyAccMag.mean..  
		62 fBodyAccMag.std..  
	* Body linear jerk, frequency domain, magnitude, mean and standard deviation  
		63 fBodyAccJerkMag.mean..  
		64 fBodyAccJerkMag.std..  
	* Body angular velocity, frequency domain, magnitude, mean and standard deviation  
		65 fBodyBodyGyroMag.mean..  
		66 fBodyBodyGyroMag.std..  
	* Body angular jerk, frequency domain, magnitude, mean and standard deviation  
		67 fBodyBodyGyroJerkMag.mean..  
		68 fBodyBodyGyroJerkMag.std..  

- **value** - the mean values of variables from "variable" column  
