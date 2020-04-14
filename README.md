# Getting and Cleaning Data course project

This repository contains the following files:

- `README.md`, it provides an overview of the data set and how it was created.
- `TidyDataset.txt`, it contains the cleaned data set.
- `codebook.md`, it describes the contents of the data set. For example, data, variables and transformations are used to generate the data.
- `run_analysis.R`, the R script maintain the logic implementation used to create the tidy data set

The R script `run_analysis.R` are implemented to create the tidy data set:

- Download and unzip file if it doesn't exist.
- Read datasets.
- Merge the training and the test sets to create one data set.
- Extract only the measurements on the mean and standard deviation for each measurement.
- Use descriptive activity names to name the activities in the data set.
- Appropriately label the data set with descriptive variable names.
- Create a second, independent tidy set with the average of each variable for each activity and each subject.
- Write the data set to the `TidyDataset.txt` file.
