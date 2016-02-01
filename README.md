Run Instruction
===============

Steps
-----

1. download the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. unzip the file using any archive software. A folder called "UCI HAR Dataset" will be extracted
3. place run_analysis.R along with the same directory with the folder

```R
source('/file/path/to/run_analysis.R')
```

Dependencies
------------

User should have library dplyr and tidyr installed

```R
install.packages("dplyr")
install.packages("tidyr")
```

Outcome
=======

The output is stored under these 3 data frames
in the global environment

- data
- dataSummarized
- inertiaData

The output also export 3 csv files same directory as the script

- data
- dataSummarized
- inertiaData

Methods
=======

The raw data are split between train and test folder. For each function, it does the following

1. read the txt file of the train folder into data frame
2. read the txt file of the text folder into data frame
3. combine using rbind() function to combine 2 data frame into 1 data frame
4. all data frame are stored in named list "mylist"

data
----

- activity: y file. contain the activity id
- activity_labels: contain the binding of activity id and activity name
- subject: contain the subject id

only all columns with mean() and std() are in the data.
This is filtered through features.txt

combine all data together using merge() and cbind()

```R
activity <- merge(activity, activity_labels)
data <- cbind(activity, subject, data)
```

dataSummarized
--------------

the average of each variable for each activity and each subject

inertiaData
-----------

inertiaData in a separate data frame

Requirements
============

Review criteria
---------------

1. The submitted data set is tidy.
2. The Github repo contains the required scripts.
3. GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
4. The README that explains the analysis files is clear and understandable.
5. The work submitted for this project is the work of the student who submitted it.

Getting and Cleaning Data Course Project
----------------------------------------

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
