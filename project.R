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

train_path <- "D:/CLEBER/Pessoal/Diversos/Estudo Online/Get and Cleaning Data/Project/UCI HAR Dataset/train"
teste_path <- "D:/CLEBER/Pessoal/Diversos/Estudo Online/Get and Cleaning Data/Project/UCI HAR Dataset/test"
path <- "D:/CLEBER/Pessoal/Diversos/Estudo Online/Get and Cleaning Data/Project/UCI HAR Dataset"

treino <- read.table(file.path(train_path, paste("X_train.txt", sep="")) ,  stringsAsFactors = FALSE,header = FALSE)
teste <- read.table(file.path(teste_path, paste("X_test.txt", sep="")) , stringsAsFactors = FALSE,header = FALSE)

features <-  read.table(file.path(path, paste("features.txt", sep="")) , stringsAsFactors = FALSE,header = FALSE)
activity_labels <-   read.table(file.path(path, paste("activity_labels.txt", sep="")) , stringsAsFactors = FALSE,header = FALSE)

treino_activity_labels <- read.table(file.path(train_path, paste("y_train.txt", sep="")) ,  stringsAsFactors = FALSE,header = FALSE)
teste_activity_labels <- read.table(file.path(teste_path, paste("y_test.txt", sep="")) , stringsAsFactors = FALSE,header = FALSE)

dim(treino)
dim(teste)

treino <- mutate(treino, activity = 0)

colnames(treino) <- features[,2]
colnames(teste) <- features[,2]
teste <- mutate(teste, activity = 0)
