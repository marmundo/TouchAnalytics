function main(option,classifierName,user, biometricDataName, keyType, orientation)
% option =
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
% 10: Generate and Test Score Matrix Production to the user @user using the classifier
% @classifierName, biometreic Data @biometricDataName  and key type
% @keyType
% 11: Generate and Test Score Matrix Production using all users and the classifier
% @classifierName, biometreic Data @biometricDataName  and key type
% @keyType
% 12: Test Score Matrix Production to the user @user using the classifier
% @classifierName, biometreic Data @biometricDataName  and key type
% @keyType
% 13: Test Score Matrix Production using all users and the classifier
% @classifierName, biometreic Data @biometricDataName  and key type
% @keyType
%
% classifier= classifier name will be used to analyse the biometric data
% user= user name which the classifier will analyse the biometric data
% biometricDataName= name of the biometric data. biometricDataName accepts
% the values 'Original', 'Interpolation', 'BioHashing', 'BioConvolving',
%'DoubleSum'
% keyType= Type of key used by to produce the cancelable biometric data.
% The keyType can be 'Same_Key' or 'Different_Key'
%orientation= orientation Stroke. This variable deals with values
%'Scrolling' and 'Horizontal'

scrolling=[];
horizontal=[];

if option==0
    %% Generating scrolling Original Data by User Label
    disp('Generating User Label Original');
    
    load('scrolling data.mat','scrolling');
    usersSize=length(unique(scrolling(:,1)));
    for user=1:usersSize
        disp(strcat('Processing User_ ',num2str(user)));
        generatingTrainingAndTest(scrolling,user,strcat(pwd(),'/Data/Scrolling/Original/User_Label/'),option);
    end
    
    %% Generating Horizontal Original Data by User Label
    
    load('horizontal data.mat','horizontal');
    usersSize=length(unique(scrolling(:,1)));
    for user=1:usersSize
        disp(strcat('Processing User_ ',num2str(user)));
        
        %generating training and testing data
        generatingTrainingAndTest(horizontal,user,strcat(pwd(),'/Data/Horizontal/Original/User_Label/'),option);
    end
    
elseif option==1
    %% Generating scrolling Original Data by Discretized User
    disp('Generating User Discretized Original');
    
    load('scrolling data.mat','scrolling');
    usersSize=length(unique(scrolling(:,1)));
    for user=1:usersSize
        disp(strcat('Processing User_ ',num2str(user)));
        
        %generating training and testing data
        generatingTrainingAndTest(scrolling,user,strcat(pwd(),'/Data/Scrolling/Original/User_Discre/'),option);
    end
    
    %% Generating Horizontal Original Data by Discretized User
    
    load('horizontal data.mat','horizontal');
    usersSize=length(unique(scrolling(:,1)));
    for user=1:usersSize
        disp(strcat('Processing User_ ',num2str(user)));
        
        %generating training and testing data
        generatingTrainingAndTest(horizontal,user,strcat(pwd(),'/Data/Horizontal/Original/User_Discre/'),option);
    end
    
elseif option==2
    
    %% Generating scrolling BioHashing Data by User
    disp('Generating Same Key BioHashing Data');
    
    load(strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_');
    
    %loading scrolling to know how many users there are
    load('scrolling data.mat','scrolling');
    usersSize=length(unique(scrolling(:,1)));
    
    for user=1:usersSize
        disp(strcat('Processing User_ ',num2str(user)));
        userS=num2str(user);
        filePath=strcat(strcat(pwd(),'/Data/Scrolling/BioHashing/Same_Key/User_'),userS);
        
        %loading and generating biohashing training data
        load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
        generatingBioHashingTraining(trainingSet,userS,filePath,1,1);
        
        %loading and generating biohashing test data
        load(strcat(prefix,userS,'/testSet.mat'),'testSet');
        generatingBioHashingTest(testSet,userS,filePath,1,1);
    end
    
    %% Generating Horizontal BioHashing Data by User
    
    load(strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_');
    
    load('horizontal data.mat','horizontal');
    usersSize=length(unique(horizontal(:,1)));
    for user=1:usersSize
        disp(strcat('Processing User_ ',num2str(user)));
        userS=num2str(user);
        filePath=strcat(strcat(pwd(),'/Data/Horizontal/BioHashing/Same_Key/User_',userS));
        
        %loading and generating biohashing training data
        load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
        generatingBioHashingTraining(trainingSet,userS,filePath,1,1);
        
        %loading and generating biohashing test data
        load(strcat(prefix,userS,'/testSet.mat'),'testSet');
        generatingBioHashingTest(testSet,userS,'',1,1);
    end
    
elseif option==3
    %% Generating scrolling BioHashing Data by User
    disp('Generating Different Key BioHashing Data');
    
    load(strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_');
    
    load('scrolling data.mat','scrolling');
    usersSize=length(unique(scrolling(:,1)));
    for user=1:usersSize
        disp(strcat('Processing User_ ',num2str(user)));
        userS=num2str(user);
        filePath=strcat(strcat(pwd(),'/Data/Scrolling/BioHashing/Different_Key/User_',userS));
        
        %loading and generating biohashing training data
        load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
        generatingBioHashingTraining(trainingSet,userS,filePath,2,1);
        
        %loading and generating biohashing test data
        load(strcat(prefix,userS,'/testSet.mat'),'testSet');
        generatingBioHashingTest(testSet,userS,filePath,2,1);
    end
    
    %% Generating Horizontal BioHashing Data by User
    
    load(strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_');
    
    load('horizontal data.mat','horizontal');
    usersSize=length(unique(horizontal(:,1)));
    for user=1:usersSize
        disp(strcat('Processing User_ ',num2str(user)));
        userS=num2str(user);
        filePath=strcat(pwd(),'/Data/Horizontal/BioHashing/Different_Key/User_',userS);
        
        %loading and generating biohashing training data
        load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
        generatingBioHashingTraining(trainingSet,userS,filePath,2,1);
        
        %loading and generating biohashing test data
        load(strcat(prefix,userS,'/testSet.mat'),'testSet');
        generatingBioHashingTest(testSet,userS,filePath,2,1);
    end
    
elseif option==4
    
    %% Generating scrolling BioConvolving Data by User
    disp('Generating Same Key BioConvolving Data');
    
    load(strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_');
    
    %loading scrolling to know how many users there are
    load('scrolling data.mat','scrolling');
    usersSize=length(unique(scrolling(:,1)));
    
    for user=1:usersSize
        disp(strcat('Processing User_ ',num2str(user)));
        userS=num2str(user);
        filePath=strcat(strcat(pwd(),'/Data/Scrolling/BioConvolving/Same_Key/User_'),userS);
        
        %loading and generating bioconvolving training data
        load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
        generatingBioConvolvingTraining(trainingSet,userS,filePath,1,1);
        
        %loading and generating bioconvolving test data
        load(strcat(prefix,userS,'/testSet.mat'),'testSet');
        generatingBioConvolvingTest(testSet,userS,filePath,1,1);
    end
        
    %% Generating Horizontal BioConvolving Data by User
    
    load(strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_');
    
    load('horizontal data.mat','horizontal');
    usersSize=length(unique(horizontal(:,1)));
    for user=1:usersSize
        disp(strcat('Processing User_ ',num2str(user)));
        userS=num2str(user);
        filePath=strcat(strcat(pwd(),'/Data/Horizontal/BioConvolving/Same_Key/User_',userS));
        
        %loading and generating bioconvolving training data
        load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
        generatingBioConvolvingTraining(trainingSet,userS,filePath,1,1);
        
        %loading and generating bioconvolving test data
        load(strcat(prefix,userS,'/testSet.mat'),'testSet');
        generatingBioConvolvingTest(testSet,userS,'',1,1);
    end
    
elseif option==5
    disp('Generating Different Key BioConvolving Data');
    
    %% Generating scrolling BioConvolving Data by User
    load(strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_');
    
    load('scrolling data.mat','scrolling');
    usersSize=length(unique(scrolling(:,1)));
    for user=1:usersSize
        disp(strcat('Processing User_ ',num2str(user)));
        userS=num2str(user);
        filePath=strcat(strcat(pwd(),'/Data/Scrolling/BioConvolving/Different_Key/User_',userS));
        
        %loading and generating bioconvolving training data
        load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
        generatingBioConvolvingTraining(trainingSet,userS,filePath,2,1);
        
        %loading and generating bioconvolving test data
        load(strcat(prefix,userS,'/testSet.mat'),'testSet');
        generatingBioConvolvingTest(testSet,userS,filePath,2,1);
    end
        
    %% Generating Horizontal BioConvolving Data by User
    
    load(strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_');
    
    load('horizontal data.mat','horizontal');
    usersSize=length(unique(horizontal(:,1)));
    for user=1:usersSize
        disp(strcat('Processing User_ ',num2str(user)));
        userS=num2str(user);
        filePath=strcat(pwd(),'/Data/Horizontal/BioConvolving/Different_Key/User_',userS);
        
        %loading and generating bioconvolving training data
        load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
        generatingBioConvolvingTraining(trainingSet,userS,filePath,2,1);
        
        %loading and generating bioconvolving test data
        load(strcat(prefix,userS,'/testSet.mat'),'testSet');
        generatingBioConvolvingTest(testSet,userS,filePath,2,1);
    end
    
elseif option==6
    disp('Generating Same Key Interpolation Data');
    %% Generating scrolling Interpolation Data by User
    
    load(strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_');
    
    %loading scrolling to know how many users there are
    load('scrolling data.mat','scrolling');
    usersSize=length(unique(scrolling(:,1)));
    
    for user=1:usersSize
        disp(strcat('Processing User_ ',num2str(user)));
        userS=num2str(user);
        filePath=strcat(strcat(pwd(),'/Data/Scrolling/Interpolation/Same_Key/User_'),userS);
        
        %loading and generating interpolation training data
        load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
        generatingInterpolationTraining(trainingSet,userS,filePath,1,1);
        
        %loading and generating interpolation test data
        load(strcat(prefix,userS,'/testSet.mat'),'testSet');
        generatingInterpolationTest(testSet,userS,filePath,1,1);
    end
    
    
    %% Generating Horizontal Interpolation Data by User
    
    load(strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_');
    
    load('horizontal data.mat','horizontal');
    usersSize=length(unique(horizontal(:,1)));
    
    for user=1:usersSize
        disp(strcat('Processing User_ ',num2str(user)));
        userS=num2str(user);
        filePath=strcat(strcat(pwd(),'/Data/Horizontal/Interpolation/Same_Key/User_',userS));
        
        %loading and generating interpolation training data
        load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
        generatingInterpolationTraining(trainingSet,userS,filePath,1,1);
        
        %loading and generating interpolation test data
        load(strcat(prefix,userS,'/testSet.mat'),'testSet');
        generatingInterpolationTest(testSet,userS,filePath,1,1);
    end
    
elseif option==7
    disp('Generating Different Key Interpolation Data');
    %% Generating scrolling Interpolation Data by User
    
    load(strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_');
    
    load('scrolling data.mat','scrolling');
    
    usersSize=length(unique(scrolling(:,1)));
    
    for user=1:usersSize
        disp(strcat('Processing User_ ',num2str(user)));
        
        userS=num2str(user);
        filePath=strcat(strcat(pwd(),'/Data/Scrolling/Interpolation/Different_Key/User_',userS));
        
        %loading and generating interpolation training data
        load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
        generatingInterpolationTraining(trainingSet,userS,filePath,2,1);
        
        %loading and generating interpolation test data
        load(strcat(prefix,userS,'/testSet.mat'),'testSet');
        generatingInterpolationTest(testSet,userS,filePath,2,1);
    end
    
    %% Generating Horizontal Interpolation Data by User
    
    load(strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_');
    
    load('horizontal data.mat','horizontal');
    usersSize=length(unique(horizontal(:,1)));
    for user=1:usersSize
        disp(strcat('Processing User_ ',num2str(user)));
        userS=num2str(user);
        filePath=strcat(pwd(),'/Data/Horizontal/Interpolation/Different_Key/User_',userS);
        
        %loading and generating interpolation training data
        load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
        generatingInterpolationTraining(trainingSet,userS,filePath,2,1);
        
        %loading and generating interpolation test data
        load(strcat(prefix,userS,'/testSet.mat'),'testSet');
        generatingInterpolationTest(testSet,userS,filePath,2,1);
    end
    
elseif option==8
    disp('Generating Same Key DoubleSum Data');
    %% Generating scrolling DoubleSum Data by User
    
    load(strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_');
    
    %loading scrolling to know how many users there are
    load('scrolling data.mat','scrolling');
    usersSize=length(unique(scrolling(:,1)));
    
    for user=1:usersSize
        disp(strcat('Processing User_ ',num2str(user)));
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
        disp(strcat('Processing User_ ',num2str(user)));
        userS=num2str(user);
        
        %Full path of file
        filePath=strcat(strcat(pwd(),'/Data/Horizontal/DoubleSum/Same_Key/User_',userS));
        
        %loading and generating double sum training data
        load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
        generatingDoubleSumTraining(trainingSet,userS,filePath,1,1);
        
        %loading and generating double sum test data
        load(strcat(prefix,userS,'/testSet.mat'),'testSet');
        generatingDoubleSumTest(testSet,userS,filePath,1,1);
    end
elseif option==9
    disp('Generating Different Key DoubleSum Data');
    %% Generating scrolling DoubleSum Data by User
    
    %loading training data
    load(strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_1/trainingSet.mat'));
    
    %prefix of the file name
    prefix=strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_');
    
    %loading scrolling data
    load('scrolling data.mat','scrolling');
    
    %quantity of users in the dataset
    usersSize=length(unique(scrolling(:,1)));
    
    for user=1:usersSize
        disp(strcat('Processing User_ ',num2str(user)));
        userS=num2str(user);
        
        %Full path of file
        filePath=strcat(strcat(pwd(),'/Data/Scrolling/DoubleSum/Different_Key/User_',userS));
        
        %loading and generating double sum training data
        load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
        generatingDoubleSumTraining(trainingSet,userS,filePath,2,1);
        
        %loading and generating double sum test data
        load(strcat(prefix,userS,'/testSet.mat'),'testSet');
        generatingDoubleSumTest(testSet,userS,filePath,2,1);
    end
    
    %% Generating Horizontal DoubleSum Data by User
    
    load(strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_');
    
    load('horizontal data.mat','horizontal');
    usersSize=length(unique(horizontal(:,1)));
    for user=1:usersSize
        disp(strcat('Processing User_ ',num2str(user)));
        userS=num2str(user);
        filePath=strcat(pwd(),'/Data/Horizontal/DoubleSum/Different_Key/User_',userS);
        load(strcat(prefix,userS,'/trainingSet.mat'));
        generatingDoubleSumTraining(trainingSet,userS,filePath,2,1);
        load(strcat(prefix,userS,'/testSet.mat'));
        generatingDoubleSumTest(testSet,userS,filePath,2,1);
    end
    
elseif option==10
    disp(strcat('Generatng and Ploting User_',num2str(user),'_Score Plot_',classifierName,'_',orientation,'_',biometricDataName,'_',keyType));
    
    %saving the scores in a file
    saveFilePath=strcat(pwd(),'/ScoreMatrix/',classifierName,'/',orientation,'/',biometricDataName,'/',keyType);
     if ~exist(saveFilePath,'dir')
            mkdir(saveFilePath);
     end
        
    %% Generating and Plot the Scores by users, cancelable function, stroke orientation and key type
    % Loading training data
    load(strcat(pwd(),'/Data/',orientation,'/',biometricDataName,'/',keyType,'/User_',num2str(user),'/trainingSet.mat'));
    
    % Loading testData
    load(strcat(pwd(),'/Data/',orientation,'/',biometricDataName,'/',keyType,'/User_',num2str(user),'/testSet.mat'));
    
    %saving the scores in a file
    [clientScore,impostorScore] = prediction(classifierName,trainingSet,trainUserLabels,testSet,testUserLabels,saveFilePath,user);
    
    save(strcat(saveFilePath,'/Score_User_',num2str(user),'.mat'),'clientScore','impostorScore');
    
    %Ploting the scores
    addpath('lib')
    wer(impostorScore,clientScore, [],1,[],1);
    savefig(strcat(saveFilePath,'/Score_User_',num2str(user)));
    
elseif option==11
    
    %% Generating and Plot the Scores by cancelable function, stroke orientation and key type
    addpath('lib')
    saveFilePath=strcat(pwd(),'/ScoreMatrix/',classifierName,'/',orientation,'/',biometricDataName,'/',keyType);
    saveFilePath=saveFilePath{1,:};
    
     if ~exist(saveFilePath,'dir')
            mkdir(saveFilePath);
     end
        
    disp(strcat('Generating and Ploting All Users Score Plot_',classifierName,'_',orientation,'_',biometricDataName,'_',keyType));
    
    clientScore=[];
    impostorScore=[];
    for user=1:41
        disp('Processing User', num2str(user));
        % Loading training data
        load(strcat(pwd(),'/Data/',orientation,'/',biometricDataName,'/',keyType,'/User_',num2str(user),'/trainingSet.mat'));
        
        % Loading testData
        load(strcat(pwd(),'/Data/',orientation,'/',biometricDataName,'/',keyType,'/User_',num2str(user),'/testSet.mat'));
        
        %getting the scores
        [uclientScore,uimpostorScore] = prediction(classifierName,trainingSet,trainUserLabels,testSet,testUserLabels,saveFilePath,user);
        
        if isempty(uclientScore) || isempty(uimpostorScore)
            disp('empty score');
        end
        wer(uimpostorScore,uclientScore, [],1,[],1);
        
        %saving the scores in a file
        
       
        
        savefig(strcat(saveFilePath,'/Score_User_',num2str(user)));
        
        % I cant put [clientScore,uclientScore], i.e, organize by columns
        %because the dimensions of clientScore some times is different of uclientScore
        %Thus, the scores are organized by line, i.e, a giant column 1.
        clientScore=[clientScore;uclientScore];
        impostorScore=[impostorScore;uimpostorScore];
        
     
    save(strcat(saveFilePath,'/Score_User_',num2str(user),'.mat'),'clientScore','impostorScore');
    end
%ploting the scores

wer(impostorScore,clientScore, [],1,[],1);
savefig(strcat(saveFilePath,'/Score'));

elseif option==12
    addpath('lib')
    % Loading score matrix
    disp(strcat('Ploting User_',num2str(user),'_Score Plot_',classifierName,'_',orientation,'_',biometricDataName,'_',keyType));
    saveFilePath=strcat(pwd(),'/ScoreMatrix/',classifierName,'/',orientation,'/',biometricDataName,'/',keyType);
     if ~exist(saveFilePath,'dir')
            mkdir(saveFilePath);
     end
        
    load(strcat(saveFilePath,'/Score_User_',num2str(user),'.mat'),'clientScore','impostorScore');
    
    %ploting the scores
    addpath('lib')
    wer(impostorScore,clientScore, [],1,[],1);
    savefig(strcat(saveFilePath,'/Score_User_',num2str(user)));
    
    elseif option==13
        allClientScore=[];
        allImpostorScore=[];
        for user=1:41
            % Loading score matrix
            saveFilePath=strcat(pwd(),'/ScoreMatrix/',classifierName,'/',orientation,'/',biometricDataName,'/',keyType);
            load(strcat(saveFilePath,'/Score_User_',num2str(user),'.mat'),'clientScore','impostorScore');
            
            if isempty(clientScore) | isempty(impostorScore)
                disp('empty score');
            end
            
            %storing the score to plot
            allClientScore=[allClientScore;clientScore];
            allImpostorScore=[allImpostorScore;impostorScore];
            
        end
        
        %ploting the scores
        addpath('lib')
        disp(strcat('Ploting All Users Score Plot_',classifierName,'_',orientation,'_',biometricDataName,'_',keyType));
        wer(allImpostorScore,allClientScore, [],1,[],1);
        savefig(strcat(saveFilePath,'/Score'));
        
end


