#
# project
# 
# You should create one R script called run_analysis.R that does the following. 
# 1 - Merges the training and the test sets to create one data set.
# 2 - Extracts only the measurements on the mean and standard deviation for each
#     measurement. 
# 3 - Uses descriptive activity names to name the activities in the data set
# 4 - Appropriately labels the data set with descriptive variable names. 
# 5 - From the data set in step 4, creates a second, independent tidy data set with
#     the average of each variable for each activity and each subject.

library(dplyr)
#
# define directories of data
#
train_path <- paste(getwd(), "/UCI HAR Dataset/train", sep="")
teste_path <- paste(getwd(), "/UCI HAR Dataset/test", sep="")
path <- paste(getwd(), "/UCI HAR Dataset", sep="")
#
# load data
#
treino <- read.table(file.path(train_path, paste("X_train.txt", sep="")) ,  stringsAsFactors = FALSE,header = FALSE)
treino_users <- read.table(file.path(train_path, paste("subject_train.txt", sep="")) ,  stringsAsFactors = FALSE,header = FALSE)
treino_activity_labels <- read.table(file.path(train_path, paste("y_train.txt", sep="")) ,  stringsAsFactors = FALSE,header = FALSE)

teste <- read.table(file.path(teste_path, paste("X_test.txt", sep="")) , stringsAsFactors = FALSE,header = FALSE)
teste_users <- read.table(file.path(teste_path, paste("subject_test.txt", sep="")) , stringsAsFactors = FALSE,header = FALSE)
teste_tipo <- read.table(file.path(teste_path, paste("y_test.txt", sep="")) , stringsAsFactors = FALSE,header = FALSE)
teste_activity_labels <- read.table(file.path(teste_path, paste("y_test.txt", sep="")) , stringsAsFactors = FALSE,header = FALSE)

features <-  read.table(file.path(path, paste("features.txt", sep="")) , stringsAsFactors = FALSE,header = FALSE)
activity_labels <-   read.table(file.path(path, paste("activity_labels.txt", sep="")) , stringsAsFactors = FALSE,header = FALSE)
# check the size of loaded data
dim(treino)
dim(teste)
#
# STEP 2
# Extracts only the measurements on the mean and standard deviation for each
# measurement. 
#
# also change the name of the columns from numbers to the descriptions
#
meanStdColumns <- grep("mean|std", features$V2, value = FALSE)
meanStdColumnsNames <- grep("mean|std", features$V2, value = TRUE)
teste <- teste[,meanStdColumns]
treino <- treino[,meanStdColumns]
colnames(treino) <- meanStdColumnsNames
colnames(teste) <- meanStdColumnsNames

# create a new column in each data set, with zero, called volunteer_id
# ten copy data to it
teste <- mutate(teste, volunteer_id = 0)
treino <- mutate(treino, volunteer_id = 0)
teste[,80] = teste_users[,1] 
treino[,80] = treino_users [,1]

# create a new column in each data set, with zero, called activity
# ten copy data to it
teste <- mutate(teste, activity = 0)
treino <- mutate(treino, activity = 0)
teste[,81] = teste_activity_labels[,1] 
treino[,81] = treino_activity_labels [,1]

#
# STEP 1
# Merges the training and the test sets to create one data set.
#
# easy to do step 2 first
#
merge_data <- merge(treino,teste,all=TRUE)


# STEP 3
# Uses descriptive activity names to name the activities in the data set
# 
merge_data$activity <- factor(merge_data$activity,labels=c(activity_labels[,2]))



## STEP 5: Creates a second, independent tidy data set with the
## average of each variable for each activity and each subject.


library(reshape2)
tidy_data_1 = melt(merge_data, id=c("volunteer_id", "activity"))
tidy_data_2 = dcast(tidy_data_1, volunteer_id + activity ~ variable, mean)

# adjust column  names
original_names = names(tidy_data_2)[3:length(names(tidy_data_2))]
mean_names = as.character(sapply(original_names, function(n) paste0("MEAN-", n)))
names(tidy_data_2)[3:length(names(tidy_data_2))] <- mean_names
# sava tidy data
write.table(tidy_data_2, file="Tidy_data.txt", row.name=FALSE)
