library(reshape2)

# Read list of activites and features
activityList <- read.table("UCI HAR Dataset/activity_labels.txt")
activityList[,2] <- as.character(activityList[,2])
featureList <- read.table("UCI HAR Dataset/features.txt")
featureList[,2] <- as.character(featureList[,2])

# Filter list of features to only contain mean and
# standard deviation measures
requiredFeatures <- grep(".*mean.*|.*std.*", featureList[,2])
requiredFeatures.names <- featureList[requiredFeatures,2]

## Format feature names
requiredFeatures.names = gsub('-mean', 'Mean', requiredFeatures.names)
requiredFeatures.names = gsub('-std', 'Std', requiredFeatures.names)
requiredFeatures.names <- gsub('[-()]', '', requiredFeatures.names)


# Load the datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[requiredFeatures]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[requiredFeatures]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

# Merge test and train data
tidyData <- rbind(train, test)
colnames(tidyData) <- c("subject", "activity", requiredFeatures.names)

# Turn activities & subjects into factors
tidyData$activity <- factor(tidyData$activity, levels = activityList[,1], labels = activityList[,2])
tidyData$subject <- as.factor(tidyData$subject)

tidyData.melted <- melt(tidyData, id = c("subject", "activity"))
tidyData.mean <- dcast(tidyData.melted, subject + activity ~ variable, mean)

write.table(tidyData.mean, "tidy_dataset.txt", row.names = FALSE, quote = FALSE)