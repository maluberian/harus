f_activity_labels <- 'data/activity_labels.txt'
f_features <- 'data/features.txt'
f_features_info <- 'data/features_info.txt'
subject_test <- 'data/test/subject_test.txt'
X_test <- 'data/test/X_test.txt'
y_test <- 'data/test/y_test.txt'
subject_train <- 'data/train/subject_train.txt'
X_train <- 'data/train/X_train.txt'
y_train <- 'data/train/y_train.txt'

features <- read.csv(f_features, sep = "", header = FALSE)
activity_labels <- read.csv(f_activity_labels, sep = "", header = FALSE)

# laod training data
train_subject <- read.csv(subject_train, header = FALSE)
train_data <- read.csv(X_train, sep = "", header = FALSE)
train_lbl <- read.csv(y_train, header = FALSE)

# load test data
test_subject <- read.csv(subject_test, header = FALSE)
test_data <- read.csv(X_test, sep = "", header = FALSE)
test_lbl <- read.csv(y_test, header = FALSE)

# merge data
combined_data <- rbind(train_data, test_data)
combined_subject <- rbind(train_subject, test_subject)
combined_lbl <- rbind(train_lbl, test_lbl)

#merge labels
colnames(combined_data) <- features
colnames(combined_lbl) <- c('label_id')
colnames(combined_subject) <- c('subject')
colnames(activity_labels) <- c('label_id', 'activity_name')

names(combined_data) <- features
names(combined_lbl)
names(combined_subject)
names(activity_labels)


# remove measurements off the standard deviation
#for(i in names(combined_data)){
#  mn <- mean(as.numeric(as.character(combined_data[,i])))
#  mn
#  std <- sd(as.numeric(as.character(combined_data[,i])))
#  std
#  keep <- combined_data[,abs(combined_data[0,i] - mn) > std]
#  keep
#}

# pull it all together
colnames(combined_data) <- features
final_data <- cbind(combined_lbl, combined_data)
final_data <- cbind(combined_subject, final_data)
final_data <- merge(final_data, activity_labels, by.x = "label_id", by.y = "label_id", all = TRUE)
final_data <- final_data[, -which(names(final_data) %in% c('label_id'))]
names(final_data)
