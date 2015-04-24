function [bioH_test]=generatingBioHashingTest(testSet,user,saveFilePath,optionkey,keySize)
% testSet= test dataset used in data protection
% user= user label of testSet
% saveFilePath= Full Path where the biohashing test set will be saved
% optionkey =
% 1: use the same key to all the users
% 2: use a different key to each user
% keySize= size of key. maximum is 1

bioH_test=[];
numFeatures=length(testSet(1,:));
%% Same key for all users
if optionkey==1
    key=getFixedKey('BioHashing',(numFeatures-1)*keySize);
    bioH_test=biohashing(testSet(:,2:end),key);
elseif optionkey==2
    %% Different Keys for each user
   
    users=unique(testSet(:,1));
    for currentUser=1:length(users)
        % user data presented in testSet
        userData=testSet(find(testSet(:,1) == users(currentUser)),:);
        
        % user data based on the size of keySize
        userData=userData(:,1:numFeatures*keySize);
        
        % Generating a key to that user
        key=rand(numFeatures-1*keySize);
        
        % Protecting the User data
        bioHashingData=biohashing(userData(:,2:end),key);
        
        % Adding the biohashingData to the Protected BioHashing test
        % dataset
        bioH_test=[bioH_test; bioHashingData];
    end
end

% Adding the user label to the biohashing data
bioH_test=[bioH_test testSet(:,1)];

% Discretizing the user. 1, for user, and 0 for remaining users
[bioH_test,testUserLabels]=discretizeUser(str2num(user),length(bioH_test(1,:)),bioH_test);


%% Folder used to save the biohashing data
% If empty create the variable
if(isempty(saveFilePath))
    saveFilePath=strcat(pwd(),'/Data/Horizontal/BioHashing/Same_Key/User_',user);
end
% If the folder doesn't exist create it
if ~exist(saveFilePath,'dir')
    mkdir(saveFilePath);
end

testSet=bioH_test;

%% Saving the testing data
save(strcat(saveFilePath,'/testSet.mat'),'testSet','testUserLabels');

end
