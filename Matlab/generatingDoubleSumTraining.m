function [ds_train]=generatingDoubleSumTraining(trainingSet,user,saveFilePath,optionkey,keySize)
% trainingSet= training dataset will be protected
% user= original user of the training dataset
% saveFilePath=Path wich the training doublesum data will be save
% optionkey =
% 1: use the same key to all the users
% 2: use a different key to each user
% keysize= size of key. Maximum value is the number of features.

%starting variable
ds_train=[];

%numFeatures
numFeatures=length(trainingSet(1,:))-1;

if optionkey==1
    %% Same key for all users
    key=1:2:numFeatures;
    key=[key,2:2:numFeatures];
    ds_train=doublesum(trainingSet(:,2:end),key);
elseif optionkey==2
    %% Different key for each user
    
    users=unique(trainingSet(:,1));
    
    for currentUser=1:length(users)
        % data of user i
        userData=trainingSet(find(trainingSet(:,1) == users(currentUser)),:);
      
        % taking the user data based on size of keySize
        userData=userData(:,1:numFeatures+1*keySize);
       
        
        % protecting the user data using the generated key
        doublesumData=doublesum(userData(:,2:end),'');
       
        % adding user protected data to the bioH_train variable
        ds_train=[ds_train; doublesumData];
    end
end

% adding the user label to the biohashing data
ds_train=[ds_train trainingSet(:,1)];

% discretizing protected dataset
[ds_train, trainUserLabels]=discretizeUser(str2num(user),length(ds_train(1,:)),ds_train);

%% Saving protected data

% If empty, create the variable
if(isempty(saveFilePath))
    saveFilePath=strcat(pwd(),'/Data/Horizontal/DoubleSum/Same_Key/User_',user);
end

% If doesn't exist, create the Folder
if ~exist(saveFilePath,'dir')
    mkdir(saveFilePath);
end

trainingSet=ds_train;

%saving the training data
save(strcat(saveFilePath,'/trainingSet.mat'),'trainingSet','trainUserLabels');

end

