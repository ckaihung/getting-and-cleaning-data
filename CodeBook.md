Human Activity Recognition Using Smartphones Dataset
====================================================

The data is summarized from the raw data to 3 different dataset. 

- data
- dataSummarized
- inertiaData

data and dataSummarized
=======================

data and dataSummarized share the same columns
the dataSummarized is grouped by activity and subject using mean

Variables
---------

activity: activity name
subject: subject id
labels: activity id
feature columns

inertiaData
===========

window: window index of record
reading: reading index. There are 128 readings per window
body_acc_x: The body acceleration signal obtained by subtracting the gravity from the total acceleration. The same description applies for the 'body_acc_y' and 'body_acc__z' the Y and Z axis
body_acc_y
body_acc_z
body_gyro_x: The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. The same description applies for the 'body_gyro_y' and 'body_gyro_z' the Y and Z axis
body_gyro_y
body_gyro_z
total_acc_x: The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. The same description applies for the 'total_acc_y' and 'total_acc_z' the Y and Z axis
total_acc_y
total_acc_z
