# Getting-and-Cleaning-Data
Project to collect, work with, and clean a data set and finally prepare a tidy data set

The project comprises of a single script 'run_analysis.R' that performs the following activities:
1) Setting up libraries required for the project
2) Download the project file from web and unzip it
3) Read the required project data files and merge training and test datasets independently
4) Read features file and add it as column names to x_data dataset
5) Identify mean|std columns and filter it from the x_data
6) Read activity labels file and substitute numeric values with descriptions
7) Merge all data togethet to form Mstr_Data dataset
8) Creates Tidy data set with average of each variable for each activity and each subject
9) Generates tidy dataset into a csv file


