function [inter_train]=generatingInterpolationTraining(trainingSet,user,saveFilePath,optionkey,keySize)
% trainingSet= training dataset will be protected
% user= original user of the training dataset
% saveFilePath=Path wich the training interpolation data will be save
% optionkey =
% 1: use the same key to all the users
% 2: use a different key to each user
% keysize= size of key. Maximum value is the number of features.

%starting variable
inter_train=[];

if optionkey==1
    %% Same key for all users
    key=[0.4942,0.2983,0.0715,0.9300,0.0240,0.1573,0.7370,0.2256,0.0763,0.0340,0.7855,0.1756,0.4953,0.4808,0.8389,0.9203,0.8051,0.3003,0.2362,0.1367,0.9224,0.4827,0.6794,0.1586,0.7258,0.2506,0.3365,0.5947,0.0483,0.6553,0.5235]';
    inter_train=interpolation(trainingSet(:,2:end),key);
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
        key=rand(numFeatures-1*keySize,1);
       
        % protecting the user data using the generated key
        interpolationData=interpolation(userData(:,2:end),key);
       
        % adding user protected data to the bioH_train variable
        inter_train=[inter_train; interpolationData];
    end
end

% adding the user label to the interpolation data
inter_train=[inter_train trainingSet(:,1)];

% discretizing protected dataset
[inter_train, trainUserLabels]=discretizeUser(str2num(user),length(inter_train(1,:)),inter_train);

%% Saving protected data

% If empty, create the variable
if(isempty(saveFilePath))
    saveFilePath=strcat(pwd(),'/Data/Horizontal/Interpolation/Same_Key/User_',user);
end

% If doesn't exist, create the Folder
if ~exist(saveFilePath,'dir')
    mkdir(saveFilePath);
end

trainingSet=inter_train;

%saving the training data
save(strcat(saveFilePath,'/trainingSet.mat'),'trainingSet','trainUserLabels');

end

