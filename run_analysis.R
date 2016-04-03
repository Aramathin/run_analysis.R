# run_analysis.R

library(reshape2)

# Read data into tables
subjecttest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
xtest <- read.table("./UCI HAR Dataset/test/x_test.txt")
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")
subjecttrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
xtrain <- read.table("./UCI HAR Dataset/train/x_train.txt")
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
activitylabels <- read.table("./UCI HAR Dataset/activity_labels.txt")

# Merge the training and test sets to create one data set
subjects <- rbind(subjecttest,subjecttrain)
colnames(subjects) <- "subject"
ys <- rbind(ytest,ytrain)
ys <- merge(ys,activitylabels,by=1)[,2]
xs <-rbind(xtest,xtrain)
colnames(xs) <- features[,2]
mergeddata <- cbind(subjects,ys,xs)

# Extract only the measurements on the mean and standard deviation for each measurement
filtercols <- grep("mean|std",colnames(xs))
mean_stddevs <- mergeddata[,c(1,2,filtercols)]
