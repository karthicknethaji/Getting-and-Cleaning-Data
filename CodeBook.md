This codebook explains the variables, and the data transformations that are done in the project code.

READ THE REQUIRED FILES AND MERGE TRAINING AND TEST DATASET INDEPENDENTLY
x_train   --> holds the data from X_train.txt
x_test    --> holds the data from X_test.txt
x_data    --> has the merged data from both x_train and x_test
y_train   --> holds the data from y_train.txt
y_test    --> holds the data from y_test.txt
y_data    --> has the merged data from both y_train and y_test
subject_train --> holds the data from subject_train.txt
subject_test  --> holds the data from subject_test.txt
subject_data  --> has the merged data from both subject_train and subject_test

READ FEATURES FILE AND ADD IT AS COLUMN NAMES TO X_DATA
features  --> holds the data from features.txt file
feat_transpose  --> the data in second variable of features is transposed to represent in column format. Later the columnwise data will be merged along with x_data to represent as columns itself.

IDENTIFY MEAN|STD COLUMNS AND FILTER IT FROM THE X_DATA
features_meanstd --> this vector will be created based on required filtered columns containing mean or std
feat_meanstd_c   --> convert feat_meanstd as a character vector
Then use dplyr select function to filter only the required columns from x_data based on the mean/std column variables present in feat_meanstd_c

READ ACTIVITY LABELS FILE AND SUBSTITUTE NUMERIC VALUES WITH DESCRIPTIONS
act_lbl   --> holds the data from activity_labels.txt
y_act_lbl --> holds the merged daata from both y_data and act_lbl datasets
Then name the columns in the datasets y_act_lbl and subject_data.

MERGE ALL DATA TOGETHER
Mstr_Data --> Using cbind, all the data from the datasets subject_data, y_act_lbl and x_data are combined together
Smry_Data --> Using group_by, the variables that are needed to be aggregated are grouped
Tidy_Data --> Using sumarise_each function, the mean of each of the variables in Smry_Data are summarized to be represented in Tidy_Data

RENAME THE COLUMN VARIABLES TO PROVIDE DESCRIPTIVE VARIABLE NAMES
String function str_sub is applied over the column names in Tidy dataset to provide descriptive variables. Since the names are already explanatory, only the first letter t/f in the existing column names are just ignored.

Finally, the data from Tidy_Data dataset is exported to a flat file using write.table.
