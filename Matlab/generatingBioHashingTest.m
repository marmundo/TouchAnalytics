function [bioH_test]=generatingBioHashingTest(testSet,client,saveFilePath,optionkey,keySize)
% testSet= test dataset used in data protection
% user= user label of testSet
% saveFilePath= Full Path where the biohashing test set will be saved
% optionkey =
% 1: use the same key to all the users
% 2: use a different key to each user
% keySize= size of key. maximum is 1

bioH_test=[];
numFeatures=length(testSet(1,:));
featureSize=round((numFeatures-1)*keySize);

if optionkey==1 || optionkey==3
    %% Heterogenous Know Key or Homogenous Know Key
    key=getFixedKey('BioHashing',featureSize);
    bioH_test=biohashing(testSet(:,2:featureSize+1),key);
   
elseif optionkey==2
    %% Heteronegeneous Unknown Key
    % Different Keys for each user
    
    users=unique(testSet(:,1));
    for currentUser=1:length(users)
        % user data presented in testSet
        userData=testSet(find(testSet(:,1) == users(currentUser)),:);
        
        % user data based on the size of keySize
        userData=userData(:,1:round(numFeatures*keySize));
        
        % Generating a key to that user
        key=rand(featureSize);
        
        % Protecting the User data
        bioHashingData=biohashing(userData(:,2:end),key);
        
        % Adding the biohashingData to the Protected BioHashing test
        % dataset
        bioH_test=[bioH_test; bioHashingData];
    end
elseif optionkey==4
    %% Homogenous UnKnow Key
    
    clientKey=getFixedKey('BioHashing',featureSize);
    
    % encoding genuine user with the system key
    clientData=testSet(find(testSet(:,1) == client),:);
    clientData=clientData(:,1:round(numFeatures*keySize));
    bioHashingClientData=biohashing(clientData(:,2:end),clientKey);
    
    bioH_test=bioHashingClientData;
    
    %% Different key for each impostor
    users=unique(testSet(:,1));
    
    for currentUser=1:length(users)
        if users(currentUser) ~= client
            % data of user i
            impostorData=testSet(find(testSet(:,1) == users(currentUser)),:);
            
            % taking the user data based on size of keySize
            impostorData=impostorData(:,1:round(numFeatures*keySize));
            
            % creating the key for the currentUser
            impostorKey=rand(featureSize);
            
            % protecting the user data using the generated key
            bioHashingImpostorData=biohashing(impostorData(:,2:end),impostorKey);
            
            % adding user protected data to the bioH_train variable
            bioH_test=[bioH_test; bioHashingImpostorData];
        end
    end
end

% Adding the user label to the biohashing data
bioH_test=[bioH_test testSet(:,1)];

% Discretizing the user. 1, for user, and 0 for remaining users
[bioH_test,testUserLabels]=discretizeUser(client,length(bioH_test(1,:)),bioH_test);


%% Folder used to save the biohashing data
% If empty create the variable
if(isempty(saveFilePath))
    saveFilePath=strcat(pwd(),'/Data/Horizontal/BioHashing/Homo_Un_Key/User_',client);
end
% If the folder doesn't exist create it
if ~exist(saveFilePath,'dir')
    mkdir(saveFilePath);
end

testSet=bioH_test;

%% Saving the testing data
save(strcat(saveFilePath,'/testSet.mat'),'testSet','testUserLabels');

end
