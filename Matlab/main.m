function main(option,classifierName,user, biometricDataName, keyType, orientation,keySize)
% option =
% -1:Cleaning and normalize data
% 0: Generating Unprotected data with original user label
% 1: Generating Unprotected data with user label= (client) or (impostor)
% 2: BioHashing, Homogeneous - Unknown key
% 3: BioHashing, Heterogeneous - Unknown key
% 4: BioHashing, Homogenous Know Key
% 5: BioHashing, Heterogeneous - know key
% 6: BioConvolving, Homogeneous - Unknown key
% 7: BioConvolving, Heterogeneous - Unknown key
% 8: BioConvolving, Homogenous Know Key
% 9: BioConvolving, Heterogeneous Know Key
% 10: Interpolation, Homogeneous - Unknown key
% 11: Interpolation, Heterogeneous - Unknown key
% 12: Interpolation, Homogeneous - know key
% 13: Interpolation, Heterogeneous - know key
% 14: Double Sum, Homogeneous - Unknown key
% 15: Double Sum, Heterogeneous - Unknown key
% 16: Double Sum, Homogeneous - know key
% 17: Double Sum, Heterogeneous - know key
% 18: Generate and Test Score Matrix Production to the user @user using the classifier
% @classifierName, biometreic Data @biometricDataName  and key type
% @keyType
% 19: Generate and Test Score Matrix Production using all users and the classifier
% @classifierName, biometreic Data @biometricDataName  and key type
% @keyType
% 20: Test Score Matrix Production to the user @user using the classifier
% @classifierName, biometreic Data @biometricDataName  and key type
% @keyType
% 21: Test Score Matrix Production using all users and the classifier
% @classifierName, biometreic Data @biometricDataName  and key type
% @keyType
% 22: Score Matrix Production to the user @user using the trained classifier
% @classifierName, biometreic Data @biometricDataName  and key type
% @keyType
% 23: Test Score Matrix Production using all users and the trained classifier
% @classifierName, biometreic Data @biometricDataName  and key type
% @keyType
% 24: Print the DET Curve to Original, Same Key and Different Key
% Experiments
% classifier= classifier name will be used to analyse the biometric data
% user= user name which the classifier will analyse the biometric data
% biometricDataName= name of the biometric data. biometricDataName accepts
% the values 'Original', 'Interpolation', 'BioHashing', 'BioConvolving',
%'DoubleSum'
% keyType= Type of key used by to produce the cancelable biometric data.
% The keyType can be 'Homo_Un_Key' or 'Hete_Un_Key'
%orientation= orientation Stroke. This variable deals with values
%'Scrolling' and 'Horizontal'

if option>17
    scoreMatrixPath=[pwd(),'/ScoreMatrix/',num2str(keySize),'/',classifierName,'/',orientation,'/',biometricDataName,'/',keyType];
    if ~exist(scoreMatrixPath,'dir')
        mkdir(scoreMatrixPath);
    end
    scorePlotsFigPath=[pwd(),'/ScorePlots/fig/',num2str(keySize),'/',classifierName,'/',orientation,'/',biometricDataName,'/',keyType];
    if ~exist(scorePlotsFigPath,'dir')
        mkdir(scorePlotsFigPath);
    end
    
    scorePlotsJpgPath=[pwd(),'/ScorePlots/jpg/',num2str(keySize),'/',classifierName,'/',orientation,'/',biometricDataName,'/',keyType];
    if ~exist(scorePlotsJpgPath,'dir')
        mkdir(scorePlotsJpgPath);
    end
    
    detPlotsFigPath=[pwd(),'/DETPlots/fig/',num2str(keySize),'/',classifierName,'/',orientation,'/',biometricDataName,'/',keyType];
    if ~exist(detPlotsFigPath,'dir')
        mkdir(detPlotsFigPath);
    end
    
    detPlotsJpgPath=[pwd(),'/DETPlots/jpg/',num2str(keySize),'/',classifierName,'/',orientation,'/',biometricDataName,'/',keyType];
    if ~exist(detPlotsJpgPath,'dir')
        mkdir(detPlotsJpgPath);
    end
end
scrolling=[];
horizontal=[];

if option==-1
    load('touch.mat');
    
    %Getting the index of scrolling strokes
    sIndex=featMat(:,2)<=3|featMat(:,2)==6;
    scrolling=featMat(sIndex,:);
    
    %%Cleaning and Normaling data
    disp('Cleaning and Normalizing Scrolling dataset');
    
    scrolling=cleaningdataset(scrolling);
    
    %removing userid before normalize
    users=scrolling(:,1);
    scrolling(:,1)=[];
    
    scrolling=zscore(scrolling);
    scrolling=[users,scrolling];
    save('scrolling data.mat','scrolling');
    
    %Getting the index of horizontal strokes
    hIndex=featMat(:,2)==4|featMat(:,2)==5|featMat(:,2)==7;
    horizontal=featMat(hIndex,:);
    
    disp('Cleaning and Normalizing Horizontal dataset');
    
    horizontal=cleaningdataset(horizontal);
    
    %removing userid before normalize
    users=horizontal(:,1);
    horizontal(:,1)=[];
    
    horizontal=zscore(horizontal);
    horizontal=[users,horizontal];
    save('horizontal data.mat','horizontal');
    
elseif option==0
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
elseif option==2 || option==3 || option==4 || option==5
    %% Generating scrolling BioHashing Data by User
    
    
    load(strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_');
    
    load('scrolling data.mat','scrolling');
    usersSize=length(unique(scrolling(:,1)));
    for user=1:usersSize
        disp(strcat('Processing User_ ',num2str(user)));
        userS=num2str(user);
        
        %loading biohashing training and test data
        load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
        load(strcat(prefix,userS,'/testSet.mat'),'testSet');
        
        %generating biohashing training and test data
        if option==2
            disp('Generating Heterogeneous - Unknown key BioHashing Data');
            filePath=strcat(strcat(pwd(),'/Data/',num2str(keySize),'/Scrolling/BioHashing/Hete_Un_Key/User_',userS));
            generatingBioHashingTraining(trainingSet,userS,filePath,2,keySize);
            generatingBioHashingTest(testSet,userS,filePath,2,keySize);
        elseif option==3
            disp('Generating Homogeneous - Unknown key BioHashing Data');
            filePath=strcat(strcat(pwd(),'/Data/',num2str(keySize),'/Scrolling/BioHashing/Homo_Un_Key/User_',userS));
            generatingBioHashingTraining(trainingSet,user,filePath,4,keySize);
            generatingBioHashingTest(testSet,user,filePath,4,keySize);
        elseif option==4
            disp('Generating Homogeneous - know key BioHashing Data');
            filePath=strcat(strcat(pwd(),'/Data/',num2str(keySize),'/Scrolling/BioHashing/Homo_Key/User_',userS));
            generatingBioHashingTraining(trainingSet,user,filePath,3,keySize);
            generatingBioHashingTest(testSet,user,filePath,3,keySize);
        elseif option==5
            disp('Generating Heterogeneous - know key BioHashing Data');
            filePath=strcat(strcat(pwd(),'/Data/',num2str(keySize),'/Scrolling/BioHashing/Hete_Key/User_',userS));
            generatingBioHashingTraining(trainingSet,user,filePath,1,keySize);
            generatingBioHashingTest(testSet,user,filePath,1,keySize);
        end
    end
    
    %% Generating Horizontal BioHashing Data by User
    
    load(strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_');
    
    load('horizontal data.mat','horizontal');
    usersSize=length(unique(horizontal(:,1)));
    
    for user=1:usersSize
        disp(strcat('Processing User_ ',num2str(user)));
        userS=num2str(user);
        
        %loading biohashing training and test data
        load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
        load(strcat(prefix,userS,'/testSet.mat'),'testSet');
        
        %generating biohashing training and test data
        if option==2
            disp('Generating Heterogeneous - Unknown key BioHashing Data');
            filePath=strcat(pwd(),'/Data/',num2str(keySize),'/Horizontal/BioHashing/Hete_Un_Key/User_',userS);
            generatingBioHashingTraining(trainingSet,userS,filePath,2,keySize);
            generatingBioHashingTest(testSet,userS,filePath,2,keySize);
        elseif option==3
            disp('Generating Homogeneous - Unknown key BioHashing Data');
            filePath=strcat(pwd(),'/Data/',num2str(keySize),'/Horizontal/BioHashing/Homo_Un_Key/User_',userS);
            generatingBioHashingTraining(trainingSet,user,filePath,4,keySize);
            generatingBioHashingTest(testSet,user,filePath,4,keySize);
        elseif option==4
            disp('Generating Homogeneous - know key BioHashing Data');
            filePath=strcat(pwd(),'/Data/',num2str(keySize),'/Horizontal/BioHashing/Homo_Key/User_',userS);
            generatingBioHashingTraining(trainingSet,user,filePath,3,keySize);
            generatingBioHashingTest(testSet,user,filePath,3,keySize);
        elseif option==5
            disp('Generating Heterogeneous - know key BioHashing Data');
            filePath=strcat(pwd(),'/Data/',num2str(keySize),'/Horizontal/BioHashing/Hete_Key/User_',userS);
            generatingBioHashingTraining(trainingSet,user,filePath,1,keySize);
            generatingBioHashingTest(testSet,user,filePath,1,keySize);
        end
    end
    
elseif option==6 || option==7 || option==8 || option==9
    
    %% Generating scrolling BioConvolving Data by User
    load(strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_');
    
    load('scrolling data.mat','scrolling');
    usersSize=length(unique(scrolling(:,1)));
    for user=1:usersSize
        disp(strcat('Processing User_ ',num2str(user)));
        userS=num2str(user);
        
        %loading training and test data
        load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
        load(strcat(prefix,userS,'/testSet.mat'),'testSet');
        
        %generating bioconvolving training and test data
        if option==6
            disp('Generating Heterogeneous - Unknown key BioConvolving Data');
            filePath=strcat(strcat(pwd(),'/Data/',num2str(keySize),'/Scrolling/BioConvolving/Hete_Un_Key/User_',userS));
            generatingBioConvolvingTraining(trainingSet,userS,filePath,2,keySize);
            generatingBioConvolvingTest(testSet,userS,filePath,2,keySize);
        elseif option==7
            disp('Generating Homogeneous - Unknown key BioConvolving Data');
            filePath=strcat(strcat(pwd(),'/Data/',num2str(keySize),'/Scrolling/BioConvolving/Homo_Un_Key/User_',userS));
            generatingBioConvolvingTraining(trainingSet,user,filePath,4,keySize);
            generatingBioConvolvingTest(testSet,user,filePath,4,keySize);
        elseif option==8
            disp('Generating Homogeneous - know key BioConvolving Data');
            filePath=strcat(strcat(pwd(),'/Data/',num2str(keySize),'/Scrolling/BioConvolving/Homo_Key/User_',userS));
            generatingBioConvolvingTraining(trainingSet,user,filePath,3,keySize);
            generatingBioConvolvingTest(testSet,user,filePath,3,keySize);
        elseif option==9
            disp('Generating Heterogeneous - know key BioConvolving Data');
            filePath=strcat(strcat(pwd(),'/Data/',num2str(keySize),'/Scrolling/BioConvolving/Hete_Key/User_',userS));
            generatingBioConvolvingTraining(trainingSet,user,filePath,1,keySize);
            generatingBioConvolvingTest(testSet,user,filePath,1,keySize);
        end
    end
    
    %% Generating Horizontal BioConvolving Data by User
    
    load(strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_');
    
    load('horizontal data.mat','horizontal');
    usersSize=length(unique(horizontal(:,1)));
    for user=1:usersSize
        disp(strcat('Processing User_ ',num2str(user)));
        userS=num2str(user);
        
        %loading training and test data
        load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
        load(strcat(prefix,userS,'/testSet.mat'),'testSet');
        
        %generating bioconvolving training and test data
        if option==6
            disp('Generating Heterogeneous - Unknown key BioConvolving Data');
            filePath=strcat(pwd(),'/Data/',num2str(keySize),'/Horizontal/BioConvolving/Hete_Un_Key/User_',userS);
            generatingBioConvolvingTraining(trainingSet,userS,filePath,2,keySize);
            generatingBioConvolvingTest(testSet,userS,filePath,2,keySize);
        elseif option==7
            disp('Generating Homogeneous - Unknown key BioConvolving Data');
            filePath=strcat(pwd(),'/Data/',num2str(keySize),'/Horizontal/BioConvolving/Homo_Un_Key/User_',userS);
            generatingBioConvolvingTraining(trainingSet,user,filePath,4,keySize);
            generatingBioConvolvingTest(testSet,user,filePath,4,keySize);
        elseif option==8
            disp('Generating Homogeneous - know key BioConvolving Data');
            filePath=strcat(pwd(),'/Data/',num2str(keySize),'/Horizontal/BioConvolving/Homo_Key/User_',userS);
            generatingBioConvolvingTraining(trainingSet,user,filePath,3,keySize);
            generatingBioConvolvingTest(testSet,user,filePath,3,keySize);
        elseif option==9
            disp('Generating Heterogeneous - know key BioConvolving Data');
            filePath=strcat(pwd(),'/Data/',num2str(keySize),'/Horizontal/BioConvolving/Hete_Key/User_',userS);
            generatingBioConvolvingTraining(trainingSet,user,filePath,1,keySize);
            generatingBioConvolvingTest(testSet,user,filePath,1,keySize);
        end
    end
    
elseif option==10 || option==11 || option==12 || option==13
    disp('Generating Heterogeneous - Unknown key Interpolation Data');
    %% Generating scrolling Interpolation Data by User
    
    load(strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Scrolling/Original/User_Label/User_');
    
    load('scrolling data.mat','scrolling');
    
    usersSize=length(unique(scrolling(:,1)));
    
    for user=1:usersSize
        disp(strcat('Processing User_ ',num2str(user)));
        
        userS=num2str(user);
        
        %loading training and test data
        load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
        load(strcat(prefix,userS,'/testSet.mat'),'testSet');
        
        %generating iterpolation training and test data
        if option==10
            disp('Generating Heterogeneous - Unknown key Interpolation Data');
            filePath=strcat(strcat(pwd(),'/Data/',num2str(keySize),'/Scrolling/Interpolation/Hete_Un_Key/User_',userS));
            generatingInterpolationTraining(trainingSet,userS,filePath,2,keySize);
            generatingInterpolationTest(testSet,userS,filePath,2,keySize);
        elseif option==11
            disp('Generating Homogeneous - Unknown key Interpolation Data');
            filePath=strcat(strcat(pwd(),'/Data/',num2str(keySize),'/Scrolling/Interpolation/Homo_Un_Key/User_',userS));
            generatingInterpolationTraining(trainingSet,user,filePath,4,keySize);
            generatingInterpolationTest(testSet,user,filePath,4,keySize);
        elseif option==12
            disp('Generating Homogeneous - know key Interpolation Data');
            filePath=strcat(strcat(pwd(),'/Data/',num2str(keySize),'/Scrolling/Interpolation/Homo_Key/User_',userS));
            generatingInterpolationTraining(trainingSet,user,filePath,3,keySize);
            generatingInterpolationTest(testSet,user,filePath,3,keySize);
        elseif option==13
            disp('Generating Heterogeneous - know key Interpolation Data');
            filePath=strcat(strcat(pwd(),'/Data/',num2str(keySize),'/Scrolling/Interpolation/Hete_Key/User_',userS));
            generatingInterpolationTraining(trainingSet,user,filePath,1,keySize);
            generatingInterpolationTest(testSet,user,filePath,1,keySize);
        end
    end
    
    %% Generating Horizontal Interpolation Data by User
    
    load(strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_');
    
    load('horizontal data.mat','horizontal');
    usersSize=length(unique(horizontal(:,1)));
    for user=1:usersSize
        disp(strcat('Processing User_ ',num2str(user)));
        userS=num2str(user);
        
        %loading training and test data
        load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
        load(strcat(prefix,userS,'/testSet.mat'),'testSet');
        
        %generating Interpolation training and test data
        if option==10
            disp('Generating Heterogeneous - Unknown key Interpolation Data');
            filePath=strcat(pwd(),'/Data/',num2str(keySize),'/Horizontal/Interpolation/Hete_Un_Key/User_',userS);
            generatingInterpolationTraining(trainingSet,userS,filePath,2,keySize);
            generatingInterpolationTest(testSet,userS,filePath,2,keySize);
        elseif option==11
            disp('Generating Homogeneous - Unknown key Interpolation Data');
            filePath=strcat(pwd(),'/Data/',num2str(keySize),'/Horizontal/Interpolation/Homo_Un_Key/User_',userS);
            generatingInterpolationTraining(trainingSet,user,filePath,4,keySize);
            generatingInterpolationTest(testSet,user,filePath,4,keySize);
        elseif option==12
            disp('Generating Homogeneous - know key Interpolation Data');
            filePath=strcat(pwd(),'/Data/',num2str(keySize),'/Horizontal/Interpolation/Homo_Key/User_',userS);
            generatingInterpolationTraining(trainingSet,user,filePath,3,keySize);
            generatingInterpolationTest(testSet,user,filePath,3,keySize);
        elseif option==13
            disp('Generating Heterogeneous - know key Interpolation Data');
            filePath=strcat(pwd(),'/Data/',num2str(keySize),'/Horizontal/Interpolation/Hete_Key/User_',userS);
            generatingInterpolationTraining(trainingSet,user,filePath,1,keySize);
            generatingInterpolationTest(testSet,user,filePath,1,keySize);
        end
    end
    
    
elseif option==14 || option==15 || option==16 || option==17
    disp('Generating Heterogeneous - Unknown key Double Data');
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
        
        %loading training and test data
        load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
        load(strcat(prefix,userS,'/testSet.mat'),'testSet');
        
        %generating doublesum training and test data
        if option==14
            disp('Generating Heterogeneous - Unknown key DoubleSum Data');
            filePath=strcat(strcat(pwd(),'/Data/',num2str(keySize),'/Scrolling/DoubleSum/Hete_Un_Key/User_',userS));
            generatingDoubleSumTraining(trainingSet,userS,filePath,2,keySize);
            generatingDoubleSumTest(testSet,userS,filePath,2,keySize);
        elseif option==15
            disp('Generating Homogeneous - Unknown key DoubleSum Data');
            filePath=strcat(pwd(),'/Data/',num2str(keySize),'/Scrolling/DoubleSum/Homo_Un_Key/User_',userS);
            generatingDoubleSumTraining(trainingSet,user,filePath,4,keySize);
            generatingDoubleSumTest(testSet,user,filePath,4,keySize);
        elseif option==16
            disp('Generating Homogeneous - know key DoubleSum Data');
            filePath=strcat(pwd(),'/Data/',num2str(keySize),'/Scrolling/DoubleSum/Homo_Key/User_',userS);
            generatingDoubleSumTraining(trainingSet,user,filePath,3,keySize);
            generatingDoubleSumTest(testSet,user,filePath,3,keySize);
        elseif option==17
            disp('Generating Heterogeneous - know key DoubleSum Data');
            filePath=strcat(pwd(),'/Data/',num2str(keySize),'/Scrolling/DoubleSum/Hete_Key/User_',userS);
            generatingDoubleSumTraining(trainingSet,user,filePath,1,keySize);
            generatingDoubleSumTest(testSet,user,filePath,1,keySize);
        end
    end
    
    %% Generating Horizontal DoubleSum Data by User
    
    load(strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_1/trainingSet.mat'));
    prefix=strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_');
    
    load('horizontal data.mat','horizontal');
    usersSize=length(unique(horizontal(:,1)));
    for user=1:usersSize
        disp(strcat('Processing User_ ',num2str(user)));
        userS=num2str(user);
        
        %loading training and test data
        load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
        load(strcat(prefix,userS,'/testSet.mat'),'testSet');
        
        %generating doublesum training and test data
        if option==14
            disp('Generating Heterogeneous - Unknown key DoubleSum Data');
            filePath=strcat(strcat(pwd(),'/Data/',num2str(keySize),'/Horizontal/DoubleSum/Hete_Un_Key/User_',userS));
            generatingDoubleSumTraining(trainingSet,userS,filePath,2,keySize);
            generatingDoubleSumTest(testSet,userS,filePath,2,keySize);
        elseif option==15
            disp('Generating Homogeneous - Unknown key DoubleSum Data');
            filePath=strcat(pwd(),'/Data/',num2str(keySize),'/Horizontal/DoubleSum/Homo_Un_Key/User_',userS);
            generatingDoubleSumTraining(trainingSet,user,filePath,4,keySize);
            generatingDoubleSumTest(testSet,user,filePath,4,keySize);
        elseif option==16
            disp('Generating Homogeneous - know key DoubleSum Data');
            filePath=strcat(pwd(),'/Data/',num2str(keySize),'/Horizontal/DoubleSum/Homo_Key/User_',userS);
            generatingDoubleSumTraining(trainingSet,user,filePath,3,keySize);
            generatingDoubleSumTest(testSet,user,filePath,3,keySize);
        elseif option==17
            disp('Generating Heterogeneous - know key DoubleSum Data');
            filePath=strcat(pwd(),'/Data/',num2str(keySize),'/Horizontal/DoubleSum/Hete_Key/User_',userS);
            generatingDoubleSumTraining(trainingSet,user,filePath,1,keySize);
            generatingDoubleSumTest(testSet,user,filePath,1,keySize);
        end
    end
    
elseif option==18
    disp(strcat('Generatng and Ploting User_',num2str(user),'_Score Plot_',classifierName,'_',orientation,'_',biometricDataName,'_',keyType));
    
    %saving the scores in a file
    saveFilePath=scoreMatrixPath;
    
    %% Generating and Plot the Scores by users, cancelable function, stroke orientation and key type
    % Loading training data
    
    if strcmp(biometricDataName,'Original')
        % Loading training data
        load(strcat(pwd(),'/Data/',num2str(keySize)',orientation,'/',biometricDataName,'/User_Discre/User_',num2str(user),'/trainingSet.mat'));
        % Loading testData'
        load(strcat(pwd(),'/Data/',num2str(keySize)',orientation,'/',biometricDataName,'/User_Discre/User_',num2str(user),'/testSet.mat'));
    else
        % Loading training data
        load(strcat(pwd(),'/Data/',num2str(keySize)',orientation,'/',biometricDataName,'/',keyType,'/User_',num2str(user),'/trainingSet.mat'));
        % Loading testData
        load(strcat(pwd(),'/Data/',num2str(keySize)',orientation,'/',biometricDataName,'/',keyType,'/User_',num2str(user),'/testSet.mat'));
    end
    
    
    %saving the scores in a file
    [clientScore,impostorScore] = prediction(classifierName,trainingSet,trainUserLabels,testSet,testUserLabels,saveFilePath,user);
    
    save(strcat(saveFilePath,'/Score_User_',num2str(user),'.mat'),'clientScore','impostorScore');
    
    %Ploting the scores
    addpath('lib')
    wer(impostorScore,clientScore, [],1,[],1);
    savefig(strcat(saveFilePath,'/Score_User_',num2str(user)));
    
elseif option==19
    
    %% Generating and Plot the Scores by cancelable function, stroke orientation and key type
    addpath('lib')
    saveFilePath=scoreMatrixPath;
    
    disp(strcat('Generating and Ploting All Users Score Plot_',classifierName,'_',orientation,'_',biometricDataName,'_',keyType));
    
    uclientScore=[];
    uimpostorScore=[];
    for user=1:41
        disp(strcat('Processing User', num2str(user)));
        if strcmp(biometricDataName,'Original')
            % Loading training data
            load(strcat(pwd(),'/Data/',orientation,'/',biometricDataName,'/User_Discre/User_',num2str(user),'/trainingSet.mat'));
            % Loading testData
            load(strcat(pwd(),'/Data/',orientation,'/',biometricDataName,'/User_Discre/User_',num2str(user),'/testSet.mat'));
        else
            % Loading training data
            load(strcat(pwd(),'/Data/',num2str(keySize)','/',orientation,'/',biometricDataName,'/',keyType,'/User_',num2str(user),'/trainingSet.mat'));
            % Loading testData
            load(strcat(pwd(),'/Data/',num2str(keySize)','/',orientation,'/',biometricDataName,'/',keyType,'/User_',num2str(user),'/testSet.mat'));
        end
        
        %getting the scores
        [clientScore,impostorScore] = prediction(classifierName,trainingSet,trainUserLabels,testSet,testUserLabels,saveFilePath,user);
        
        wer(impostorScore,clientScore, [],1,[],1);
        
        %saving the scores in a file
        savefig(strcat(scorePlotsFigPath,'/Score_User_',num2str(user)));
        fig=openfig(strcat(scorePlotsFigPath,'/Score_User_',num2str(user),'.fig'),'invisible');
        saveas(fig,[scorePlotsJpgPath,'/Score_User_',num2str(user),'.jpg']);
        
        % I cant put [clientScore,uclientScore], i.e, organize by columns
        %because the dimensions of clientScore some times is different of uclientScore
        %Thus, the scores are organized by line, i.e, a giant column 1.
        uclientScore=[clientScore;clientScore];
        uimpostorScore=[impostorScore;impostorScore];
        
        
        save(strcat(saveFilePath,'/Score_User_',num2str(user),'.mat'),'clientScore','impostorScore');
    end
    %ploting the scores
    
    wer(uimpostorScore,uclientScore, [],1,[],1);
    savefig(strcat(scorePlotsFigPath,'/ScoreTotal'));
    fig=openfig(strcat(scorePlotsFigPath,'/ScoreTotal.fig'),'invisible');
    saveas(fig,[scorePlotsJpgPath,'/ScoreTotal.jpg']);
    clientScore=uclientScore;
    impostorScore=uimpostorScore;
    save(strcat(saveFilePath,'/Score_Total.mat'),'clientScore','impostorScore');
    
elseif option==20
    addpath('lib')
    % Loading score matrix
    disp(strcat('Ploting User_',num2str(user),'_Score Plot_',classifierName,'_',orientation,'_',biometricDataName,'_',keyType));
    saveFilePath=scoreMatrixPath;
    
    load(strcat(saveFilePath,'/Score_User_',num2str(user),'.mat'),'clientScore','impostorScore');
    
    %ploting the scores
    addpath('lib')
    wer(impostorScore,clientScore, [],1,[],1);
    savefig(strcat(scorePlotsFigPath,'/Score_User_',num2str(user)));
    fig=openfig(strcat(scorePlotsFigPath,'/Score_User_',num2str(user),'.fig'),'invisible');
    saveas(fig,[scorePlotsJpgPath,'/Score_User_',num2str(user),'.jpg']);
    
elseif option==21
    allClientScore=[];
    allImpostorScore=[];
    for user=1:41
        % Loading score matrix
        saveFilePath=scoreMatrixPath;
        load(strcat(saveFilePath,'/Score_User_',num2str(user),'.mat'),'clientScore','impostorScore');
        
        %storing the score to plot
        allClientScore=[allClientScore;clientScore];
        allImpostorScore=[allImpostorScore;impostorScore];
        
    end
    
    %ploting the scores
    addpath('lib')
    disp(strcat('Ploting All Users Score Plot_',classifierName,'_',orientation,'_',biometricDataName,'_',keyType));
    wer(allImpostorScore,allClientScore, [],1,[],1);
    savefig(strcat(scorePlotsFigPath,'/ScoreTotal'));
    fig=openfig(strcat(scorePlotsFigPath,'/ScoreTotal.fig'),'invisible');
    saveas(fig,[scorePlotsJpgPath,'/ScoreTotal.jpg']);
    
elseif option==22
    %loading the classifier
    saveFilePath=scoreMatrixPath;
    load(strcat(saveFilePath,'/Classifier_User_',num2str(user),'.mat'),'classifier');
    
    if strcmp(biometricDataName,'Original')
        % Loading training data
        load(strcat(pwd(),'/Data/',orientation,'/',biometricDataName,'/User_Discre/User_',num2str(user),'/trainingSet.mat'));
        % Loading testData
        load(strcat(pwd(),'/Data/',orientation,'/',biometricDataName,'/User_Discre/User_',num2str(user),'/testSet.mat'));
    else
        % Loading training data
        load(strcat(pwd(),'/Data/',num2str(keySize)',orientation,'/',biometricDataName,'/',keyType,'/User_',num2str(user),'/trainingSet.mat'));
        % Loading testData
        load(strcat(pwd(),'/Data/',num2str(keySize)',orientation,'/',biometricDataName,'/',keyType,'/User_',num2str(user),'/testSet.mat'));
    end
    
    %calculating the score
    [clientScore,impostorScore]=calculateScoreMatrix(classifier,trainingSet,trainUserLabels,testSet,testUserLabels);
    
    save(strcat(saveFilePath,'/Score_User_',num2str(user),'.mat'),'clientScore','impostorScore');
    
    %Ploting the scores
    addpath('lib')
    wer(impostorScore,clientScore, [],1,[],1);
    savefig(strcat(scorePlotsFigPath,'/Score_User_',num2str(user)));
    fig=openfig(strcat(scorePlotsFigPath,'/Score_User_',num2str(user),'.fig'),'invisible');
    saveas(fig,[scorePlotsJpgPath,'/Score_User_',num2str(user),'.jpg']);
    
elseif option==23
    uclientScore=[];
    uimpostorScore=[];
    for user=1:41
        %loading the classifier
        saveFilePath=scoreMatrixPath;
        load(strcat(saveFilePath,'/Classifier_User_',num2str(user),'.mat'),'classifier');
        
        if strcmp(biometricDataName,'Original')
            % Loading training data
            load(strcat(pwd(),'/Data/',orientation,'/',biometricDataName,'/User_Discre/User_',num2str(user),'/trainingSet.mat'));
            % Loading testData
            load(strcat(pwd(),'/Data/',orientation,'/',biometricDataName,'/User_Discre/User_',num2str(user),'/testSet.mat'));
        else
            % Loading training data
            load(strcat(pwd(),'/Data/',num2str(keySize)',orientation,'/',biometricDataName,'/',keyType,'/User_',num2str(user),'/trainingSet.mat'));
            % Loading testData
            load(strcat(pwd(),'/Data/',num2str(keySize)',orientation,'/',biometricDataName,'/',keyType,'/User_',num2str(user),'/testSet.mat'));
        end
        %calculating the score
        [clientScore,impostorScore] = calculateScoreMatrix(classifier,trainingSet,trainUserLabels,testSet,testUserLabels);
        uclientScore=[uclientScore;clientScore];
        uimpostorScore=[uimpostorScore;impostorScore];
        save(strcat(saveFilePath,'/Score_User_',num2str(user),'.mat'),'clientScore','impostorScore');
        
        %Ploting the scores
        addpath('lib')
        wer(impostorScore,clientScore, [],1,[],1);
        savefig(strcat(scorePlotsFigPath,'/Score_User_',num2str(user)));
        fig=openfig(strcat(scorePlotsFigPath,'/Score_User_',num2str(user),'.fig'),'invisible');
        saveas(fig,[scorePlotsJpgPath,'/Score_User_',num2str(user),'.jpg']);
    end
    
    clientScore=uclientScore;
    impostorScore=uimpostorScore;
    save(strcat(saveFilePath,'/Score_Total.mat'),'clientScore','impostorScore');
    
    wer(impostorScore,clientScore, [],1,[],1);
    savefig(strcat(scorePlotsFigPath,'/Score_Total'));
    fig=openfig(strcat(scorePlotsFigPath,'/ScoreTotal.fig'),'invisible');
    saveas(fig,[scorePlotsJpgPath,'/ScoreTotal.jpg']);
elseif option==24
    disp(['Printing the DET Curves of Original, Same and Different Key Experiments to keySize ',num2str(keySize),' using classifier ',classifierName,' for ',orientation,' Strokes']);
    
    %% Loading Original Scores
    [sheeps,wolves]=loadOriginalScore(keySize,classifierName,orientation);
    
    allClientScore=[];
    allImpostorScore=[];
    %% Loading Template Protection Scores in Same and Different Key Experiments
    keyType={'Homo_Un_Key','Hete_Un_Key'};
    for i=1:length(keyType)
        scoreMatrixPath=[pwd(),'/ScoreMatrix/',num2str(keySize),'/',classifierName,'/',orientation,'/',biometricDataName,'/',keyType{i}];
        for user=1:41
            % Loading score matrix
            saveFilePath=scoreMatrixPath;
            load(strcat(saveFilePath,'/Score_User_',num2str(user),'.mat'),'clientScore','impostorScore');
            
            %storing the score to plot
            allClientScore=[allClientScore;clientScore];
            allImpostorScore=[allImpostorScore;impostorScore];
        end
        
        sheeps=[sheeps,allClientScore];
        wolves=[wolves,allImpostorScore];
        allClientScore=[];
        allImpostorScore=[];
    end
    printDETCurve(wolves,sheeps,3,{'Original','Homo_Un_Key','Hete_Un_Key'});
    title({['DET - Key Size:',num2str(keySize),' Classifier:',upper(classifierName)],[' using ',upper(biometricDataName),'-', upper(orientation)]});
    
    savefig(strcat(detPlotsFigPath,'/DET_Total'));
    fig=openfig(strcat(detPlotsFigPath,'/DET_Total.fig'),'invisible');
    saveas(fig,[detPlotsJpgPath,'/DET_Total.jpg']);
end
end


