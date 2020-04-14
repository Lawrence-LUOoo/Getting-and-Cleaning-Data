### packages
library(dplyr)

### Download files
if(!file.exists("./data")) {dir.create("./data")}
fileUrl<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile = paste0(getwd(),"/data/Dataset.zip"))
unzip(paste0(getwd(),"/data/Dataset.zip"), exdir=paste0(getwd(),"/data"))

### Reading datasets
activity_labels<-read.table(paste0(getwd(), "/data/UCI HAR Dataset/activity_labels.txt"))

features<-read.table(paste0(getwd(), "/data/UCI HAR Dataset/features.txt"))

X_train<-read.table(paste0(getwd(), "/data/UCI HAR Dataset/train/X_train.txt"))
y_train<-read.table(paste0(getwd(), "/data/UCI HAR Dataset/train/y_train.txt"))
subject_train<-read.table(paste0(getwd(), "/data/UCI HAR Dataset/train/subject_train.txt"))

X_test<-read.table(paste0(getwd(), "/data/UCI HAR Dataset/test/X_test.txt"))
y_test<-read.table(paste0(getwd(), "/data/UCI HAR Dataset/test/y_test.txt"))
subject_test<-read.table(paste0(getwd(), "/data/UCI HAR Dataset/test/subject_test.txt"))

### Changing colnames of datasets

colnames(X_train)<-features[,2]
colnames(y_train)<-"activityId"
colnames(subject_train)<-"subjectId"

colnames(X_test)<-features[,2]
colnames(y_test)<-"activityId"
colnames(subject_test)<-"subjectId"

colnames(activity_labels) <- c('activityId','activityType')

### 1. Merges the training and the test sets to create one data set.
merged_train<-cbind(subject_train,X_train,y_train)
merged_test<-cbind(subject_test,X_test,y_test)
dataset<-rbind(merged_train,merged_test)
dim(dataset)

### 2. Extracts only the measurements on the mean and standard deviation for each measurement.
col_keep<-grepl("subjectId|activityId|mean|std",colnames(dataset))
dataset<-dataset[,col_keep]

### 3. Uses descriptive activity names to name the activities in the data set
dataset$activityId<-factor(dataset$activityId, levels = activity_labels$activityId, activity_labels$activityType)

### 4. Appropriately labels the data set with descriptive variable names.
col_names<-colnames(dataset)
col_names<-gsub("\\(\\)|\\-","",col_names)

col_names <- gsub("^f", "frequencyDomain", col_names)
col_names <- gsub("^t", "timeDomain", col_names)
col_names <- gsub("Acc", "Accelerometer", col_names)
col_names <- gsub("Gyro", "Gyroscope", col_names)
col_names <- gsub("Mag", "Magnitude", col_names)
col_names <- gsub("Freq", "Frequency", col_names)
col_names <- gsub("mean", "Mean", col_names)
col_names <- gsub("std", "StandardDeviation", col_names)
col_names <- gsub("BodyBody", "Body", col_names)

colnames(dataset)<-col_names


### 5. From the data set in step 4, creates a second, independent tidy data set with the average 
### of each variable for each activity and each subject.
tidy_dataset<-dataset %>% group_by(subjectId,activityId) %>% summarise_all(funs(mean))
write.table(tidy_dataset, paste0(getwd(),"/TidyDataset.txt"), row.name=FALSE)
