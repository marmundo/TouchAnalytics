function [inter_test]=generatingInterpolationTest(testSet,client,saveFilePath,optionkey,keySize)
% testSet= test dataset used in data protection
% client= user label of testSet
% saveFilePath= Full Path where the interpolation test set will be saved
% optionkey =
% 1: use the same key to all the users
% 2: use a different key to each user
% keySize= size of key. maximum is 1

inter_test=[];
numFeatures=length(testSet(1,:));

if optionkey==1 || optionkey==3
    %% Homogenous Know Key or Heterogenous Know Key
    key=getFixedKey('Interpolation',numFeatures-1*keySize);
    % taking the user data based on size of keySize
    userData=testSet(:,1:round(numFeatures-1*keySize));
    inter_test=interpolation(userData(:,2:end),key);
elseif optionkey==2
    %% Heteronegeneous Unknown Key
    %% Different key for each user
    keySize=numFeatures*keySize;
    users=unique(testSet(:,1));
    for currentUser=1:length(users)
        % user data presented in testSet
        userData=testSet(find(testSet(:,1) == users(currentUser)),:);
        
        % user data based on the size of keySize
        userData=userData(:,1:keySize);
        
        % Generating a key to that user
        key=((keySize-1).*rand(keySize-1,1) + 1)';
        
        % Protecting the User data
        interpolationData=interpolation(userData(:,2:end),key);
        
        % Adding the interpolationData to the Protected interpolation test
        % dataset
        inter_test=[inter_test; interpolationData];
    end
elseif optionkey==4
    %% Homogenous UnKnow Key
    users=unique(testSet(:,1));
    keySize=round(numFeatures*keySize);
    
    clientKey=getFixedKey('Interpolation',keySize-1);
    
    % encoding genuine user with the system key
    clientData=testSet(find(testSet(:,1) == client),:);
    clientData=clientData(:,1:keySize);
    inter_test=interpolation(clientData(:,2:end),clientKey);
    
   
    for currentUser=1:length(users)
        if users(currentUser) ~= client
            % data of user i
            userData=testSet(find(testSet(:,1) == users(currentUser)),:);
            
            % taking the user data based on size of keySize
            userData=userData(:,1:keySize);
            
            % creating the key for the currentUser
            key=((keySize-1).*rand(keySize-1,1) + 1)';
            
            % protecting the user data using the generated key
            interpolationData=interpolation(userData(:,2:end),key);
            
            % adding user protected data to the bioH_train variable
            inter_test=[inter_test; interpolationData];
        end
    end
end

% Adding the user label to the interpolation data
inter_test=[inter_test testSet(:,1)];

% Discretizing the user. 1, for user, and 0 for remaining users
[inter_test,testUserLabels]=discretizeUser(client,length(inter_test(1,:)),inter_test);

%% Folder used to save the interpolation data
% If empty create the variable
if(isempty(saveFilePath))
    saveFilePath=strcat(pwd(),'/Data/Horizontal/Interpolation/Same_Key/User_',client);
end
% If the folder doesn't exist create it
if ~exist(saveFilePath,'dir')
    mkdir(saveFilePath);
end

testSet=inter_test;

%% Saving the testing data
save(strcat(saveFilePath,'/testSet.mat'),'testSet','testUserLabels');


end
