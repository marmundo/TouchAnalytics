function main(option)
%option = 
% 0: Generating Unprotected data with origianl user label
% 1: Generating Unprotected data with user label= 1 (client) or 0(impostor)
% 2: BioHashing, use the same key to all the users
% 3: BioHashing, use a different key to each user
if option==0
    %% Generating scrolling Original Data by User

    load('scrolling_data.mat');
    usersSize=length(unique(scrolling(:,1)));
    for user=1:usersSize  
        [train,test]=generatingTrainingAndTest(scrolling,user,'/home/marcelo/Dropbox/Surrey/Norman/Data/Scrolling/Original/User_Label/',option);
    end


    %% Generating Horizontal Original Data by User

    load('horizontal data.mat');
    usersSize=length(unique(scrolling(:,1)));
    for user=1:usersSize
        [train,test]=generatingTrainingAndTest(horizontal,user,'/home/marcelo/Dropbox/Surrey/Norman/Data/Horizontal/Original/User_Label/',option);
    end
elseif option==1
    %% Generating scrolling Original Data by User

    load('scrolling_data.mat');
    usersSize=length(unique(scrolling(:,1)));
    for user=1:usersSize  
        [train,test]=generatingTrainingAndTest(scrolling,user,'/home/marcelo/Dropbox/Surrey/Norman/Data/Scrolling/Original/User_Discre/',option);
    end


    %% Generating Horizontal Original Data by User

    load('horizontal data.mat');
    usersSize=length(unique(scrolling(:,1)));
    for user=1:usersSize
        [train,test]=generatingTrainingAndTest(horizontal,user,'/home/marcelo/Dropbox/Surrey/Norman/Data/Horizontal/Original/User_Discre/',option);
    end
elseif option==2
    
    %% Generating scrolling BioHashing Data by User
    
    load('/home/marcelo/Dropbox/Surrey/Norman/Data/Scrolling/Original/User_Label/User_1/trainingSet.mat');
    prefix='/home/marcelo/Dropbox/Surrey/Norman/Data/Scrolling/Original/User_Label/User_';
    
    load('scrolling_data.mat');
    usersSize=length(unique(scrolling(:,1)));
    for user=1:usersSize  
        userS=num2str(user);
        filePath=strcat('/home/marcelo/Dropbox/Surrey/Norman/Data/Scrolling/BioHashing/Same_Key/User_',userS);
        load(strcat(prefix,userS,'/trainingSet.mat'));
        train=generatingBioHashingTraining(trainingSet,userS,filePath,1);
        load(strcat(prefix,userS,'/testSet.mat'));
        test=generatingBioHashingTest(testSet,userS,filePath,1);    
    end


    %% Generating Horizontal BioHashing Data by User

    load('/home/marcelo/Dropbox/Surrey/Norman/Data/Horizontal/Original/User_Label/User_1/trainingSet.mat');
    prefix='/home/marcelo/Dropbox/Surrey/Norman/Data/Horizontal/Original/User_Label/User_';
    
    load('horizontal data.mat');
    usersSize=length(unique(horizontal(:,1)));
    for user=1:usersSize        
        userS=num2str(user);
        filePath=strcat('/home/marcelo/Dropbox/Surrey/Norman/Data/Horizontal/BioHashing/Same_Key/User_',userS);
        load(strcat(prefix,userS,'/trainingSet.mat'));
        train=generatingBioHashingTraining(trainingSet,userS,'',1);
        load(strcat(prefix,userS,'/testSet.mat'));
        test=generatingBioHashingTest(testSet,userS,'',1);
    end
elseif option==3
     %% Generating scrolling BioHashing Data by User
    
    load('/home/marcelo/Dropbox/Surrey/Norman/Data/Scrolling/Original/User_Label/User_1/trainingSet.mat');
    prefix='/home/marcelo/Dropbox/Surrey/Norman/Data/Scrolling/Original/User_Label/User_';
    
    load('scrolling_data.mat');
    usersSize=length(unique(scrolling(:,1)));
    for user=1:usersSize  
        userS=num2str(user);
        filePath=strcat('/home/marcelo/Dropbox/Surrey/Norman/Data/Scrolling/BioHashing/Different_Key/User_',userS);
        load(strcat(prefix,userS,'/trainingSet.mat'));
        train=generatingBioHashingTraining(trainingSet,userS,filePath,2);
        load(strcat(prefix,userS,'/testSet.mat'));
        test=generatingBioHashingTest(testSet,userS,filePath,2);    
    end


    %% Generating Horizontal BioHashing Data by User

    load('/home/marcelo/Dropbox/Surrey/Norman/Data/Horizontal/Original/User_Label/User_1/trainingSet.mat');
    prefix='/home/marcelo/Dropbox/Surrey/Norman/Data/Horizontal/Original/User_Label/User_';
    
    load('horizontal data.mat');
    usersSize=length(unique(horizontal(:,1)));
    for user=1:usersSize        
        userS=num2str(user);
        filePath=strcat('/home/marcelo/Dropbox/Surrey/Norman/Data/Horizontal/BioHashing/Different_Key/User_',userS);
        load(strcat(prefix,userS,'/trainingSet.mat'));
        train=generatingBioHashingTraining(trainingSet,userS,filePath,2);
        load(strcat(prefix,userS,'/testSet.mat'));
        test=generatingBioHashingTest(testSet,userS,filePath,2);
    end
end    
end


