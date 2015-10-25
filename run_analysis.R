# Merge the different training data files into a single training data set
train_subjects <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
train_activities <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
train_features <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
train_data <- cbind.data.frame(train_subjects, train_activities, train_features)

# Merge the different test data files into a single test data set
test_subjects <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
test_activities <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
test_features <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
test_data <- cbind.data.frame(test_subjects, test_activities, test_features)

# Merge training data set and test data set into a single data set
merged_data <- rbind(train_data, test_data)

# Extract the column names from the features text file and assign column names
# to the columns in the merged data set
feature_names <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")
features <- as.vector(feature_names[,2])
colnames(merged_data) <- c("Subject", "Activity", features)

# Keep only the columns that contain mean and std data, 
# and also the subject and activity columns
merged_clean <- merged_data[ , grepl( "Activity|Subject|mean|std", names( merged_data ) ) ]

# Remove the meanfreq columns, which do not get dropped 
# by the previous command
merged_clean <- merged_clean[ , -(grep( "meanFreq", names( merged_clean ) )) ]

# Read the activity labels file, assign column names
# and convert the data stored as factors into characters
act_labels <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
colnames(act_labels) <- c("Activity", "ActivityName")
i <- sapply(act_labels, is.factor)
act_labels[i] <- lapply(act_labels[i], as.character)

# Replace the activity number with the activity name
# by merging the activity labels data with the merged training/test data
merged_clean <- merge(merged_clean,act_labels,by="Activity" ,all = TRUE)
merged_clean <- merged_clean[c(2,69,3:68)]
merged_clean <- merged_clean[order(merged_clean$Subject, merged_clean$ActivityName),]

# Create a tidy data set containing the average of each variable 
# for each activity and each subject and write it to a text file
library(dplyr)
averages_table <- merged_clean %>% group_by(Subject, ActivityName) %>% summarise_each(funs(mean))
write.table(averages_table,"output.txt", row.names = FALSE)
