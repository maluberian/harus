library(dplyr)
library(reshape2)

run_analysis <- function(datadir = 'data', file = NULL) {
  starting_dir <- getwd() #store the wd so we can change back when done (before file write)
  setwd(datadir) # make sure we are in the right directory to begin reading data
  f_activity_labels <- 'activity_labels.txt'
  f_features <- 'features.txt'
  f_features_info <- 'features_info.txt'
  subject_test <- 'test/subject_test.txt'
  X_test <- 'test/X_test.txt'
  y_test <- 'test/y_test.txt'
  subject_train <- 'train/subject_train.txt'
  X_train <- 'train/X_train.txt'
  y_train <- 'train/y_train.txt'
  
  features <- read.csv(f_features, sep = "", header = FALSE)
  activity_labels <- read.csv(f_activity_labels, sep = "", header = FALSE)
  
  lbls <- c('subject', 'activityLabel', as.vector(features$V2))
  
  # laod training data
  train_subject <- read.csv(subject_train, header = FALSE)
  train_data <- read.csv(X_train, sep = "", header = FALSE)
  train_lbl <- read.csv(y_train, header = FALSE)
  train_data <- cbind(train_subject, train_lbl, train_data)
  
  # load test data
  test_subject <- read.csv(subject_test, header = FALSE)
  test_data <- read.csv(X_test, sep = "", header = FALSE)
  test_lbl <- read.csv(y_test, header = FALSE)
  test_data <- cbind(test_subject, test_lbl, test_data)
  
  #combine the training set and test data
  all_data <- rbind(train_data, test_data)
  colnames(all_data) <- lbls #label the data
  
  #transform the data by removing frames that aren't mean, std or our identifiers
  all_data <- all_data[, which(colnames(all_data) %in% colnames(all_data)[grep('.*(mean|std|subject|activityLabel)+.*', colnames(all_data))])]
  
  #change the subject frame from numeric identifiers to the activity lables
  all_data$activityLabel <- mapvalues(as.character(all_data$activityLabel), as.character(activity_labels$V1), as.character(activity_labels$V2))
  
  #remove unreadable useless characters
  colnames(all_data) <- gsub("\\(", "", colnames(all_data))
  colnames(all_data) <- gsub("\\)", "", colnames(all_data))
  colnames(all_data) <- gsub("-", ".", colnames(all_data))
  colnames(all_data) <- gsub("_", ".", colnames(all_data))
  
  # reshape the data 
  final_data <- group_by(all_data, subject, activityLabel)
  final_data <- summarise_each(final_data, funs(mean)) 
  
  #change back to the original wd
  setwd(starting_dir)
  
  # if a file is specified write the final data to that file
  if(!is.null(file)) {
    write.table(final_data, file = file, row.name = FALSE)
  }
  
  final_data
}