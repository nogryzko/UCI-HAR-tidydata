---
title: "CODEBOOK"
author: "nogryzko"
date: "7 August 2018"
output: html_document
---
#UCI HAR tidy data CodeBook

The data presented are an average of each variable for each activity record for each subject. More detail on experimental setup, filtering and recording metholodogy used can be found in the UCI HAR dataset Readme and features_info.txt fround here:

http://http://archive.ics.uci.edu/ml/machine-learning-databases/00240/

#Subject
Identifier 1:30 which refers to which of the 30 subjects the data was captured for. 


#Activities
Activities for which the data were captured. 

laying
sitting
standing
walking
walking downstairs
walking upstairs

#Variables
Variable names are a composite of the following

T               Time domain signals
F               Frequency domain signals

Mean            Estimated mean of signal
Std             Estimated standard deviation of signal

Acc             Accelerometer signal
Gyro            Gyroscope signal

Body            Body Component of accelerometer signal
Gravity         Gravity component of accelerometer signal

Jerk            Derived time value of linear acceleration and angular velocity
Mag             Magnitude of the signal
         
Angle           Angle between vectors described
Freq            Frequency components of the signal, combined with mean to generate weighted average

X, Y, Z         refer to the dimension the movement was recorded in

#Units and normalisation
Please note that no unites are provided as the data are normalised.


