%%
addpath ..
addpath ../lib
%%
clear
load('scrolling data.mat');

%% cleaning
scrolling=cleaningdataset(scrolling);
zero_ = find(sum(scrolling)==0);
scrolling(:,zero_)=[];

%% check the numbers
for i=1:size(scrolling,2),
  unique_count(i) = numel(unique(scrolling(:,i)));
end;
% %%
% bar(unique_count);
% ylabel('Unique values');
% xlabel('Feature index');
% print('-dpng','Pictures/main_norman__unique_value_feature_count.png');
%% normalise
selected_ = find(unique_count>50); %selected_features
ID=scrolling(:,1);
data=(scrolling(:,selected_)); %Why have you take only the features with more than 50 unique values?
%data=zscore(scrolling(:,[2:end]));
clear scrolling
%%
ID_list = unique(ID)';

%% Aplying DoubleSum protection method
key=getFixedKey('DoubleSum',length(selected_));
data=doublesum(data,key);


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

runExperiments(data,selected_user,ID_list,TRAIN,TRAIN_IMP,VALID,VALID_IMP,TEST,TEST_IMP);