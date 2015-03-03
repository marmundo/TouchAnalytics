#Code to load score data for client and impostor. Plot both as a density function

#read client score file ans save as a data.frame
client<-read.csv("KNN_Original_Client_ScoreMatrix_User_1.txt",header=FALSE)
clientFrame<-data.frame(as.numeric(as.vector(client[1,])))

#read impostor score file ans save as a data.frame
impostor<-read.csv("KNN_Original_Impostor_ScoreMatrix_User_1.txt",header=FALSE)
impostorFrame<-data.frame(as.numeric(as.vector(impostor[1,])))

#add columns with name=user and content "client" and "impostor" to them
clientFrame$user <- 'client'
impostorFrame$user <- 'impostor'

#rename the client and impostor data.frames to col
col<-c("score","user")
colnames(clientFrame)<-col
colnames(impostorFrame)<-col

#create a unique data.frame with client and impostor data.frames
userScore <- rbind(clientFrame, impostorFrame)

#load ggplot library. Library used to plot the density plot
library("ggplot2")

#plot density function
ggplot(userScore, aes(score, fill = user)) + geom_density(alpha = 0.2)


