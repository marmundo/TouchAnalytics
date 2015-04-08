function main(option,classifierName)
%option =
% 0: Generating Unprotected data with original user label
% 1: Generating Unprotected data with user label= (client) or (impostor)
% 2: BioHashing, use the same key to all the users
% 3: BioHashing, use a different key to each user
% 4: BioConvolving, use the same key to all the users
% 5: BioConvolving, use a different key to each user
% 6: Interpolation, use the same key to all the users
% 7: Interpolation, use a different key to each user
% 8: Double Sum, use the same key to all the users
% 9: Double Sum, use a different key to each user
% 10: Test Score Matrix Production
%
% classifier= classifier name will be used to analyse the biometric data

scrolling=[];
horizontal=[];

if option==0
    %% Generating scrolling Original Data by User
    
    load('scrolling data.mat','scrolling');
    usersSize=length(unique(scrolling(:,1)));
    for user=1:usersSize
        generatingTrainingAndTest(scrolling,user,strcat(pwd(),'/Data/Scrolling/Original/User_Label/'),option);
    end
    
    
    %% Generating Horizontal Original Data by User
    
    load('horizontal data.mat','horizontal');
    usersSize=length(unique(scrolling(:,1)));
    for user=1:usersSize
        generatingTrainingAndTest(horizontal,user,strcat(pwd(),'/Data/Horizontal/Original/User_Label/'),option);
    end
elseif option==1
    %% Generating scrolling Original Data by User
    
   load('scrolling data.mat','scrolling');
    usersSize=length(unique(scrolling(:,1)));
    for user=1:usersSize
        generatingTrainingAndTest(scrolling,user,strcat(pwd(),'/Data/Scrolling/Original/User_Discre/'),option);
    end
    
    
    %% Generating Horizontal Original Data by User
    
    load('horizontal data.mat','horizontal');
    usersSize=length(unique(scrolling(:,1)));
    for user=1:usersSize
        generatingTrainingAndTest(horizontal,user,strcat(pwd(),'/Data/Horizontal/Original/User_Discre/'),option);
    end
elseif option==2
    
    %% Generating scrolling BioHashing Data by User
    
    load(strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_');
    
    %loading scrolling to know how many users there are
   load('scrolling data.mat','scrolling');
    usersSize=length(unique(scrolling(:,1)));
    
    for user=1:usersSize
        userS=num2str(user);
        filePath=strcat(strcat(pwd(),'/Data/Scrolling/BioHashing/Same_Key/User_'),userS);
        load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
        generatingBioHashingTraining(trainingSet,userS,filePath,1,1);
        load(strcat(prefix,userS,'/testSet.mat'),'testSet');
        generatingBioHashingTest(testSet,userS,filePath,1,1);
    end
    
    
    %% Generating Horizontal BioHashing Data by User
    
    load(strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_');
    
    load('horizontal data.mat','horizontal');
    usersSize=length(unique(horizontal(:,1)));
    for user=1:usersSize
        userS=num2str(user);
        filePath=strcat(strcat(pwd(),'/Data/Horizontal/BioHashing/Same_Key/User_',userS));
        load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
        generatingBioHashingTraining(trainingSet,userS,filePath,1,1);
        load(strcat(prefix,userS,'/testSet.mat'),'testSet');
        generatingBioHashingTest(testSet,userS,'',1,1);
    end
elseif option==3
    %% Generating scrolling BioHashing Data by User
    
    load(strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_');
    
   load('scrolling data.mat','scrolling');
    usersSize=length(unique(scrolling(:,1)));
    for user=1:usersSize
        userS=num2str(user);
        filePath=strcat(strcat(pwd(),'/Data/Scrolling/BioHashing/Different_Key/User_',userS));
        load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
        generatingBioHashingTraining(trainingSet,userS,filePath,2,1);
        load(strcat(prefix,userS,'/testSet.mat'),'testSet');
        generatingBioHashingTest(testSet,userS,filePath,2,1);
    end
    
    
    %% Generating Horizontal BioHashing Data by User
    
    load(strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_');
    
    load('horizontal data.mat','horizontal');
    usersSize=length(unique(horizontal(:,1)));
    for user=1:usersSize
        userS=num2str(user);
        filePath=strcat(pwd(),'/Data/Horizontal/BioHashing/Different_Key/User_',userS);
        load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
        generatingBioHashingTraining(trainingSet,userS,filePath,2,1);
        load(strcat(prefix,userS,'/testSet.mat'),'testSet');
        generatingBioHashingTest(testSet,userS,filePath,2,1);
    end
    elseif option==4
    
    %% Generating scrolling BioConvolving Data by User
    
    load(strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_');
    
    %loading scrolling to know how many users there are
   load('scrolling data.mat','scrolling');
    usersSize=length(unique(scrolling(:,1)));
    
    for user=1:usersSize
        userS=num2str(user);
        filePath=strcat(strcat(pwd(),'/Data/Scrolling/BioConvolving/Same_Key/User_'),userS);
        load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
        generatingBioConvolvingTraining(trainingSet,userS,filePath,1,1);
        load(strcat(prefix,userS,'/testSet.mat'),'testSet');
        generatingBioConvolvingTest(testSet,userS,filePath,1,1);
    end
    
    
    %% Generating Horizontal BioConvolving Data by User
    
    load(strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_');
    
    load('horizontal data.mat','horizontal');
    usersSize=length(unique(horizontal(:,1)));
    for user=1:usersSize
        userS=num2str(user);
        filePath=strcat(strcat(pwd(),'/Data/Horizontal/BioConvolving/Same_Key/User_',userS));
        load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
        generatingBioConvolvingTraining(trainingSet,userS,filePath,1,1);
        load(strcat(prefix,userS,'/testSet.mat'),'testSet');
        generatingBioConvolvingTest(testSet,userS,'',1,1);
    end
elseif option==5
    %% Generating scrolling BioConvolving Data by User
    
    load(strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_');
    
   load('scrolling data.mat','scrolling');
    usersSize=length(unique(scrolling(:,1)));
    for user=1:usersSize
        userS=num2str(user);
        filePath=strcat(strcat(pwd(),'/Data/Scrolling/BioConvolving/Different_Key/User_',userS));
        load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
        generatingBioConvolvingTraining(trainingSet,userS,filePath,2,1);
        load(strcat(prefix,userS,'/testSet.mat'),'testSet');
        generatingBioConvolvingTest(testSet,userS,filePath,2,1);
    end
    
    
    %% Generating Horizontal BioConvolving Data by User
    
    load(strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_');
    
    load('horizontal data.mat','horizontal');
    usersSize=length(unique(horizontal(:,1)));
    for user=1:usersSize
        userS=num2str(user);
        filePath=strcat(pwd(),'/Data/Horizontal/BioConvolving/Different_Key/User_',userS);
        load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
        generatingBioConvolvingTraining(trainingSet,userS,filePath,2,1);
        load(strcat(prefix,userS,'/testSet.mat'),'testSet');
        generatingBioConvolvingTest(testSet,userS,filePath,2,1);
    end
elseif option==6
     %% Generating scrolling Interpolation Data by User
    
    load(strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_');
    
    %loading scrolling to know how many users there are
   load('scrolling data.mat','scrolling');
    usersSize=length(unique(scrolling(:,1)));
    
    for user=1:usersSize
        userS=num2str(user);
        filePath=strcat(strcat(pwd(),'/Data/Scrolling/Interpolation/Same_Key/User_'),userS);
        load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
        generatingInterpolationTraining(trainingSet,userS,filePath,1,1);
        load(strcat(prefix,userS,'/testSet.mat'),'testSet');
        generatingInterpolationTest(testSet,userS,filePath,1,1);
    end      
     
      
    %% Generating Horizontal Interpolation Data by User
    
    load(strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_');
    
    load('horizontal data.mat','horizontal');
    usersSize=length(unique(horizontal(:,1)));
    for user=1:usersSize
        userS=num2str(user);
        filePath=strcat(strcat(pwd(),'/Data/Horizontal/Interpolation/Same_Key/User_',userS));
        load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
        generatingInterpolationTraining(trainingSet,userS,filePath,1,1);
        load(strcat(prefix,userS,'/testSet.mat'),'testSet');
        generatingInterpolationTest(testSet,userS,filePath,1,1);
    end
elseif option==7
    %% Generating scrolling Interpolation Data by User
    
    load(strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_');
    
   load('scrolling data.mat','scrolling');
   usersSize=length(unique(scrolling(:,1)));
    for user=1:usersSize
        userS=num2str(user);
        filePath=strcat(strcat(pwd(),'/Data/Scrolling/Interpolation/Different_Key/User_',userS));
        load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
        generatingInterpolationTraining(trainingSet,userS,filePath,2,1);
        load(strcat(prefix,userS,'/testSet.mat'),'testSet');
        generatingInterpolationTest(testSet,userS,filePath,2,1);
    end
    
    
    %% Generating Horizontal Interpolation Data by User
    
    load(strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_');
    
    load('horizontal data.mat','horizontal');
    usersSize=length(unique(horizontal(:,1)));
    for user=1:usersSize
        userS=num2str(user);
        filePath=strcat(pwd(),'/Data/Horizontal/Interpolation/Different_Key/User_',userS);
        load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
        generatingInterpolationTraining(trainingSet,userS,filePath,2,1);
        load(strcat(prefix,userS,'/testSet.mat'),'testSet');
        generatingInterpolationTest(testSet,userS,filePath,2,1);
    end
    elseif option==8
     %% Generating scrolling DoubleSum Data by User
    
    load(strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_');
    
    %loading scrolling to know how many users there are
    load('scrolling data.mat','scrolling');
    usersSize=length(unique(scrolling(:,1)));
    
    for user=1:usersSize
        userS=num2str(user);
        filePath=strcat(strcat(pwd(),'/Data/Scrolling/DoubleSum/Same_Key/User_'),userS);
        load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
        generatingDoubleSumTraining(trainingSet,userS,filePath,1,1);
        load(strcat(prefix,userS,'/testSet.mat'),'testSet');
        generatingDoubleSumTest(testSet,userS,filePath,1,1);
    end             
     
      
    %% Generating Horizontal Double Sum Data by User
    
    load(strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_');
    
    load('horizontal data.mat','horizontal');
    usersSize=length(unique(horizontal(:,1)));
    for user=1:usersSize
        userS=num2str(user);
        filePath=strcat(strcat(pwd(),'/Data/Horizontal/DoubleSum/Same_Key/User_',userS));
        load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
        generatingDoubleSumTraining(trainingSet,userS,filePath,1,1);
        load(strcat(prefix,userS,'/testSet.mat'),'testSet');
        generatingDoubleSumTest(testSet,userS,filePath,1,1);
    end
elseif option==9
    %% Generating scrolling DoubleSum Data by User
    
    load(strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_');
    
    load('scrolling data.mat','scrolling');
    usersSize=length(unique(scrolling(:,1)));
    for user=1:usersSize
        userS=num2str(user);
        filePath=strcat(strcat(pwd(),'/Data/Scrolling/DoubleSum/Different_Key/User_',userS));
        load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
        generatingDoubleSumTraining(trainingSet,userS,filePath,2,1);
        load(strcat(prefix,userS,'/testSet.mat'),'testSet');
        generatingDoubleSumTest(testSet,userS,filePath,2,1);
    end
    
    
    %% Generating Horizontal DoubleSum Data by User
    
    load(strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_');
    
    load('horizontal data.mat','horizontal');
    usersSize=length(unique(horizontal(:,1)));
    for user=1:usersSize
        userS=num2str(user);
        filePath=strcat(pwd(),'/Data/Horizontal/DoubleSum/Different_Key/User_',userS);
        load(strcat(prefix,userS,'/trainingSet.mat'));
        generatingDoubleSumTraining(trainingSet,userS,filePath,2,1);
        load(strcat(prefix,userS,'/testSet.mat'));
        generatingDoubleSumTest(testSet,userS,filePath,2,1);
    end
elseif option==10
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


