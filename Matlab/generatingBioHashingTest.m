function [bioH_test]=generatingBioHashingTest(testSet,user,savefilePath,optionkey,keySize)   
%optionkey = 
% 1: use the same key to all the users
% 2: use a different key to each user


% Generating the biohashing data
% generating the bioHashing data without the user label
% (trainingSet(:,2:end)
bioH_test=[];
if optionkey==1
    bioH_test=biohashing(testSet(:,2:end),'');    
elseif optionkey==2   
    numFeatures=length(testSet(1,:));
    users=unique(testSet(:,1));
    for i=1:length(users)        
        userData=testSet(find(testSet(:,1) == users(i)),:);
        userData=userData(:,1:numFeatures*keySize);
        key=rand(numFeatures-1*keySize);
        bioHashingData=biohashing(userData(:,2:end),key);
        bioH_test=[bioH_test; bioHashingData];
    end        
end
%adding the user label to the biohashing data
    bioH_test=[bioH_test testSet(:,1)];
    
     bioH_test=discretizeUser(str2num(user),length(bioH_test(1,:)),bioH_test);
    
     %Folder used to save the biohashing data
    if(isempty(savefilePath))
       savefilePath=strcat(pwd(),'/Data/Horizontal/BioHashing/Same_Key/User_',user);    
    end
    if ~exist(savefilePath,'dir')
        mkdir(savefilePath);
    end
    
    %saving the training data
    save(strcat(savefilePath,'/testSet.mat'),'bioH_test');
end
