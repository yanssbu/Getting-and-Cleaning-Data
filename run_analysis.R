# read in all the data files
getwd()
test_s <- read.table ('./data/UCI HAR Dataset/test/subject_test.txt')
test_X <- read.table ('./data/UCI HAR Dataset/test/X_test.txt')
test_Y <- read.table ('./data/UCI HAR Dataset/test/y_test.txt')

train_s <- read.table ('./data/UCI HAR Dataset/train/subject_train.txt')
train_X <- read.table ('./data/UCI HAR Dataset/train/X_train.txt')
train_Y <- read.table ('./data/UCI HAR Dataset/train/y_train.txt')

library(reshape2)

# Merges the training and the test sets to create one data set.
# s is the combined file for subjects
# X is the combined file for test
# Y is the combined file for types of acivities

s <- rbind (test_s, train_s)
Y <- rbind (test_Y, train_Y)
X <- rbind (test_X, train_X)

# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Appropriately labels the data set with descriptive variable names. 

features <- read.table('./data/UCI HAR Dataset/features.txt')[,2]
# clean up the names
features <- gsub('\\(|\\)', '', features)
head(features)
length(features)
names(X) <- features
# subset mean and standard deviation for each measurement
include_features <- features[grep('-mean|-std', features)]
X <- X[, include_features]
dim(X)


# Uses descriptive activity names to name the activities in the data set

activity_label <- read.table('./data/UCI HAR Dataset/activity_labels.txt')
# change label to all lowercase
activity_label[,2] <- tolower(as.character(activity_label[,2]))
# use descriptive activity names
Y[,1] <- activity_label[Y[,1], 2]
names(Y) <- 'activity'
head(Y)

# Appropriately labels the data set with descriptive variable names.
# see above

# use 'subject' as column name for s
names(s) <- 'subject'
# combine subject, activity and measurement together
combined_activity <- cbind(s, Y, X)
dim(combined_activity)
write.table(combined_activity, './data/UCI HAR Dataset/merged_tt_activity.txt')

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

head(combined_activity, 10)
melt_data = melt(combined_activity, id = c('subject','activity'), measure.vars = include_features)

tidy_data <- dcast(melt_data, subject + activity ~ variable, mean)
head(tidy_data)

write.table (tidy_data, file = './data/UCI HAR Dataset/tidy_data.txt')
