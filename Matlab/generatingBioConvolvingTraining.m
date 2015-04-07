function [bioC_train]=generatingBioConvolvingTraining(trainingSet,user,saveFilePath,optionkey,keySize)
% trainingSet= training dataset will be protected
% user= original user of the training dataset
% saveFilePath=Path wich the training biohashing data will be save
% optionkey =
% 1: use the same key to all the users
% 2: use a different key to each user
% keysize= size of key. Maximum value is the number of features.

%starting variable
bioC_train=[];

if optionkey==1
    %% Same key for all users    
    nFeatures=length(trainingSet(1,2:end));
    key=[0,round(nFeatures/2),nFeatures];
    bioC_train=bioconvolving(trainingSet(:,2:end),key);
elseif optionkey==2
    %% Different key for each user
    numFeatures=length(trainingSet(1,2:end));
    users=unique(trainingSet(:,1));
    
    for currentUser=1:length(users)
        % data of user i
        userData=trainingSet(find(trainingSet(:,1) == users(currentUser)),:);
      
            
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
           break
        end
        end
        
        % protecting the user data using the generated key
        bioConvolvingData=bioconvolving(userData(:,2:end),key);
       
        % adding user protected data to the bioH_train variable            
        bioC_train=[bioC_train; bioConvolvingData];
    end
end

% adding the user label to the biohashing data
bioC_train=[bioC_train trainingSet(:,1)];

% discretizing protected dataset
[bioC_train, trainUserLabels]=discretizeUser(str2num(user),length(bioC_train(1,:)),bioC_train);

%% Saving protected data

% If empty, create the variable
if(isempty(saveFilePath))
    saveFilePath=strcat(pwd(),'/Data/Horizontal/BioConvolving/Same_Key/User_',user);
end

% If doesn't exist, create the Folder
if ~exist(saveFilePath,'dir')
    mkdir(saveFilePath);
end

%saving the training data
save(strcat(saveFilePath,'/trainingSet.mat'),'bioC_train','trainUserLabels');

end

    
