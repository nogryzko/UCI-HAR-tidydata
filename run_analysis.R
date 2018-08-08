run_analysis <- function(x){

##install packages if not available already
        
        ##install.packages("dplyr") 

##run packages
        
        require(dplyr)

##Reads test data into R
        
        features <- as.character(read.table("UCI HAR Dataset/features.txt")[,2])
        meanstd <- sort(as.numeric(c(grep("[Mm]ean", features), grep("std", features)))) ##finds mean and std

        activity <- as.numeric(read.table("UCI HAR Dataset/test/y_test.txt")[,1]) #vector and column name for activity

        subject <- as.numeric(read.table("UCI HAR Dataset/test/subject_test.txt")[,1]) #vector and column name for subject
        
        xtest <- read.table("UCI HAR Dataset/test/X_test.txt") ##reads table
        colnames(xtest) <- features
        xtest_meanstd <- xtest[,meanstd] ##selects columns with mean and std
        xtest_meanstd <- cbind(subject, activity, xtest_meanstd, stringsAsFactors = FALSE) ##creates additional columns for activity and subject
        
        activity <- as.numeric(read.table("UCI HAR Dataset/train/y_train.txt")[,1])
        
        subject <- as.numeric(read.table("UCI HAR Dataset/train/subject_train.txt")[,1])
        
        xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")
        colnames(xtrain) <- features
        xtrain_meanstd <- xtrain[,meanstd]
        xtrain_meanstd <- cbind(subject, activity, xtrain_meanstd, stringsAsFactors = FALSE)

## Builds composite dataframe and assigns column names
        
        composite <- bind_rows(xtest_meanstd, xtrain_meanstd)
        composite <- as.tbl(arrange(composite, subject, activity))
        

##descriptive activity names
        
        activities <- tolower(as.character(read.table("UCI HAR Dataset/activity_labels.txt")[,2]))
        desc_ac <- gsub("_", " ", activities)
        
##assign descriptive activity names        
        
        a <- as.numeric(1:6)
        
        for (i in a) {
                
                composite$activity <- gsub(i, desc_ac[i], composite$activity)
                
        } 
        
##descriptive variable names
        
        vnames <- make.names(colnames(composite))
        vnames <- gsub("(?!^)(?=[[:upper:]])", " ", vnames, perl=T)
        vnames <- gsub("\\.", " ", vnames, perl=T)
        vnames <- gsub("(^|[[:space:]])([[:alpha:]])", "\\1\\U\\2", vnames, perl=T)
        vnames <- gsub("\\s", "", vnames, perl=T)
        vnames <- gsub("(?!^)(?=[[:upper:]])", " ", vnames, perl=T)
        vnames <- gsub("Body Body", "Body", vnames, perl=T)
        colnames(composite) <- vnames
        
        
#generates final tidy dataset of averages for above values
        
        gcomposite <- group_by(composite, Subject, Activity)
        
        comp_mean <- summarize_all(gcomposite, mean)
        
        write.table(comp_mean, "tidymeans", sep="\t")
        
}
