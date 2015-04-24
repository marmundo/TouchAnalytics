function [inter_test]=generatingInterpolationTest(testSet,user,saveFilePath,optionkey,keySize)
% testSet= test dataset used in data protection
% user= user label of testSet
% saveFilePath= Full Path where the interpolation test set will be saved
% optionkey =
% 1: use the same key to all the users
% 2: use a different key to each user
% keySize= size of key. maximum is 1

inter_test=[];
numFeatures=length(testSet(1,:));
%% Same key for all users
if optionkey==1
   key=getFixedKey('Interpolation',numFeatures);
    inter_test=interpolation(testSet(:,2:end),key);
elseif optionkey==2
    %% Different Keys for each user
   
    users=unique(testSet(:,1));
    for currentUser=1:length(users)
        % user data presented in testSet
        userData=testSet(find(testSet(:,1) == users(currentUser)),:);
        
        % user data based on the size of keySize
        userData=userData(:,1:numFeatures*keySize);
        
        % Generating a key to that user
        key=rand(numFeatures-1*keySize,1);
        
        % Protecting the User data
        interpolationData=interpolation(userData(:,2:end),key);
        
        % Adding the interpolationData to the Protected interpolation test
        % dataset
        inter_test=[inter_test; interpolationData];
    end
end

% Adding the user label to the interpolation data
inter_test=[inter_test testSet(:,1)];

% Discretizing the user. 1, for user, and 0 for remaining users
[inter_test,testUserLabels]=discretizeUser(str2num(user),length(inter_test(1,:)),inter_test);

%% Folder used to save the interpolation data
% If empty create the variable
if(isempty(saveFilePath))
    saveFilePath=strcat(pwd(),'/Data/Horizontal/Interpolation/Same_Key/User_',user);
end
% If the folder doesn't exist create it
if ~exist(saveFilePath,'dir')
    mkdir(saveFilePath);
end

testSet=inter_test;

%% Saving the testing data
save(strcat(saveFilePath,'/testSet.mat'),'testSet','testUserLabels');


end
