##Coursera: "Getting and Cleaning Data" course project
# Hao Zhang @ 2015.10.13

##download the zip file if it hasn't been downloaded
if (!file.exists("project.zip")){
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","project.zip",method = "curl")
}
##unzip file if it hasn't been unziped
if (!dir.exists("project")){
    #flatten the dir tree for easier accessibility
    unzip("project.zip",exdir = "project/", junkpaths = T)
}

# 1. Merges the training and the test sets to create one data set.
X_train <- read.table(file = "project/X_train.txt",header = F)
X_test <- read.table(file = "project/X_test.txt",header = F)
X <- rbind(X_test,X_train)
rm("X_test","X_train")
# add colnames
feature <- read.table(file="project/features.txt",header=F)
feature <- feature[,2]
colnames(X) <- feature
# # assign variables, inialize values
# axial1 <- c("x","y","z")
# axial2  <- c("X","y")
# acc_type <- c("body","total")
# mes_type <- c("acc","gyro")
# dat_type <- c("train","test")
#
# #read activity and features
# act <- read.table("project/activity_labels.txt",header = F)
# feat <- read.table("project/features.txt",header = F)
#
# #read data tables, assign them to same-name objects
# for(i in 1:length(dat_type)) {
#     assign(paste("subject_",dat_type[i],sep=""), read.table(paste("project/subject_",dat_type[i], ".txt",sep=""), header=F))
#     for (m in 1:length(axial2)) {
#         assign(paste(axial2[m],"_",dat_type[i],sep=""), read.table(paste("project/",axial2[m], "_",dat_type[i], ".txt",sep=""), header=F))
#     }
#     for (n in 1:length(axial1)){
#         for(j in 1:length(mes_type)) {
#             for(k in 1:length(acc_type)) {
#                 if (j==2) {k=1}
#                 assign(paste(acc_type[k],"_",mes_type[j],"_",axial1[n],"_",dat_type[i],sep=""), read.table(paste("project/",acc_type[k],"_",mes_type[j],"_",axial1[n],"_",dat_type[i],".txt",sep=""), header=F))
#             }
#         }
#     }
# }


# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
sub <- subset(X,select=grepl("mean",names(X)))
sub2 <- subset(X,select=grepl("std",names(X)))
sub <- cbind(sub,sub2)
rm("sub2")
# 3. Uses descriptive activity names to name the activities in the data set
y_test <- read.table(file="project/y_test.txt",header = F)
y_train <- read.table(file="project/y_train.txt",header = F)
y  <- rbind(y_test,y_train)
rm("y_test","y_train")
act <- read.table("project/activity_labels.txt",header = F,col.names = c("activity","activity_name"))
y_act <- merge(x=y,y=act,by.x=1,by.y=1, all.x=TRUE)
xy <- cbind(sub,y_act[2])
rm(y_act)
# 4. Appropriately labels the data set with descriptive variable names.
xy_col <- colnames(xy)
gsub("t","time",xy_col)
gsub("f","frequency",xy_col)
gsub("Acc","Acceleration", xy_col)
gsub("gryo","", xy_col)
gsub("mag","magnitude", xy_col)
gsub("-mean()","Mean",xy_col)
gsub("-std()","StandardDeviation",xy_col)
gsub("-X","Xaxis",xy_col)
gsub("-Y","Yaxis",xy_col)
gsub("-Z","Zaxis",xy_col)
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.