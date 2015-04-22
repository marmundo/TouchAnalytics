function [inter_test]=generatingInterpolationTest(testSet,user,saveFilePath,optionkey,keySize)
% testSet= test dataset used in data protection
% user= user label of testSet
% saveFilePath= Full Path where the interpolation test set will be saved
% optionkey =
% 1: use the same key to all the users
% 2: use a different key to each user
% keySize= size of key. maximum is 1

inter_test=[];

%% Same key for all users
if optionkey==1
   key=[0.4942,0.2983,0.0715,0.9300,0.0240,0.1573,0.7370,0.2256,0.0763,0.0340,0.7855,0.1756,0.4953,0.4808,0.8389,0.9203,0.8051,0.3003,0.2362,0.1367,0.9224,0.4827,0.6794,0.1586,0.7258,0.2506,0.3365,0.5947,0.0483,0.6553,0.5235]';
    inter_test=interpolation(testSet(:,2:end),key);
elseif optionkey==2
    %% Different Keys for each user
    numFeatures=length(testSet(1,:));
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
