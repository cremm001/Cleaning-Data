The run_analysis.R code will take 8 text files from the UCI HAR website and load them into R. 
They will be combined and a final dataset created with the mean calculated for all variables with "mean" and "std" (for standard deviation) in the name.
The mean calculation will be grouped by Subject and Activity.

Before running this script, you must first go to the following website and download the zipped files to your working directory
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

You will need to alter the Set working directory statement for your own location

You will also need to load dplyr library. If you do not already have the package installed, you will need to do this before running the script.

The basic steps in the script are:

Reference zipped files on working directory and unzip them

Read in the following files into R:
	* features.txt (Some transformations of the data and variable names will be done)
	* X_test.txt (with variable names from the features.txt used as column names)
	* y_test.txt
	* subject_test.txt
	* X_train.txt (with variable names from the features.txt used as column names)
	* y_train.txt
	* subject_train.txt
	* activity_labels.txt

The datasets the 3 test and 3 datasets are combined using cbind then those datasets are combined using rbind.

Only variables with "mean" or "std" in the column names are retained using a select statement.

The more descriptive Activity labels are merged onto the dataset and the old, numeric column is removed.

The Aggregate statement is used to find the mean of each column by Subject and Activity. 

Finally, this table is written out into a .txt file onto the working directory.
