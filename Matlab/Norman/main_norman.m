function scores=main_norman(biometricData)
%%
addpath ..
addpath ../lib
%%
orientation='Scrolling';
%orientation='Horizontal';

if strcmp(orientation,'Scrolling')
    load('scrolling data.mat');
    biometricData=scrolling;
    clear scrolling;
else
    load('horizontal data.mat');
    biometricData=horizontal;
    clear horizontal;
end

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
clear scrolling
%%
ID_list = unique(ID)';

%% PCA
% [coeff,score,latent,tsquared]  = pca(data);

%% plot
% gscatter(score(:,1), score(:,2), ID);

%%
% imagesc(score)

%%
% for i=1:12, % numel(ID_list),
%   subplot(3,4,i);
%   boxplot(data(ID_list(i)==ID, :),'outliersize',1)
%   %bar(mean(data(ID_list(i)==ID, :))); axis tight
%   axis([ 0.5000   25.5000  -5 5]);
% end;

%% 3-fold; 
% fold 1 is for training the classifier
% fold 2 for validation
% fold 3 for testing
c = cvpartition(ID,'KFold',3);
%%
for p=1:3,
  [sum(c.training(p)) sum(c.test(p))]
end;
%% How many samples are there per user?
% for i=1:numel(ID_list),
%   n_samples(i) = sum(ID_list(i)==ID);
% end;
% bar(n_samples);
% xlabel('User index');
% ylabel('Number of samples per user');
% print('-dpng','Pictures/main_norman__data_samples.png');

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

n_samples_TRAIN

%% minimum # of training samples
min_train_samples = min(min(n_samples_TRAIN))

%%
TRAIN=1;
VALID=2;
TEST=3;
TRAIN_IMP=1:20; %impostor used for training
VALID_IMP=21:40;%impostor used for validation
TEST_IMP =21:40;%impostor used for validation




%% tune k-NN

% gen_=[];
% imp_=[];
% 
% for i=1:numel(ID_list),
% 
%   index_gen = selected_user{VALID}{i};
%   
%   userlist = find(ID_list ~= i);
%   userlist = userlist(VALID_IMP);
%   index_imp = cell2mat(cellfun(@(x) x(1:10), selected_user{VALID}( userlist ), 'UniformOutput', false));
%   
%   gen__=zeros(numel(index_gen),10);
%   imp__=zeros(numel(index_imp),10);
%   
%   for knn=1:10,
%     com.knn.mdl{i}.NumNeighbors = knn;
%     [~, gen___] = predict( com.knn.mdl{i}, data(selected_user{VALID}{i},:));
%     [~, imp___] = predict( com.knn.mdl{i}, data(index_imp,:));  
%     gen__(:,knn) = gen___(:,2);
%     imp__(:,knn) = imp___(:,2);
%   end;
%   gen_=[gen_;gen__];
%   imp_=[imp_;imp__];
%   
% end;
%% check what works for k-NN
% for knn=1:10,
%   eer_knn(knn) = wer(imp_(:,knn),gen_(:,knn));
% end;
% %%
% bar(eer_knn)
% found k=4 to be best

scores=runExperiments(data,selected_user,ID_list,TRAIN,TRAIN_IMP,VALID,VALID_IMP,TEST,TEST_IMP,orientation);
return
end