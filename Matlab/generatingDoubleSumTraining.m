function [ds_train]=generatingDoubleSumTraining(trainingSet,client,saveFilePath,optionkey,keySize)
% trainingSet= training dataset will be protected
% client= original user of the training dataset
% saveFilePath=Path wich the training doublesum data will be save
% optionkey =
% 1: use the same key to all the users
% 2: use a different key to each user
% keysize= size of key. Maximum value is the number of features.

%starting variable
ds_train=[];

%numFeatures
numFeatures=length(trainingSet(1,:))-1;

%% Heterogenous Know Key
if optionkey==1
    
elseif optionkey==2
    %% Heteronegeneous Unknown Key
    %% Different key for each user
    
    keySize=round(numFeatures*keySize);
    users=unique(trainingSet(:,1));
    
    for currentUser=1:length(users)
        % data of user i
        userData=trainingSet(find(trainingSet(:,1) == users(currentUser)),:);
        
        % taking the user data based on size of keySize
        
        key=round(sort((keySize-1).*rand(keySize,1) + 1))';
        
        % protecting the user data using the generated key
        doublesumData=doublesum(userData(:,2:end),key);
        
        % adding user protected data to the bioH_train variable
        ds_train=[ds_train; doublesumData];
    end
elseif optionkey==3
    %% Homogenous Know Key
    %% Same key for all users
    key=getFixedKey('DoubleSum',numFeatures*keySize);
    ds_train=doublesum(trainingSet(:,2:end),key);
elseif optionkey==4
    %% Homogenous UnKnow Key
    
    keySize=round(numFeatures*keySize);
    users=unique(trainingSet(:,1));
    
    clientKey=getFixedKey('DoubleSum',keySize);
    
    % encoding genuine user with the system key
    clientData=trainingSet(find(trainingSet(:,1) == client),:);
    ds_train=doublesum(clientData(:,2:end),clientKey);
    
    for currentUser=1:length(users)
        if users(currentUser) ~= client
            % data of user i
            userData=trainingSet(find(trainingSet(:,1) == users(currentUser)),:);
            
            % taking the user data based on size of keySize
            
            key=round(sort((keySize-1).*rand(keySize,1) + 1))';
            
            % protecting the user data using the generated key
            doublesumData=doublesum(userData(:,2:end),key);
            
            % adding user protected data to the bioH_train variable
            ds_train=[ds_train; doublesumData];
        end
    end
end

% adding the user label to the biohashing data
ds_train=[ds_train trainingSet(:,1)];

% discretizing protected dataset
[ds_train, trainUserLabels]=discretizeUser(client,length(ds_train(1,:)),ds_train);

%% Saving protected data

% If empty, create the variable
if(isempty(saveFilePath))
    saveFilePath=strcat(pwd(),'/Data/Horizontal/DoubleSum/Same_Key/User_',client);
end

% If doesn't exist, create the Folder
if ~exist(saveFilePath,'dir')
    mkdir(saveFilePath);
end

trainingSet=ds_train;

%saving the training data
save(strcat(saveFilePath,'/trainingSet.mat'),'trainingSet','trainUserLabels');

end

