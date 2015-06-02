function scores=main_norman_biohashing(biometricData,scenario)
%%
addpath ..
addpath ../lib
%%

%% cleaning
biometricData=cleaningdataset(biometricData);
zero_ = find(sum(biometricData)==0);
biometricData(:,zero_)=[];

%% check the numbers
for i=1:size(biometricData,2),
    unique_count(i) = numel(unique(biometricData(:,i)));
end;
% %%
% bar(unique_count);
% ylabel('Unique values');
% xlabel('Feature index');
% print('-dpng','Pictures/main_norman__unique_value_feature_count.png');
%% normalise
selected_ = find(unique_count>50); %selected_features
ID=biometricData(:,1);
data=(biometricData(:,selected_)); %Why have you take only the features with more than 50 unique values?
%data=zscore(scrolling(:,[2:end]));
clear biometricData;
%%
ID_list = unique(ID)';


%% 3-fold;
% fold 1 is for training the classifier
% fold 2 for validation
% fold 3 for testing
c = cvpartition(ID,'KFold',3);
%%
for p=1:3,
    [sum(c.training(p)) sum(c.test(p))]
end;

%% analyse the test folds
clear selected_user;
for p=1:3,
    selected_user{p}=cell(1,41);
    for i=1:numel(ID_list), %number of elements in ID_list
        selected_user{p}{i} = find(c.test(p) &   ID==ID_list(i))';
    end;
end;

%% The data set of each user is divided into three sets
for p=1:3,
    n_samples_TRAIN(p,:) = cellfun( @(x) numel(x), selected_user{p});
end;

%%
TRAIN=1;
VALID=2;
TEST=3;
TRAIN_IMP=1:20; %impostor used for training
VALID_IMP=21:40;%impostor used for validation
TEST_IMP =21:40;%impostor used for validation

keySize=1;
keySize=round(length(selected_)*keySize);

%% Aplying Interpolation protection method
if strcmp(scenario,'Homo_K') || strcmp(scenario,'Hete_K')
    %% Aplying Interpolation protection method
    key=getFixedKey('BioHashing',length(selected_));
    data=biohashing(data,key);
    data=double(data);
    
elseif strcmp(scenario,'Homo_UK') || strcmp(scenario,'Hete_UK')
    for i=1:numel(ID_list),
        %% Take the client sample
        %positive training samples
        index_template = selected_user{TRAIN}{i}; %use all the available samples for training
        index_template_valid = selected_user{VALID}{i}; %use all the available samples for training
        %% Encode the client sample with a key
        if strcmp(scenario,'Homo_UK')
            key=getFixedKey('BioHashing',length(selected_));
            data(index_template,:)=biohashing(data(index_template,:),key);
            data(index_template_valid,:)=biohashing(data(index_template_valid,:),key);
        else
            key=rand(keySize);
            data(index_template,:)=biohashing(data(index_template,:),key);
            data(index_template_valid,:)=biohashing(data(index_template_valid,:),key);
        end
        
        %negative training samples
        userlist = find(ID_list ~= i);
        userlist = userlist(TRAIN_IMP);
        %% For all impostors take the samples of each impostor user
        for iUser=1:numel(userlist)
            index_template_neg = cell2mat(cellfun(@(x) x(1:10), selected_user{TRAIN}( iUser ), 'UniformOutput', false));
            index_template_neg_valid = cell2mat(cellfun(@(x) x(1:10), selected_user{VALID}( iUser ), 'UniformOutput', false));
            key=rand(keySize);
            %% Encode the impostor user, encode its data with a key
            data(index_template_neg,:)=biohashing(data(index_template_neg,:),key);
            data(index_template_neg_valid,:)=biohashing(data(index_template_neg_valid,:),key);
        end
    end;
end

scores=runExperiments(data,selected_user,ID_list,TRAIN,TRAIN_IMP,VALID,VALID_IMP,TEST,TEST_IMP);
return
end