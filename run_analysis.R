## Coursera/Johns Hopkins Getting & Cleaning Data course project

library(dplyr)
library(reshape2)

## 1. Merge the training and the test sets to create one data set.

# Read the features file to create a names vector
features<-read.table("features.txt")
featurenames<-as.vector(features[,2])

# read in the test & training data
testsub<-read.table("subject_test.txt",col.names=c("Subject"))   
trainsub<-read.table("subject_train.txt",,col.names=c("Subject"))
testy<-read.table("y_test.txt",col.names=c("Activity"))
trainy<-read.table("y_train.txt",col.names=c("Activity"))
testx<-read.table("X_test.txt",col.names=featurenames)
trainx<-read.table("X_train.txt",col.names=featurenames)

# combine the tables
test<-cbind(testsub,testy,testx)
train<-cbind(trainsub,trainy,trainx)
df<-rbind(test,train)

# remove the intermediate dataframes
rm("features")
rm("test")
rm("testx")
rm("testy")
rm("testsub")
rm("train")
rm("trainx")
rm("trainy")
rm("trainsub")

## 2. Extract only the measurements on the mean and standard deviation for each 
##    measurement. 

df<-select(df,Subject,Activity,contains(".mean."),contains(".std."))

## 3. Use descriptive activity names to name the activities in the data set

activities<-c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING",
              "STANDING","LAYING")

df<-mutate(df,Activity=activities[Activity])

## 4. Appropriately label the data set with descriptive variable names. 

# Read in EditedNames.txt, which has been created by writing names(df) to a .txt
# file and then tidying up the names outside of R in a text editor

editednames<-read.table("EditedNames.txt")
enames<-editednames[,1]
rm("editednames")

# apply the edited names to our dataframe

names(df)<-enames

## 5. From the data set in step 4, create a second, independent tidy data set tes56t
##    with the average of each variable for each activity and each subject.

tes56t<-melt(df,id=c("Subject","Activity"))
tes56t<-group_by(tes56t,Subject,Activity)
tes56t<-summarise_each(tes56t,funs(mean),-variable,Mean=value)