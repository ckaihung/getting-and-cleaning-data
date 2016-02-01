library(dplyr)
library(tidyr)

kDatasetFolder <- "UCI HAR Dataset"
datasetTypes <- c("train", "test")

activity_labels <- read.table(file.path(kDatasetFolder, "activity_labels.txt"), 
                              col.names = c("labels", "activity"))

features <- read.table(file.path(kDatasetFolder, "features.txt"),
                       col.names = c("features", "featureNames"))

columnLabels = list(
  subject=c("subject"),
  X=features$featureNames,
  y=c("labels")
)

readData <- function(fileDir, mylist) {
  for (datasetType in datasetTypes) {
    files <- list.files(file.path(fileDir, datasetType), pattern=".txt")
    labels <- gsub("_[^_]*\\.txt", "", files)
    for (i in seq(files)) {
      print(paste("proccessing", files[i]))
      df <- read.table(file.path(fileDir, datasetType, files[i]), 
                       col.names = columnLabels[[labels[i]]])
      if (is.null(mylist[[labels[i]]])) {
        mylist[[labels[i]]] <- df  
      }
      else {
        mylist[[labels[i]]] <- rbind(mylist[[labels[i]]], df)
      }
    }
  }
  return(mylist)
}

readInertiaSignalData <- function(datasetTypes) {
  fileDir <- list()
  files <- list()
  
  for (i in seq(datasetTypes)) {
    fileDir[[i]] <- file.path(kDatasetFolder, datasetTypes[i], "Inertial Signals")
    files[[i]] <- list.files(fileDir[[i]]) 
  }
  
  signalLabels <- gsub("_[^_]*\\.txt", "", files[[1]])
  
  inertiaData <- NULL;
  
  for (i in seq(files[[1]])) {
    signalData <- data.frame()
    
    for (j in seq(datasetTypes)) {
      print(paste("processing", files[[j]][i]));
      df <- read.table(file.path(fileDir[[j]], files[[j]][i]))
      
      if (is.null(signalData)) {
        signalData <- df
      }
      else {
        signalData <- rbind(df, signalData) 
      }
    }
    
    # rename columns into reading index
    names(signalData) <- seq(ncol(signalData))
    
    # Add window index to the table
    signalData <- mutate(signalData, window=seq(nrow(signalData)))
    
    # reshape the data
    signalDataGather <- gather(signalData, reading, value, -window)
    signalDataGather$reading <- as.integer((signalDataGather$reading))
    
    # rename column name value into signalLabels
    colnames(signalDataGather)[which(names(signalDataGather) == "value")] <- signalLabels[i]
    
    if (i == 1) {
      inertiaData <- signalDataGather
    }
    else {
      inertiaData <- merge(inertiaData, signalDataGather, by=c("window", "reading"))
    }
  }
  
  inertiaData <- arrange(inertiaData, window, reading)
  return(inertiaData)
}

# reading Data
mylist <- list()
mylist <- readData(kDatasetFolder, mylist)

# Extracts only the measurements on the mean and standard deviation for each measurement.
featureFiltered <- filter(features, grepl("mean\\(\\)|std\\(\\)", featureNames))
data <- mylist[["X"]]
data <- data[,featureFiltered$features]

subject <- mylist[["subject"]]
activity <- mylist[["y"]]

# Uses descriptive activity names to name the activities in the data set
activity <- merge(activity, activity_labels)
data <- cbind(activity, subject, data)

# independent tidy data set with the average of each variable for each activity and each subject
dataSummarized <- data %>% 
  group_by(activity, subject) %>%
  summarize_each(funs(mean))

# Inertia Signals
inertiaData <- readInertiaSignalData(datasetTypes)

# Write all results to csv files
write.table(data, "data.txt", row.name=FALSE)
write.table(dataSummarized, "dataSummarized.txt", row.name=FALSE)
write.table(inertiaData, "inertiaData.txt", row.name=FALSE)