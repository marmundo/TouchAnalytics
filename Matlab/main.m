function main(option,classifierName,user, biometricDataName, keyType, orientation,keySize)
% option =
% -1:Cleaning and normalize data
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
% 14: Score Matrix Production to the user @user using the trained classifier
% @classifierName, biometreic Data @biometricDataName  and key type
% @keyType
% 15: Test Score Matrix Production using all users and the trained classifier
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

if option>9
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
    scrolling=zscore(scrolling);
    save('scrolling data.mat','scrolling');
    
    %Getting the index of horizontal strokes
    hIndex=featMat(:,2)==4|featMat(:,2)==5|featMat(:,2)==7;
    horizontal=featMat(hIndex,:);    
   
    disp('Cleaning and Normalizing Horizontal dataset');
   
    horizontal=cleaningdataset(horizontal);
    horizontal=zscore(horizontal);
    save('horizontal data.mat','horizontal');
    
elseif option==0
  %% Generating scrolling Original Data by User Label
  disp('Generating User Label Original');
  
  load('scrolling data.mat','scrolling');
  usersSize=length(unique(scrolling(:,1)));
  for user=1:usersSize
    disp(strcat('Processing User_ ',num2str(user)));
    generatingTrainingAndTest(scrolling,user,strcat(pwd(),'/Data/Scrolling/Original/User_Discre/'),option);
  end
  
  %% Generating Horizontal Original Data by User Label
  
  load('horizontal data.mat','horizontal');
  usersSize=length(unique(scrolling(:,1)));
  for user=1:usersSize
    disp(strcat('Processing User_ ',num2str(user)));
    
    %generating training and testing data
    generatingTrainingAndTest(horizontal,user,strcat(pwd(),'/Data/Horizontal/Original/User_Discre/'),option);
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
    filePath=strcat(pwd(),'/Data/',num2str(keySize),'/Scrolling/BioHashing/Same_Key/User_',userS);
    
    %loading and generating biohashing training data
    load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
    generatingBioHashingTraining(trainingSet,userS,filePath,1,keySize);
    
    %loading and generating biohashing test data
    load(strcat(prefix,userS,'/testSet.mat'),'testSet');
    generatingBioHashingTest(testSet,userS,filePath,1,keySize);
  end
  
  %% Generating Horizontal BioHashing Data by User
  
  load(strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_1/trainingSet.mat'));
  prefix=strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_');
  
  load('horizontal data.mat','horizontal');
  usersSize=length(unique(horizontal(:,1)));
  for user=1:usersSize
    disp(strcat('Processing User_ ',num2str(user)));
    userS=num2str(user);
    filePath=strcat(strcat(pwd(),'/Data/',num2str(keySize),'/Horizontal/BioHashing/Same_Key/User_',userS));
    
    %loading and generating biohashing training data
    load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
    generatingBioHashingTraining(trainingSet,userS,filePath,1,keySize);
    
    %loading and generating biohashing test data
    load(strcat(prefix,userS,'/testSet.mat'),'testSet');
    generatingBioHashingTest(testSet,userS,'',1,keySize);
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
    filePath=strcat(strcat(pwd(),'/Data/',num2str(keySize),'/Scrolling/BioHashing/Different_Key/User_',userS));
    
    %loading and generating biohashing training data
    load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
    generatingBioHashingTraining(trainingSet,userS,filePath,2,keySize);
    
    %loading and generating biohashing test data
    load(strcat(prefix,userS,'/testSet.mat'),'testSet');
    generatingBioHashingTest(testSet,userS,filePath,2,keySize);
  end
  
  %% Generating Horizontal BioHashing Data by User
  
  load(strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_1/trainingSet.mat'));
  prefix=strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_');
  
  load('horizontal data.mat','horizontal');
  usersSize=length(unique(horizontal(:,1)));
  for user=1:usersSize
    disp(strcat('Processing User_ ',num2str(user)));
    userS=num2str(user);
    filePath=strcat(pwd(),'/Data/',num2str(keySize),'/Horizontal/BioHashing/Different_Key/User_',userS);
    
    %loading and generating biohashing training data
    load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
    generatingBioHashingTraining(trainingSet,userS,filePath,2,keySize);
    
    %loading and generating biohashing test data
    load(strcat(prefix,userS,'/testSet.mat'),'testSet');
    generatingBioHashingTest(testSet,userS,filePath,2,keySize);
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
    filePath=strcat(strcat(pwd(),'/Data/',num2str(keySize),'/Scrolling/BioConvolving/Same_Key/User_'),userS);
    
    %loading and generating bioconvolving training data
    load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
    generatingBioConvolvingTraining(trainingSet,userS,filePath,1,keySize);
    
    %loading and generating bioconvolving test data
    load(strcat(prefix,userS,'/testSet.mat'),'testSet');
    generatingBioConvolvingTest(testSet,userS,filePath,1,keySize);
  end
  
  %% Generating Horizontal BioConvolving Data by User
  
  load(strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_1/trainingSet.mat'));
  prefix=strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_');
  
  load('horizontal data.mat','horizontal');
  usersSize=length(unique(horizontal(:,1)));
  for user=1:usersSize
    disp(strcat('Processing User_ ',num2str(user)));
    userS=num2str(user);
    filePath=strcat(strcat(pwd(),'/Data/',num2str(keySize),'/Horizontal/BioConvolving/Same_Key/User_',userS));
    
    %loading and generating bioconvolving training data
    load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
    generatingBioConvolvingTraining(trainingSet,userS,filePath,1,keySize);
    
    %loading and generating bioconvolving test data
    load(strcat(prefix,userS,'/testSet.mat'),'testSet');
    generatingBioConvolvingTest(testSet,userS,'',1,keySize);
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
    filePath=strcat(strcat(pwd(),'/Data/',num2str(keySize),'/Scrolling/BioConvolving/Different_Key/User_',userS));
    
    %loading and generating bioconvolving training data
    load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
    generatingBioConvolvingTraining(trainingSet,userS,filePath,2,keySize);
    
    %loading and generating bioconvolving test data
    load(strcat(prefix,userS,'/testSet.mat'),'testSet');
    generatingBioConvolvingTest(testSet,userS,filePath,2,keySize);
  end
  
  %% Generating Horizontal BioConvolving Data by User
  
  load(strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_1/trainingSet.mat'));
  prefix=strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_');
  
  load('horizontal data.mat','horizontal');
  usersSize=length(unique(horizontal(:,1)));
  for user=1:usersSize
    disp(strcat('Processing User_ ',num2str(user)));
    userS=num2str(user);
    filePath=strcat(pwd(),'/Data/',num2str(keySize),'/Horizontal/BioConvolving/Different_Key/User_',userS);
    
    %loading and generating bioconvolving training data
    load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
    generatingBioConvolvingTraining(trainingSet,userS,filePath,2,keySize);
    
    %loading and generating bioconvolving test data
    load(strcat(prefix,userS,'/testSet.mat'),'testSet');
    generatingBioConvolvingTest(testSet,userS,filePath,2,keySize);
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
    filePath=strcat(strcat(pwd(),'/Data/',num2str(keySize),'/Scrolling/Interpolation/Same_Key/User_'),userS);
    
    %loading and generating interpolation training data
    load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
    generatingInterpolationTraining(trainingSet,userS,filePath,1,keySize);
    
    %loading and generating interpolation test data
    load(strcat(prefix,userS,'/testSet.mat'),'testSet');
    generatingInterpolationTest(testSet,userS,filePath,1,keySize);
  end
  
  
  %% Generating Horizontal Interpolation Data by User
  
  load(strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_1/trainingSet.mat'));
  prefix=strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_');
  
  load('horizontal data.mat','horizontal');
  usersSize=length(unique(horizontal(:,1)));
  
  for user=1:usersSize
    disp(strcat('Processing User_ ',num2str(user)));
    userS=num2str(user);
    filePath=strcat(strcat(pwd(),'/Data/',num2str(keySize),'/Horizontal/Interpolation/Same_Key/User_',userS));
    
    %loading and generating interpolation training data
    load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
    generatingInterpolationTraining(trainingSet,userS,filePath,1,keySize);
    
    %loading and generating interpolation test data
    load(strcat(prefix,userS,'/testSet.mat'),'testSet');
    generatingInterpolationTest(testSet,userS,filePath,1,keySize);
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
    filePath=strcat(strcat(pwd(),'/Data/',num2str(keySize),'/Scrolling/Interpolation/Different_Key/User_',userS));
    
    %loading and generating interpolation training data
    load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
    generatingInterpolationTraining(trainingSet,userS,filePath,2,keySize);
    
    %loading and generating interpolation test data
    load(strcat(prefix,userS,'/testSet.mat'),'testSet');
    generatingInterpolationTest(testSet,userS,filePath,2,keySize);
  end
  
  %% Generating Horizontal Interpolation Data by User
  
  load(strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_1/trainingSet.mat'));
  prefix=strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_');
  
  load('horizontal data.mat','horizontal');
  usersSize=length(unique(horizontal(:,1)));
  for user=1:usersSize
    disp(strcat('Processing User_ ',num2str(user)));
    userS=num2str(user);
    filePath=strcat(pwd(),'/Data/',num2str(keySize),'/Horizontal/Interpolation/Different_Key/User_',userS);
    
    %loading and generating interpolation training data
    load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
    generatingInterpolationTraining(trainingSet,userS,filePath,2,keySize);
    
    %loading and generating interpolation test data
    load(strcat(prefix,userS,'/testSet.mat'),'testSet');
    generatingInterpolationTest(testSet,userS,filePath,2,keySize);
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
    filePath=strcat(strcat(pwd(),'/Data/',num2str(keySize),'/Scrolling/DoubleSum/Same_Key/User_'),userS);
    load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
    generatingDoubleSumTraining(trainingSet,userS,filePath,1,keySize);
    load(strcat(prefix,userS,'/testSet.mat'),'testSet');
    generatingDoubleSumTest(testSet,userS,filePath,1,keySize);
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
    filePath=strcat(strcat(pwd(),'/Data/',num2str(keySize),'/Horizontal/DoubleSum/Same_Key/User_',userS));
    
    %loading and generating double sum training data
    load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
    generatingDoubleSumTraining(trainingSet,userS,filePath,1,keySize);
    
    %loading and generating double sum test data
    load(strcat(prefix,userS,'/testSet.mat'),'testSet');
    generatingDoubleSumTest(testSet,userS,filePath,1,keySize);
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
    filePath=strcat(strcat(pwd(),'/Data/',num2str(keySize),'/Scrolling/DoubleSum/Different_Key/User_',userS));
    
    %loading and generating double sum training data
    load(strcat(prefix,userS,'/trainingSet.mat'), 'trainingSet');
    generatingDoubleSumTraining(trainingSet,userS,filePath,2,keySize);
    
    %loading and generating double sum test data
    load(strcat(prefix,userS,'/testSet.mat'),'testSet');
    generatingDoubleSumTest(testSet,userS,filePath,2,keySize);
  end
  
  %% Generating Horizontal DoubleSum Data by User
  
  load(strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_1/trainingSet.mat'));
  prefix=strcat(pwd(),'/Data/Horizontal/Original/User_Label/User_');
  
  load('horizontal data.mat','horizontal');
  usersSize=length(unique(horizontal(:,1)));
  for user=1:usersSize
    disp(strcat('Processing User_ ',num2str(user)));
    userS=num2str(user);
    filePath=strcat(pwd(),'/Data/',num2str(keySize),'/Horizontal/DoubleSum/Different_Key/User_',userS);
    load(strcat(prefix,userS,'/trainingSet.mat'));
    generatingDoubleSumTraining(trainingSet,userS,filePath,2,keySize);
    load(strcat(prefix,userS,'/testSet.mat'));
    generatingDoubleSumTest(testSet,userS,filePath,2,keySize);
  end
  
elseif option==10
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
  
elseif option==11
  
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
      load(strcat(pwd(),'/Data/',num2str(keySize)',orientation,'/',biometricDataName,'/',keyType,'/User_',num2str(user),'/trainingSet.mat'));
      % Loading testData
      load(strcat(pwd(),'/Data/',num2str(keySize)',orientation,'/',biometricDataName,'/',keyType,'/User_',num2str(user),'/testSet.mat'));
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
  
elseif option==12
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
  
elseif option==13
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
  
elseif option==14
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
  
elseif option==15
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
end


