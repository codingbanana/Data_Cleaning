##Coursera: "Getting and Cleaning Data" course project
# Hao Zhang @ 2015.10.13

# 1. Merges the training and the test sets to create one data set.
##download file, unzip the file
if (!file.exists("project.zip")){
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","project.zip",method = "curl")
}
if (!dir.exists("project")){
    #unzip the file, flatten file structure for easier accessibility
    unzip("project.zip",exdir = "project/", junkpaths = T)
}

# assign variables, inialize values
axial1 <- c("x","y","z")
axial2  <- c("X","y")
acc_type <- c("body","total")
mes_type <- c("acc","gyro")
dat_type <- c("train","test")
#read rownames and colnames
act <- read.table("project/activity_labels.txt",header = F)
feat <- read.table("project/features.txt",header = F)

#read data tables, assign them to same-name objects
for(i in 1:length(dat_type)) {
    assign(paste("subject_",dat_type[i],sep=""), read.table(paste("project/subject_",dat_type[i], ".txt",sep=""), header=F))
    for (m in 1:length(axial2)) {
        assign(paste(axial2[m],"_",dat_type[i],sep=""), read.table(paste("project/",axial2[m], "_",dat_type[i], ".txt",sep=""), header=F))
    }
    for (n in 1:length(axial1)){
        for(j in 1:length(mes_type)) {
            for(k in 1:length(acc_type)) {
                if (j==2) {k=1}
                assign(paste(acc_type[k],"_",mes_type[j],"_",axial1[n],"_",dat_type[i],sep=""), read.table(paste("project/",acc_type[k],"_",mes_type[j],"_",axial1[n],"_",dat_type[i],".txt",sep=""), header=F))
            }
        }
    }
}


# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.