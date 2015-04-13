function [ds_test]=generatingDoubleSumTest(testSet,user,saveFilePath,optionkey,keySize)
% testSet= test dataset used in data protection
% user= user label of testSet
% saveFilePath= Full Path where the doublesum test set will be saved
% optionkey =
% 1: use the same key to all the users
% 2: use a different key to each user
% keySize= size of key. maximum is 1

ds_test=[];

%number of features
numFeatures=length(testSet(1,:))-1;

%% Same key for all users
if optionkey==1
    key=1:2:numFeatures;
    key=[key,2:2:numFeatures];
    ds_test=doublesum(testSet(:,2:end),key);
elseif optionkey==2
    %% Different Keys for each user
    
    users=unique(testSet(:,1));
    for currentUser=1:length(users)
        % user data presented in testSet
        userData=testSet(find(testSet(:,1) == users(currentUser)),:);
        
        % user data based on the size of keySize
        userData=userData(:,1:numFeatures+1*keySize);
        
                
        % Protecting the User data
        doublesumData=doublesum(userData(:,2:end),'');
        
        % Adding the doublesumData to the Protected doublesum test
        % dataset
        ds_test=[ds_test; doublesumData];
    end
end

% Adding the user label to the doublesum data
ds_test=[ds_test testSet(:,1)];

% Discretizing the user. 1, for user, and 0 for remaining users
[ds_test,testUserLabels]=discretizeUser(str2num(user),length(ds_test(1,:)),ds_test);

%% Folder used to save the doublesum data
% If empty create the variable
if(isempty(saveFilePath))
    saveFilePath=strcat(pwd(),'/Data/Horizontal/DoubleSum/Same_Key/User_',user);
end
% If the folder doesn't exist create it
if ~exist(saveFilePath,'dir')
    mkdir(saveFilePath);
end

testSet=ds_test;

%% Saving the testing data
save(strcat(saveFilePath,'/testSet.mat'),'testSet','testUserLabels');


end
