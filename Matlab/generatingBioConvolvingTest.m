function [bioC_test]=generatingBioConvolvingTest(testSet,client,saveFilePath,optionkey,keySize)
% testSet= test dataset used in data protection
% client= user label of testSet
% saveFilePath= Full Path where the biohashing test set will be saved
% optionkey =
% 1: use the same key to all the users
% 2: use a different key to each user
% keySize= size of key. maximum is 1

bioC_test=[];
numFeatures=length(testSet(1,2:end));
sizeFeatures=round(numFeatures*keySize);
%% Same key for all users
if optionkey==1 || optionkey==3
    %% Heterogenous Know Key or Homogenous Know Key
    key=getFixedKey('BioConvolving',sizeFeatures);
    bioC_test=bioconvolving(testSet(:,2:sizeFeatures+1),key);
elseif optionkey==2
    %% Heteronegeneous Unknown Key
    %% Different key for each user
    
    users=unique(testSet(:,1));
    for currentUser=1:length(users)
        % user data presented in testSet
        userData=testSet(find(testSet(:,1) == users(currentUser)),:);
        
        
        % creating the key for the currentUser
        % 2 is the standard size of bioconvolving
        % TODO: In future analysis the performance changing the size of key
        key=generateBioConvolvingKey(2,numFeatures);
        %This is was implemented because some times the key has this
        %behavior [0,31,31]. Thus, the protected data is the same the
        %original one. So, I decided to cut the sample to fit the other
        %protected one.
        for i=1:length(key)-1
            if key(i+1)-key(i)==numFeatures
                key=generateBioConvolvingKey(2,numFeatures);
                break;
            end
        end
        
        % Protecting the User data
        bioConvolvingData=bioconvolving(userData(:,2:sizeFeatures+1),key);
        
        % Adding the biohashingData to the Protected BioHashing test
        % dataset
        bioC_test=[bioC_test; bioConvolvingData];
    end
elseif optionkey==4
    %% Homogenous UnKnow Key
    users=unique(testSet(:,1));
    clientKey=getFixedKey('BioConvolving',sizeFeatures);
    
    % encoding genuine user with the system key
    clientData=testSet(find(testSet(:,1) == client),:);
    % protecting the user data using the generated key
    bioConvolvingClientData=bioconvolving(clientData(:,2:end),clientKey);
    
    % adding user protected data to the bioH_train variable
    bioC_test=bioConvolvingClientData;
    
    for currentUser=1:length(users)
        if users(currentUser) ~= client
            % data of user i
            userData=testSet(find(testSet(:,1) == users(currentUser)),:);
            
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
            if length(bioC_test(1,:))~=length(bioConvolvingImpostorData(1,:))
                disp('OK');
            end
            bioC_test=[bioC_test; bioConvolvingImpostorData];
        end
    end
end
% Adding the user label to the biohashing data
bioC_test=[bioC_test testSet(:,1)];

% Discretizing the user. 1, for user, and 0 for remaining users
[bioC_test,testUserLabels]=discretizeUser(client,length(bioC_test(1,:)),bioC_test);

%% Folder used to save the biohashing data
% If empty create the variable
if(isempty(saveFilePath))
    saveFilePath=strcat(pwd(),'/Data/Horizontal/BioConvolving/Same_Key/User_',client);
end
% If the folder doesn't exist create it
if ~exist(saveFilePath,'dir')
    mkdir(saveFilePath);
end

testSet=bioC_test;

%% Saving the testing data
save(strcat(saveFilePath,'/testSet.mat'),'testSet','testUserLabels');

end