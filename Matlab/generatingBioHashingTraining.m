function [bioH_train]=generatingBioHashingTraining(trainingSet,user,savefilePath,optionkey)   
%optionkey = 
% 1: use the same key to all the users
% 2: use a different key to each user


% Generating the biohashing data
% generating the bioHashing data without the user label
% (trainingSet(:,2:end)
bioH_train=[];
if optionkey==1
    bioH_train=biohashing(trainingSet(:,2:end),'');    
elseif optionkey==2   
    numFeatures=length(trainingSet(1,:));
    users=unique(trainingSet(:,1));
    for i=1:length(users)        
        userData=trainingSet(find(trainingSet(:,1) == users(i)),:);
        key=rand(numFeatures-1);
        bioHashingData=biohashing(userData(:,2:end),key);
        bioH_train=[bioH_train; bioHashingData];
    end        
end

%adding the user label to the biohashing data
    bioH_train=[bioH_train trainingSet(:,1)];
    
    bioH_train=discretizeUser(str2num(user),length(bioH_train(1,:)),bioH_train);
    
    %Folder used to save the biohashing data
    if(isempty(savefilePath))
        savefilePath=strcat(pwd(),'Data/Horizontal/BioHashing/Same_key/User_',user);    
    end
    if ~exist(savefilePath,'dir')
        mkdir(savefilePath);
    end
    
    %saving the training data
    save(strcat(savefilePath,'/trainingSet.mat'),'bioH_train');
   
    end

    
