function [bioH_train]=generatingBioHashingTraining(trainingSet,user,saveFilePath,optionkey,keySize)
% trainingSet= training dataset will be protected
% user= original user of the training dataset
% saveFilePath=Path wich the training biohashing data will be save
% optionkey =
% 1: use the same key to all the users
% 2: use a different key to each user
% keysize= size of key. Maximum value is the number of features.

%starting variable
bioH_train=[];

if optionkey==1
    %% Same key for all users
    bioH_train=biohashing(trainingSet(:,2:end),'');
elseif optionkey==2
    %% Different key for each user
    numFeatures=length(trainingSet(1,:));
    users=unique(trainingSet(:,1));
    
    for currentUser=1:length(users)
        % data of user i
        userData=trainingSet(find(trainingSet(:,1) == users(currentUser)),:);
      
        % taking the user data based on size of keySize
        userData=userData(:,1:numFeatures*keySize);
       
        % creating the key for the currentUser
        key=rand(numFeatures-1*keySize);
       
        % protecting the user data using the generated key
        bioHashingData=biohashing(userData(:,2:end),key);
       
        % adding user protected data to the bioH_train variable
        bioH_train=[bioH_train; bioHashingData];
    end
end

% adding the user label to the biohashing data
bioH_train=[bioH_train trainingSet(:,1)];

% discretizing protected dataset
[bioH_train, trainUserLabels]=discretizeUser(str2num(user),length(bioH_train(1,:)),bioH_train);

%% Saving protected data

% If empty, create the variable
if(isempty(saveFilePath))
    saveFilePath=strcat(pwd(),'/Data/Horizontal/BioHashing/Same_Key/User_',user);
end

% If doesn't exist, create the Folder
if ~exist(saveFilePath,'dir')
    mkdir(saveFilePath);
end

%saving the training data
save(strcat(saveFilePath,'/trainingSet.mat'),'bioH_train','trainUserLabels');

end

    
