---
title: "README"
author: "nogryzko"
date: "7 August 2018"
output: html_document
---

# Human Activity Recognition Using Smartphones Tidy Dataset

This tidy dataset originates from the Human Activity Recognition (HAR )Using Smartphones dataset described in the publication:

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.

https://www.elen.ucl.ac.be/Proceedings/esann/esannpdf/es2013-84.pdf

Additional information:

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012 

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra, Jorge L. Reyes-Ortiz. Energy Efficient Smartphone-Based Activity Recognition using Fixed-Point Arithmetic. Journal of Universal Computer Science. Special Issue in Ambient Assisted Living: Home Care. Volume 19, Issue 9. May 2013

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. 4th International Workshop of Ambient Assited Living, IWAAL 2012, Vitoria-Gasteiz, Spain, December 3-5, 2012. Proceedings. Lecture Notes in Computer Science 2012, pp 216-223.

# UCI HAR Dataset

The original dataset describes the use of smartphone accelerometers and gyroscopes to record the 6 activities performed by volunteers inc arrying out these experiments and provides 561 measured variables of these activities. The data provided encompass raw data filtered and recorded as described in teh above publication split into a "test" and a "training" dataset. Accompanying each data file is an activity and a subject identifier.

The full dataset and associated Readme can be found here:

http://http://archive.ics.uci.edu/ml/machine-learning-databases/00240/

# UCI HAR Tidydata

The enclosed files are a tidy dataset derived from the UCI HAR data which composite both the test and training datasets into the complete 30 subject data and extract only variables containing mean and standard deviation measurements (86 variables). The values for these variables are averaged for each activity performed by each subject resulting in 6 records for each of the 30 subjects (180 observations) for each of the 86 variables. In this data, an activity for each subject constitutes an individual observation.

The tidydata were assembled using the run_analysis script described below. 

# run_analysis.R

run_analysis.R is a script to merge this data and to use it to generate a tidy dataset of the means of each variable for each activity for each subject.

The script requires the dplyr package, which can be installed by:

```{r}
install.packages("dplyr") 
```


The script loads this package before proceeding

It then merges and tidies the data with the following:

1. reads the features text file
        a. generates a character vector of all the variable names
        b. reads this character vector and creates a numerical vector of the positions of each variable containing a               "mean", "Mean", or "std", referring to variables measuring mean or standard deviation.
        
2. reads the test dataset
        a. reads the activity identifier text file as a numeric vector
        b. reads the subject identifier text file as a numeric vector
        c. reads the x_test data into R
        d. uses vector in step 1a. to generate column names for the x_test data table
        b. subsets the x_text data on columns recording mean or standard deviation using vector 1b.
        e. adds the subject identifier and activity identifier to the x_test data table as columns
        
3. reads the training dataset
        a. using the same steps as described for x_test, to generate a labelled x_train dataset
        
4. merges the training and test datasets
        a. concatentates the table using bind_rows into a composite dataframe
        b. orders the data table by subject then activity
        c. reformats the data into a tbl using as.tbl
        
5. generates descriptive activity names
        a. reads activity names into a character vector (lower case) from activity_labels.txt
        b. replaces underscores with spaces to enhance readability
        c. uses a for loop to assign activity names to the integer values described in activity_labels.txt in the data             table
        
6. generates descriptive variable names
        a. generates a character vector from the column names of the composite datatable
        b. modifies the character vector to add spaces, capitalisation and enhance readability
        c. renames the columns in the composite datatable
        
7. generates an average of each variable for each subject and each activity
        a. uses the group_by function to group the data table by subject and activity
        b. sumamrises the grouped data table using the summarise function to generate mean data and record it into a new            data table
        
8. writes the table into a tab delimited file named "tidymeans".

the data table can be accessed here:

Information on the variable names can be found in the submitted codebook, CodeBook.md, and the original dataset in features_info.txt


Additional assistance in assembling this data was provided at:

https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/
