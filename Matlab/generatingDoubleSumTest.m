function [ds_test]=generatingDoubleSumTest(testSet,client,saveFilePath,optionkey,keySize)
% testSet= test dataset used in data protection
% client= user label of testSet
% saveFilePath= Full Path where the doublesum test set will be saved
% optionkey =
% 1: use the same key to all the users
% 2: use a different key to each user
% keySize= size of key. maximum is 1

ds_test=[];

%number of features
numFeatures=length(testSet(1,:))-1;

%% Heterogenous Know Key
if optionkey==1
    
elseif optionkey==2
    %% Heteronegeneous Unknown Key
    %% Different key for each user
    
    keySize=round(numFeatures*keySize);
    users=unique(testSet(:,1));
    
    for currentUser=1:length(users)
        % data of user i
        userData=testSet(find(testSet(:,1) == users(currentUser)),:);
        
        % taking the user data based on size of keySize
        
        key=round(sort((keySize-1).*rand(keySize,1) + 1))';
        
        % protecting the user data using the generated key
        doublesumData=doublesum(userData(:,2:end),key);
        
        % adding user protected data to the bioH_train variable
        ds_test=[ds_test; doublesumData];
    end
elseif optionkey==3
    %% Homogenous Know Key
    %% Same key for all users
    key=getFixedKey('DoubleSum',numFeatures*keySize);
    ds_test=doublesum(testSet(:,2:end),key);
elseif optionkey==4
    %% Homogenous UnKnow Key
    
    keySize=round(numFeatures*keySize);
    users=unique(testSet(:,1));
    
    clientKey=getFixedKey('DoubleSum',keySize);
    
    % encoding genuine user with the system key
    clientData=testSet(find(testSet(:,1) == client),:);
    ds_test=doublesum(clientData(:,2:end),clientKey);
    
    for currentUser=1:length(users)
        if users(currentUser) ~= client
            % data of user i
            userData=testSet(find(testSet(:,1) == users(currentUser)),:);
            
            % taking the user data based on size of keySize
            
            key=round(sort((keySize-1).*rand(keySize,1) + 1))';
            
            % protecting the user data using the generated key
            doublesumData=doublesum(userData(:,2:end),key);
            
            % adding user protected data to the bioH_train variable
            ds_test=[ds_test; doublesumData];
        end
    end
end
% Adding the user label to the doublesum data
ds_test=[ds_test testSet(:,1)];

% Discretizing the user. 1, for user, and 0 for remaining users
[ds_test,testUserLabels]=discretizeUser(client,length(ds_test(1,:)),ds_test);

%% Folder used to save the doublesum data
% If empty create the variable
if(isempty(saveFilePath))
    saveFilePath=strcat(pwd(),'/Data/Horizontal/DoubleSum/Same_Key/User_',client);
end
% If the folder doesn't exist create it
if ~exist(saveFilePath,'dir')
    mkdir(saveFilePath);
end

testSet=ds_test;

%% Saving the testing data
save(strcat(saveFilePath,'/testSet.mat'),'testSet','testUserLabels');


end
