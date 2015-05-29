function [bioC_train]=generatingBioConvolvingTraining(trainingSet,client,saveFilePath,optionkey,keySize)
% trainingSet= training dataset will be protected
% client= original user of the training dataset
% saveFilePath=Path wich the training biohashing data will be save
% optionkey =
% 1: use the same key to all the users
% 2: use a different key to each user
% keysize= size of key. Maximum value is the number of features.

%starting variable
bioC_train=[];
numFeatures=length(trainingSet(1,2:end));
sizeFeatures=round(numFeatures*keySize);

if optionkey==1 || optionkey==3
    %% Heterogenous Know Key or Homogenous Know Key
    key=getFixedKey('BioConvolving',sizeFeatures);
    bioC_train=bioconvolving(trainingSet(:,2:sizeFeatures+1),key);
elseif optionkey==2
    %% Heteronegeneous Unknown Key
    %% Different key for each user
    
    users=unique(trainingSet(:,1));
    
    for currentUser=1:length(users)
        % data of user i
        userData=trainingSet(find(trainingSet(:,1) == users(currentUser)),:);
        
        % creating the key for the currentUser
        % 2 is the standard size of bioconvolving
        key=generateBioConvolvingKey(2,numFeatures);
        
        %This is was implemented because some times the key has this
        %behavior [0,31,31]. Thus, the protected data is the same the
        %original one. So, I decided to cut the sample to fit the other
        %protected one.
        for i=1:length(key)-1
            if key(i+1)-key(i)==numFeatures
                key=generateBioConvolvingKey(2,numFeatures);
                break
            end
        end
        
        % protecting the user data using the generated key
        bioConvolvingImpostorData=bioconvolving(userData(:,2:sizeFeatures+1),key);
        
        % adding user protected data to the bioH_train variable
        bioC_train=[bioC_train; bioConvolvingImpostorData];
    end

elseif optionkey==4
    %% Homogenous UnKnow Key
    users=unique(trainingSet(:,1));
    clientKey=getFixedKey('BioConvolving',sizeFeatures);
    
    % encoding genuine user with the system key
    clientData=trainingSet(find(trainingSet(:,1) == client),:);
    % protecting the user data using the generated key
    bioConvolvingClientData=bioconvolving(clientData(:,2:end),clientKey);
    
    % adding user protected data to the bioH_train variable
    bioC_train=bioConvolvingClientData;
    
    for currentUser=1:length(users)
        if users(currentUser) ~= client
            % data of user i
            userData=trainingSet(find(trainingSet(:,1) == users(currentUser)),:);
            
            % creating the key for the currentUser
            % 2 is the standard size of bioconvolving
            impostorKey=generateBioConvolvingKey(2,numFeatures);
            
            %This is was implemented because some times the key has this
            %behavior [0,31,31]. Thus, the protected data is the same the
            %original one. So, I decided to cut the sample to fit the other
            %protected one.
            for i=1:length(impostorKey)-1
                if impostorKey(i+1)-impostorKey(i)==numFeatures
                    impostorKey=generateBioConvolvingKey(2,numFeatures);
                    break
                end
            end
            
            % protecting the user data using the generated key
            bioConvolvingImpostorData=bioconvolving(userData(:,2:end),impostorKey);
            
            % adding user protected data to the bioH_train variable
            if length(bioC_train(1,:))~=length(bioConvolvingImpostorData(1,:))
                disp('OK');
            end
            bioC_train=[bioC_train; bioConvolvingImpostorData];
        end
    end
end

% adding the user label to the biohashing data
bioC_train=[bioC_train trainingSet(:,1)];

% discretizing protected dataset
[bioC_train, trainUserLabels]=discretizeUser(client,length(bioC_train(1,:)),bioC_train);

%% Saving protected data

% If empty, create the variable
if(isempty(saveFilePath))
    saveFilePath=strcat(pwd(),'/Data/Horizontal/BioConvolving/Same_Key/User_',client);
end

% If doesn't exist, create the Folder
if ~exist(saveFilePath,'dir')
    mkdir(saveFilePath);
end

trainingSet=bioC_train;

%saving the training data
save(strcat(saveFilePath,'/trainingSet.mat'),'trainingSet','trainUserLabels');

end


