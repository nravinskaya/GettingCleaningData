## download the data file (if it does not already exist)
## and extract the content of the archive
if(!file.exists("./UCI HAR Dataset")){
  zipFileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(zipFileUrl, destfile="Dataset.zip", mode="wb")
  unzip(zipfile = "Dataset.zip")
}

## read the data into R while assigning the corresponding names to the variables (columns)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = c("label"))
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = c("label"))
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = c("subject"))
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = c("subject"))
feature <- read.table("./UCI HAR Dataset/features.txt", col.names = c("featurenumber", "featurename"))

## note: the default parametr check.names=TRUE automatically replaces non-alphabetic characters in column names by points
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = feature$featurename)
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = feature$featurename)

## add subject columns and activity lables columns to the training and the test sets
X_train <- cbind(subject_train, y_train, X_train)
X_test <- cbind(subject_test, y_test, X_test)

## merge the training and the test sets to create one data set
library(dplyr)
X_all <- bind_rows(X_train, X_test)

## extract variable names with mean() and std()
X_all <- select(X_all, grep("\\.mean\\.|std|subject|label", names(X_all), value = TRUE))
## or I can use "[Mm]ean|std|subject|label" to extract all variable names with the "mean" fragment
## but as I understood from the discussions on the forums of this course,
## the student decides for himself which variables to choose

## read the data for activity lables while assigning the corresponding names to the variables (columns)
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("number", "name"))

## use activity names instead of numbers (labels) in my dataset
X_all$label <- factor(X_all$label, levels = activity_labels$number, labels = activity_labels$name)

## descriptive variable names were assigned to the dataset while reading data
## and all special characters like underscores, dashes and parentheses was replaced by points
## => somewhere I get ".." or "..." fragments in my new column names
## now to tidy the column names, I can use gsub() to remove points and tolower()
## but I think in this case the column names will be hard to read for people
## so I decided to leave the names as that formed when reading: "tBodyAcc.mean...X", "fBodyAccMag.std.." etc.

## create an independent tidy data set with the average of each variable for each activity and each subject
X_tidy_wide <- X_all %>% group_by(subject, label) %>% summarise_all(mean)

## create long-format data with two ID variables ("subject" and "label")
## and all the rest columns with numeric values (from wide-format) => two colunms (in long-format):
## a "variable" column is for variables and a "value" column is for the mean of this variables
library(reshape2)
X_tidy_long <- melt(X_tidy_wide, id.vars = c("subject", "label"))

## both data sets (wide and long) are tidy, as they correspond to the three basic principles of tidy data:
## - each variable forms a column
## - each observation forms a row
## - each type of observational unit forms a table
##
## depending on the problem we are trying to solve,
## we can use wide-format data for some types of data analysis and long-format data for others

## data writeout
write.table(X_tidy_long, file = "X_tidy_long.txt", quote = FALSE, sep = " ", col.names = TRUE, row.names = FALSE)

## tidy data set can be read into R with
## read.table("./X_tidy_long.txt", sep = " ", header = TRUE)
