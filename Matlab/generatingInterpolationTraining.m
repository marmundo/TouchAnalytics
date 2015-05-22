function [inter_train]=generatingInterpolationTraining(trainingSet,client,saveFilePath,optionkey,keySize)
% trainingSet= training dataset will be protected
% user= original user of the training dataset
% saveFilePath=Path wich the training interpolation data will be save
% optionkey =
% 1: use the same key to all the users
% 2: use a different key to each user
% keysize= size of key. Maximum value is the number of features.

%starting variable
inter_train=[];
numFeatures=length(trainingSet(1,:));

if optionkey==1 || optionkey==3
    %% Heterogenous Know Key or Homogenous Know Key
    key=getFixedKey('Interpolation',numFeatures-1*keySize);
    % taking the user data based on size of keySize
    userData=trainingSet(:,1:round(numFeatures-1*keySize));
    inter_train=interpolation(userData(:,2:end),key);
elseif optionkey==2
    %% Heteronegeneous Unknown Key
    %% Different key for each user
    
    users=unique(trainingSet(:,1));
    keySize=round(numFeatures*keySize);
    for currentUser=1:length(users)
        % data of user i
        userData=trainingSet(find(trainingSet(:,1) == users(currentUser)),:);
        
        % taking the user data based on size of keySize
        userData=userData(:,1:keySize);
        
        % creating the key for the currentUser
        key=((keySize-1).*rand(keySize-1,1) + 1)';
        
        % protecting the user data using the generated key
        interpolationData=interpolation(userData(:,2:end),key);
        
        % adding user protected data to the bioH_train variable
        inter_train=[inter_train; interpolationData];
    end
elseif optionkey==4
    %% Homogenous UnKnow Key
    users=unique(trainingSet(:,1));
    keySize=round(numFeatures*keySize);
    
    clientKey=getFixedKey('Interpolation',keySize-1);
    
    % encoding genuine user with the system key
    clientData=trainingSet(find(trainingSet(:,1) == client),:);
    clientData=clientData(:,1:keySize);
    inter_train=interpolation(clientData(:,2:end),clientKey);
    
    for currentUser=1:length(users)
        if users(currentUser) ~= client
            % data of user i
            userData=trainingSet(find(trainingSet(:,1) == users(currentUser)),:);
            
            % taking the user data based on size of keySize
            userData=userData(:,1:keySize);
            
            % creating the key for the currentUser
            key=((keySize-1).*rand(keySize-1,1) + 1)';
            
            % protecting the user data using the generated key
            interpolationData=interpolation(userData(:,2:end),key);
            
            % adding user protected data to the bioH_train variable
            inter_train=[inter_train; interpolationData];
        end
    end
end

% adding the user label to the interpolation data
inter_train=[inter_train trainingSet(:,1)];

% discretizing protected dataset
[inter_train, trainUserLabels]=discretizeUser(client,length(inter_train(1,:)),inter_train);

%% Saving protected data

% If empty, create the variable
if(isempty(saveFilePath))
    saveFilePath=strcat(pwd(),'/Data/Horizontal/Interpolation/Same_Key/User_',client);
end

% If doesn't exist, create the Folder
if ~exist(saveFilePath,'dir')
    mkdir(saveFilePath);
end

trainingSet=inter_train;

%saving the training data
save(strcat(saveFilePath,'/trainingSet.mat'),'trainingSet','trainUserLabels');

end

