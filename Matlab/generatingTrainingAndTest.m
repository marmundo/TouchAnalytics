%%
%% Generating training
%%
function [trainingSet,testSet] = generatingTrainingAndTest(data,user,filePath,option)
%option = 
% 0: Generating Unprotected data with origianl user label
% 1: Generating Unprotected data with user label= 1 (client) or 0(impostor)
if(isempty(filePath))
    filePath='/home/marcelo/Dropbox/Surrey/Norman/Data/Horizontal/Original/';
end
userFolder=strcat('User_',num2str(user));
filePath=strcat(filePath,userFolder);
trainingSet= [];
testSet=[];

count=length(unique(data(:,1)))/2+1;
users=unique(data(:,1));
currentUser=user;
maxSize=length(users)+1;
%% Creating training file
    for i=1:count       
        if currentUser==maxSize
            currentUser=1;
        end
        userLines=find(data(:,1)==currentUser);
        trainingSet=[trainingSet;data(userLines,:)];
        currentUser=currentUser+1;
    end
    
    if option==1
        trainingSet=discretizeUser(user,1,trainingSet);        
    end
    %% Creating testset File
    
   % currentUser=count+1;
    size=users(length(users));
    
    for i=count+1:size
        if currentUser==size+1
            currentUser=1;
        end
        testSet=[testSet;data(find(data(:,1)==currentUser),:)];
        currentUser=currentUser+1;
    end
    
    if option==1
        %% Changing the label of the testSet users to impostor
        testSet(:,1)=0;
        testSet=discretizeUser(user,1,testSet);
    end
    
    %% Saving training
    if ~exist(filePath,'dir')
        mkdir(filePath);
    save(strcat(filePath,'/trainingSet.mat'),'trainingSet');
    
    %% Saving testing
    save(strcat(filePath,'/testSet.mat'),'testSet');
end
