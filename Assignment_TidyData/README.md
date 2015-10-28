# Assignment_TidyData
####This repo is for Coursera: Getting and Cleanning Data- class assignment.
####Raw data is saved in project.zip and project folder. These files are not required as the R script will download the files from URL if those files are not presented in the working directory
####R script is saved in run_analysis.R, including the following steps:
####1. load dplyr and reshape2 packages;
####2. download raw data;
####3. combine test + train data, add column names (features), then extract only mean and std -related columns
####4. combine extracted data + activity
####5. rename columns by descriptive names
####6. add subject to the tidy data
####7. aggregate data by subject and activity, using the mean
