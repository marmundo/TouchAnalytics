function [trainingSet,testSet] = generatingTrainingAndTest(data,user,filePath,option)
%data= biometric data
%user= user used to create the training set. case option==1, the user label
%will be 1, because he will be the original user, the remaining users will
%be 0, because will be the impostors
%option =
% 0: Generating Unprotected data with origianl user label
% 1: Generating Unprotected data with user label= 1 (client) or 0(impostor)

%checking with the filePath is empty
if(isempty(filePath))
    filePath=strcat(pwd(),'/Data/Horizontal/Original/');
end

%creating a user label
userFolder=strcat('User_',num2str(user));

%adding the userLabel to the FilePath
filePath=strcat(filePath,userFolder);

%starting trainingSet variable
trainingSet= [];

%starting testSet variable
testSet=[];

%users data used to create the training data
%ex: from 41 users, 21 will be used to create the training data
training_users=round(length(unique(data(:,1)))/2);

%list of users
users=unique(data(:,1));

%current user used in process to create the training data
currentUser=user;

%number of users +1
maxSize=length(users)+1;

%% Creating training file
for i=1:training_users
    if currentUser==maxSize
        currentUser=1;
    end
    
    %biometric samples from the current user
    userSamples=find(data(:,1)==currentUser);
    
    %adding user samples to trainingSet variable
    trainingSet=[trainingSet;data(userSamples,:)];
    
    %updating the current user
    currentUser=currentUser+1;
end

if option==1
    %discretize the user to 1, and the remaining users to 0
    [trainingSet, trainUserLabels]=discretizeUser(user,1,trainingSet);
    trainingSet(:,1)=[];
end

%% Creating testset File
size=length(users);

for i=training_users+1:size
    if currentUser==size+1
        currentUser=1;
    end
    %adding to testSet the userSamples
    testSet=[testSet;data(find(data(:,1)==currentUser),:)];
    
    %updating current User
    currentUser=currentUser+1;
end

if option==1
    %%Changing the label of the testSet users to impostor
    testSet(:,1)=0;
    [testSet,testUserLabels]=discretizeUser(user,1,testSet);
    testSet(:,1)=[];
end

%% Saving training
if ~exist(filePath,'dir')
    mkdir(filePath);
end

if option==1
    save(strcat(filePath,'/trainingSet.mat'),'trainingSet','trainUserLabels');
else
    save(strcat(filePath,'/trainingSet.mat'),'trainingSet');
end

%% Saving testing
if option==1
    save(strcat(filePath,'/testSet.mat'),'testSet','testUserLabels');
else
    save(strcat(filePath,'/testSet.mat'),'testSet');
end

end
