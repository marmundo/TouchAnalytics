function main(option,classifierName)
%option =
% 0: Generating Unprotected data with original user label
% 1: Generating Unprotected data with user label= (client) or (impostor)
% 2: BioHashing, use the same key to all the users
% 3: BioHashing, use a different key to each user
% 4: Interpolation, use the same key to all the users
% 5: Interpolation, use a different key to each user
% 6: Test Score Matrix Production
%
% classifier= classifier name will be used to analyse the biometric data

if option==0
    %% Generating scrolling Original Data by User
    
    load('scrolling data.mat');
    usersSize=length(unique(scrolling(:,1)));
    for user=1:usersSize
        [train,test]=generatingTrainingAndTest(scrolling,user,strcat(pwd(),'/Data/Scrolling/Original/User_Label/'),option);
    end
    
    
    %% Generating Horizontal Original Data by User
    
    load('horizontal data.mat');
    usersSize=length(unique(scrolling(:,1)));
    for user=1:usersSize
        [train,test]=generatingTrainingAndTest(horizontal,user,strcat(pwd(),'/Data/Horizontal/Original/User_Label/'),option);
    end
elseif option==1
    %% Generating scrolling Original Data by User
    
    load('scrolling data.mat');
    usersSize=length(unique(scrolling(:,1)));
    for user=1:usersSize
        [train,test]=generatingTrainingAndTest(scrolling,user,strcat(pwd(),'/Data/Scrolling/Original/User_Discre/'),option);
    end
    
    
    %% Generating Horizontal Original Data by User
    
    load('horizontal data.mat');
    usersSize=length(unique(scrolling(:,1)));
    for user=1:usersSize
        [train,test]=generatingTrainingAndTest(horizontal,user,strcat(pwd(),'/Data/Horizontal/Original/User_Discre/'),option);
    end
elseif option==2
    
    %% Generating scrolling BioHashing Data by User
    
    load(strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_');
    
    %loading scrolling to know how many users there are
    load('scrolling data.mat');
    usersSize=length(unique(scrolling(:,1)));
    
    for user=1:usersSize
        userS=num2str(user);
        filePath=strcat(strcat(pwd(),'/Data/Scrolling/BioHashing/Same_Key/User_'),userS);
        load(strcat(prefix,userS,'/trainingSet.mat'));
        train=generatingBioHashingTraining(trainingSet,userS,filePath,1,1);
        load(strcat(prefix,userS,'/testSet.mat'));
        test=generatingBioHashingTest(testSet,userS,filePath,1,1);
    end
    
    
    %% Generating Horizontal BioHashing Data by User
    
    load(strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_');
    
    load('horizontal data.mat');
    usersSize=length(unique(horizontal(:,1)));
    for user=1:usersSize
        userS=num2str(user);
        filePath=strcat(strcat(pwd(),'/Data/Horizontal/BioHashing/Same_Key/User_',userS));
        load(strcat(prefix,userS,'/trainingSet.mat'));
        train=generatingBioHashingTraining(trainingSet,userS,filePath,1,1);
        load(strcat(prefix,userS,'/testSet.mat'));
        test=generatingBioHashingTest(testSet,userS,'',1,1);
    end
elseif option==3
    %% Generating scrolling BioHashing Data by User
    
    load(strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_');
    
    load('scrolling data.mat');
    usersSize=length(unique(scrolling(:,1)));
    for user=1:usersSize
        userS=num2str(user);
        filePath=strcat(strcat(pwd(),'/Data/Scrolling/BioHashing/Different_Key/User_',userS));
        load(strcat(prefix,userS,'/trainingSet.mat'));
        train=generatingBioHashingTraining(trainingSet,userS,filePath,2,1);
        load(strcat(prefix,userS,'/testSet.mat'));
        test=generatingBioHashingTest(testSet,userS,filePath,2,1);
    end
    
    
    %% Generating Horizontal BioHashing Data by User
    
    load(strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_');
    
    load('horizontal data.mat');
    usersSize=length(unique(horizontal(:,1)));
    for user=1:usersSize
        userS=num2str(user);
        filePath=strcat(pwd(),'/Data/Horizontal/BioHashing/Different_Key/User_',userS);
        load(strcat(prefix,userS,'/trainingSet.mat'));
        train=generatingBioHashingTraining(trainingSet,userS,filePath,2,1);
        load(strcat(prefix,userS,'/testSet.mat'));
        test=generatingBioHashingTest(testSet,userS,filePath,2,1);
    end
    elseif option==4
    
    %% Generating scrolling BioHashing Data by User
    
    load(strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_');
    
    %loading scrolling to know how many users there are
    load('scrolling data.mat');
    usersSize=length(unique(scrolling(:,1)));
    
    for user=1:usersSize
        userS=num2str(user);
        filePath=strcat(strcat(pwd(),'/Data/Scrolling/Interpolation/Same_Key/User_'),userS);
        load(strcat(prefix,userS,'/trainingSet.mat'));
        train=generatingInterpolationTraining(trainingSet,userS,filePath,1,1);
        load(strcat(prefix,userS,'/testSet.mat'));
        test=generatingInterpolationTest(testSet,userS,filePath,1,1);
    end
    
    
    %% Generating Horizontal BioHashing Data by User
    
    load(strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_');
    
    load('horizontal data.mat');
    usersSize=length(unique(horizontal(:,1)));
    for user=1:usersSize
        userS=num2str(user);
        filePath=strcat(strcat(pwd(),'/Data/Horizontal/Interpolation/Same_Key/User_',userS));
        load(strcat(prefix,userS,'/trainingSet.mat'));
        train=generatingInterpolationTraining(trainingSet,userS,filePath,1,1);
        load(strcat(prefix,userS,'/testSet.mat'));
        test=generatingInterpolationTest(testSet,userS,'',1,1);
    end
elseif option==5
    %% Generating scrolling BioHashing Data by User
    
    load(strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_');
    
    load('scrolling data.mat');
    usersSize=length(unique(scrolling(:,1)));
    for user=1:usersSize
        userS=num2str(user);
        filePath=strcat(strcat(pwd(),'/Data/Scrolling/Interpolation/Different_Key/User_',userS));
        load(strcat(prefix,userS,'/trainingSet.mat'));
        train=generatingInterpolationTraining(trainingSet,userS,filePath,2,1);
        load(strcat(prefix,userS,'/testSet.mat'));
        test=generatingInterpolationTest(testSet,userS,filePath,2,1);
    end
    
    
    %% Generating Horizontal BioHashing Data by User
    
    load(strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_');
    
    load('horizontal data.mat');
    usersSize=length(unique(horizontal(:,1)));
    for user=1:usersSize
        userS=num2str(user);
        filePath=strcat(pwd(),'/Data/Horizontal/Interpolation/Different_Key/User_',userS);
        load(strcat(prefix,userS,'/trainingSet.mat'));
        train=generatingInterpolationTraining(trainingSet,userS,filePath,2,1);
        load(strcat(prefix,userS,'/testSet.mat'));
        test=generatingInterpolationTest(testSet,userS,filePath,2,1);
    end
elseif option==6
    % Loading training data
    load(strcat(pwd(),'/Data/Scrolling/BioHashing/Same_Key/User_1/trainingSet.mat'));
    
    % Loading testData
    load(strcat(pwd(),'/Data/Scrolling/BioHashing/Same_Key/User_1/testSet.mat'));
    
    %executing svm to generate score matrix
    [clientScore,impostorScore] = prediction(classifierName,bioH_train,trainUserLabels,bioH_test,testUserLabels);
    
    wer(impostorScore,clientScore, [],1,[],1);
    unique(impostorScore)
    unique(clientScore)
end
end


