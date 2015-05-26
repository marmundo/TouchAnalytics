function [bioH_train]=generatingBioHashingTraining(trainingSet,client,saveFilePath,optionkey,keySize)
% trainingSet= training dataset will be protected
% client= original user of the training dataset
% saveFilePath=Path wich the training biohashing data will be save
% optionkey =
% 1: use the same key to all the users
% 2: use a different key to each user
% keysize= size of key. Maximum value is the number of features.

%starting variable
bioH_train=[];
numFeatures=length(trainingSet(1,:));
featureSize=round((numFeatures-1)*keySize);


if optionkey==1 || optionkey==3
    %% Heterogenous Know Key or Homogenous Know Key
    key=getFixedKey('BioHashing',featureSize);
    bioH_train=biohashing(trainingSet(:,2:featureSize+1),key);
    
elseif optionkey==2
    %% Heteronegeneous Unknown Key
    %% Different key for each user
    users=unique(trainingSet(:,1));
    
    for currentUser=1:length(users)
        % data of user i
        impostorData=trainingSet(find(trainingSet(:,1) == users(currentUser)),:);
        
        % taking the user data based on size of keySize
        impostorData=impostorData(:,1:round(numFeatures*keySize));
        
        % creating the key for the currentUser
        key=rand(featureSize);
        
        % protecting the user data using the generated key
        bioHashingData=biohashing(impostorData(:,2:end),key);
        
        % adding user protected data to the bioH_train variable
        bioH_train=[bioH_train; bioHashingData];
    end
elseif optionkey==4
    %% Homogenous UnKnow Key
    
    clientKey=getFixedKey('BioHashing',featureSize);
    
    % encoding genuine user with the system key
    clientData=trainingSet(find(trainingSet(:,1) == client),:);
    clientData=clientData(:,1:round(numFeatures*keySize));
    bioHashingClientData=biohashing(clientData(:,2:end),clientKey);
    
    bioH_train=bioHashingClientData;
    
    %% Different key for each impostor
    users=unique(trainingSet(:,1));
    
    for currentUser=1:length(users)
        if users(currentUser) ~= client
            % data of user i
            impostorData=trainingSet(find(trainingSet(:,1) == users(currentUser)),:);
            
            % taking the user data based on size of keySize
            impostorData=impostorData(:,1:round(numFeatures*keySize));
            
            % creating the key for the currentUser
            impostorKey=rand(featureSize);
            
            % protecting the user data using the generated key
            bioHashingImpostorData=biohashing(impostorData(:,2:end),impostorKey);
            
            % adding user protected data to the bioH_train variable
            bioH_train=[bioH_train; bioHashingImpostorData];
        end
    end
end

% adding the user label to the biohashing data
bioH_train=[bioH_train trainingSet(:,1)];

% discretizing protected dataset
[bioH_train, trainUserLabels]=discretizeUser(client,length(bioH_train(1,:)),bioH_train);

%% Saving protected data

% If empty, create the variable
if(isempty(saveFilePath))
    saveFilePath=strcat(pwd(),'/Data/Horizontal/BioHashing/Homo_Un_Key/User_',client);
end

% If doesn't exist, create the Folder
if ~exist(saveFilePath,'dir')
    mkdir(saveFilePath);
end

trainingSet=bioH_train;

%saving the training data
save(strcat(saveFilePath,'/trainingSet.mat'),'trainingSet','trainUserLabels');

end


