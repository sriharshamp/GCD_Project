# Getting and Cleaning Data Project
The following is a description of the script run_analysis.R used to create the tidy data set.

## Running the script
* To run this script, save the script run_analysis.R to the directory containing the training and test data files.
* On running the above script, a tidy data set is created which is written to a file called output.txt.
* The text file output.txt is stored in the same directory as the script and the original data files.

## How the script works
* First, the script merges all the training data files into a consolidated training data set.
* Then, all the test data files are consolidated into a test data set.
* The training and test data sets created above are merged into a single data set.
* Then, extract the column names from the features text file and assign column names to the columns in the merged data set.
* As required,only the mean and std columns are retained among the features, deleting the rest.
* The activity numbers are replaced by the activity names in the merged data set.
* The tidy data set is created containing the means of the retained features,grouped by subject and activity name.
* The tidy data set is written to a text file called output.txt.

## Please look as the comments in the script for a more detailed description of the functioning of the script.
