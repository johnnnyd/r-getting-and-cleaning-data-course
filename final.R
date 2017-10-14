library(reshape2)

setwd("./RProjects")

# main function that is responsible for all calculation for one group of
# input data (either "train" or "test)
combine <- function(measurements, activity, subject) {
    # keep only measurement whose name include "mean()" or "std"
    filtered <- measurements[grep("mean\\(\\)|std\\(\\)", colnames(measurements))]
    
    # convert activity labels to human readable format ("WALKING_DOWNSTAIRS" => "Walking Downstairs")
    activityLabel <- read.table("./UCI HAR Dataset/activity_labels.txt")$V2
    activityName <- unlist(lapply(strsplit(as.character(activityLabel), "_"), function(x) {
        paste0(lapply(x, function(y) {
            paste(substring(y, 1, 1), tolower(substring(y, 2)), sep = "")
        }), collapse=" ")
    }))
    
    # gather all data to one data frame
    activity$activityName <- activityName[activity$V1]
    final <- cbind(activity$activityName, subject$V1, filtered)
    colnames(final)[1] <- "activityName"
    colnames(final)[2] <- "subject"
    
    # do melt-dcast to calcaulate mean by each activity and subject
    m <- melt(final, id.vars = c("activityName", "subject"))
    dcast(m, activityName+subject ~ variable, mean)
}

features <- read.table("./UCI HAR Dataset/features.txt")

# load "test" part of data
measurements <- read.table("./UCI HAR Dataset/test/X_test.txt")
activity <- read.table("./UCI HAR Dataset/test/Y_test.txt")
subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
colnames(measurements) <- features$V2

# combine all data to tidy resulting set containing calculations on "test" 
# part of data
test <- combine(measurements, activity, subject)

# repeat calculations with "train" part of data
measurements <- read.table("./UCI HAR Dataset/train/X_train.txt")
activity <- read.table("./UCI HAR Dataset/train/Y_train.txt")
subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
colnames(measurements) <- features$V2
train <- combine(measurements, activity, subject)

# combine all data to one dataset and output it to CSV file
write.table(rbind(test,train), "./UCI HAR Dataset/tidy.txt", row.name=FALSE)

#rm(list = ls(all = TRUE)) 
