clear all;
addpath ..
addpath ../lib

%% load the data
%orientation='Scrolling';
orientation='Horizontal';

if strcmp(orientation,'Scrolling')
  load('scrolling data.mat');
  data=scrolling;
  clear scrolling;
else
  load('horizontal data.mat');
  data=horizontal;
  clear horizontal;
end

data=cleaningdataset(data);
zero_ = find(sum(data)==0);
data(:,zero_)=[];

% check the numbers
for i=1:size(data,2),
  unique_count(i) = numel(unique(data(:,i)));
end;

% bar(unique_count);
% ylabel('Unique values');
% xlabel('Feature index');
%print('-dpng','Pictures/main_norman__unique_value_feature_count.png');

% normalise
selected_ = find(unique_count>50);
ID=data(:,1);
data=(data(:,selected_));

ID_list = unique(ID)';

%% analyse the test folds (should be 1/3)
if strcmp(orientation,'Horizontal')
  if exist('c_horizontal.mat', 'file'),
    load c_horizontal.mat
  else
    c = cvpartition(ID,'KFold',3);
    save c_horizontal.mat c
  end;
else
  if exist('c_scrolling.mat', 'file'),
    load c_scrolling.mat
  else
    c = cvpartition(ID,'KFold',3);
    save c_scrolling.mat c
  end;
end

clear selected_user;
for p=1:3,
  selected_user{p}=cell(1,41);
  for i=1:numel(ID_list),
    selected_user{p}{i} = find(c.test(p) &   ID==ID_list(i))';
  end;
end;

%%
TRAIN=1;
VALID=2;
TEST=3;
TRAIN_IMP=1:20; %impostor used for training
VALID_IMP=21:40;%impostor used for validation
TEST_IMP =21:40;%impostor used for test

%% load the common key
keySize.nFeatures=length(data(1,:));
keySize.partitions=25;
key=getFixedKey('BioConvolving',keySize);

scenario={'homo','hete'};
%%
for s=1:2
  %% train classifiers in the bioconvolving domain
  for i=1:numel(ID_list),
    
    %positive training samples
    index_template = selected_user{TRAIN}{i}; %use all the available samples for training
    
    %negative training samples
    userlist = find(ID_list ~= i);
    userlist = userlist(TRAIN_IMP);
    %index_template_neg = cell2mat(cellfun(@(x) x(1:10), selected_user{TRAIN}( userlist ), 'UniformOutput', false));
    
    %for each user, the template is encrypted using one common key; and the attacker
    %uses another key for nonmatch
    X_imp=[];
    for iUser=1:numel(userlist)
      index_template_neg = cell2mat(cellfun(@(x) x(1:10), selected_user{TRAIN}( iUser ), 'UniformOutput', false));
      key_imp =generateBioConvolvingKey(keySize.partitions,keySize.nFeatures);
      % Encode the impostor user, encode its data with a key
      p_data=bioconvolving(data(index_template_neg,:),key_imp);
      X_imp = [X_imp;p_data];
    end
    %key_imp = rand(dim);
    if strcmp(scenario{s},'homo')
      X_gen =bioconvolving(data(index_template,:),key);
    else
      com.user.key{i} = generateBioConvolvingKey(keySize.partitions,keySize.nFeatures);
      X_gen =bioconvolving(data(index_template,:),com.user.key{i});
    end
    %X_imp = double(bioconvolving(data(index_template_neg,:),key_imp));
    
    index_template_neg = cell2mat(cellfun(@(x) x(1:10), selected_user{TRAIN}( userlist ), 'UniformOutput', false));
    %logistic regression
    Y = [ones(1, numel(index_template)) zeros(1, numel(index_template_neg))];
    W = [ones(1, numel(index_template)) / numel(index_template) ones(1, numel(index_template_neg)) /numel(index_template_neg) ];
%     com.user.b(i,:) = glmfit([X_gen; X_imp],Y', 'binomial', 'weights',W');
    
    %k-NN
%     com.knn.mdl{i} = fitcknn([X_gen; X_imp],Y');
    
    %SVM
    com.svm{i}=fitcsvm([X_gen;X_imp],Y','KernelFunction','rbf','Standardize',true,'KernelScale','auto');
    %com.svm{i} = fitSVMPosterior(com.svm{i});
  end;
%   bar(median(com.user.b))
%   com.median.b = median(com.user.b);
  
  %% Compare the 4 methods
  % (SIMILAR to main_norman.m)
  clear score*;
  for k=1:2,
    for m=1:5,
      scores{k,m}=[];
    end;
  end;
  
  %% Testing
  for i=1:numel(ID_list),
    
    %positive training samples
    index_gen = selected_user{VALID}{i}; %use all the available samples for training
    
    %impostor scores -- select only 10 samples from the VALIDATION set
    userlist = find(ID_list ~= i);
    userlist = userlist(VALID_IMP);
    %index_imp = cell2mat(cellfun(@(x) x(1:10), selected_user{VALID}( userlist ), 'UniformOutput', false));
    X_imp=[];
    %for each user, the template is encrypted using one common key; and the attacker
    %   uses another key for nonmatch
    for iUser=1:numel(userlist)
      index_imp  = cell2mat(cellfun(@(x) x(1:10), selected_user{VALID}( iUser ), 'UniformOutput', false));
      key_imp = generateBioConvolvingKey(keySize.partitions,keySize.nFeatures);
      % Encode the impostor user, encode its data with a key
      X_imp = [X_imp;bioconvolving(data(index_imp,:),key_imp)];
    end
    %key_imp = rand(dim);
    if strcmp(scenario{s},'homo')
      X_gen = bioconvolving(data(index_gen,:),key);
    else
      X_gen = bioconvolving(data(index_gen,:),com.user.key{i});
    end
    %X_imp = double(bioconvolving(data(index_imp,:),key_imp));
    
    
%     METHOD 2: logistic regression
%     m=2;
%     score_gen{m} = glmval(com.user.b(i,:)', X_gen,'identity');
%     score_imp{m} = glmval(com.user.b(i,:)', X_imp,'identity');
%     
%     METHOD 3: logistic regression
%     m=3;
%     score_gen{m} = glmval(com.median.b', X_gen,'identity');
%     score_imp{m} = glmval(com.median.b', X_imp,'identity');
    
    %METHOD 4: K-NN
%     m=4;
%     com.knn.mdl{i}.NumNeighbors = 8;%4
%     [~, gen_] = predict( com.knn.mdl{i}, X_gen);
%     [~, imp_] = predict( com.knn.mdl{i}, X_imp);
%     score_gen{m}=gen_(:,2);
%     score_imp{m}=imp_(:,2);
    
    %METHOD 5: SVM
    m=5;
    [~,gen_] =predict(com.svm{i},X_gen);
    [~,imp_] =predict(com.svm{i},X_imp);
    score_gen{m}=gen_(:,2);
    score_imp{m}=imp_(:,2);
    
    %record down the scores
    for m=5:5,
      scores{1,m} = [scores{1,m}; score_imp{m}];
      scores{2,m} = [scores{2,m}; score_gen{m}];
    end;
    
      %cleaning in case of NaN and Inf
  scores{1,m}(isnan(scores{1,m})) = 0 ;
  scores{1,m}(isinf(scores{1,m})) = -100000;
  scores{2,m}(isnan(scores{2,m})) = 0 ;
  scores{2,m}(isinf(scores{2,m})) = -100000;
  
    for m=5:5,
eer_(i,m) = wer(scores{1,m}, scores{2,m});
      %eer_(i,m) = wer(score_imp{m}, score_gen{m}, [],2,[],m);
    end;
    %pause;
    fprintf(1,'.');
  end;
  fprintf(1,'\n');
  fileName=['main_norman_bioconvolving_',scenario{s},'_Unknown-',orientation,'-kSize-',num2str(keySize.partitions)];
  extension='.mat';
  save([fileName,extension],'scores');
  
  %%
  figure(2);
  for m=5:5,
    eer_system(m) = wer(scores{1,m}, scores{2,m}, [],2,[],m);
  end;
  eer_system
  legend('LR user-specific','LR common', 'kNN (8)','location', 'Southwest');
  file=['Pictures/',fileName,'__DET_Euc_LR_kNN.png'];
  print('-dpng',file);
  
  %% compare with main_norman
%   bline = load(['main_norman-',orientation,'.mat']);
%   bconvolving = load(['main_norman_bioconvolving_',scenario{s},'_known-',orientation]);
%   
%   figure(3);
%   m=5;
%   wer(bline.scores{1,m}, bline.scores{2,m}, [],2,[],1);
%   wer(bconvolving.scores{1,m}, bconvolving.scores{2,m}, [],2,[],2);
%   wer(scores{1,m}, scores{2,m}, [],2,[],3);
%   legend('baseline','bioconvolving Known','bioconvolving Unknown');
%   file=['Pictures/DET_kNN_bline_vs_bioconvolving-',orientation,'-',scenario{s},'_Unknown.png'];
%   print('-dpng',file);
end

%% main_norman_bioconvolving_
bline = load(['main_norman-',orientation,'.mat']);
bioconvolving_known_homo=load(['main_norman_bioconvolving_homo_known-',orientation,'-kSize-',num2str(keySize.partitions),'.mat']);
bioconvolving_known_hetero=load(['main_norman_bioconvolving_hete_known-',orientation,'-kSize-',num2str(keySize.partitions),'.mat']);
bioconvolving_unknown_homo = load(['main_norman_bioconvolving_homo_Unknown-',orientation,'-kSize-',num2str(keySize.partitions),'.mat']);
bioconvolving_unknown_hetero = load(['main_norman_bioconvolving_hete_Unknown-',orientation,'-kSize-',num2str(keySize.partitions),'.mat']);
close all;
figure(3);
m=5;
wer(bline.scores{1,m}, bline.scores{2,m}, [],2,[],1);
%wer(bconvolving.scores{1,m}, bconvolving.scores{2,m}, [],2,[],2);
wer(bioconvolving_known_homo.scores{1,m}, bioconvolving_known_homo.scores{2,m}, [],2,[],2);
wer(bioconvolving_known_hetero.scores{1,m}, bioconvolving_known_hetero.scores{2,m}, [],2,[],3);
wer(bioconvolving_unknown_homo.scores{1,m}, bioconvolving_unknown_homo.scores{2,m}, [],2,[],4);
wer(bioconvolving_unknown_hetero.scores{1,m}, bioconvolving_unknown_hetero.scores{2,m}, [],2,[],5);
classifiers={'','Logistic per User','Logistic per data','kNN','SVM'};
title({['DET - Classifier: ',classifiers{m},' using BioConvolving-',orientation]});
legend('Baseline','BioConvolving Known (homo)', 'BioConvolving Known (hetero)','BioConvolving Unknown (homo)', 'BioConvolving Unknown (hetero)');
file=['Pictures/DET_Comparative/DET_',classifiers{m},'_bline_vs_bioconvolving(homovshete)-',orientation,'.png'];
print('-dpng',file);

%%
% figure(4);
% wer(bconvolving.scores{1,m}, bconvolving.scores{2,m}, [],4,[],1);
% wer(scores{1,m}, scores{2,m}, [],4,[],2);
%%

%%
%Key Size Plots - Unknown Attack
%%
orientation='Horizontal';
m=5;
bconvolving_unknown_homo2 = load(['main_norman_bioconvolving_homo_Unknown-',orientation,'-kSize-2.mat']);
bconvolving_unknown_homo3 = load(['main_norman_bioconvolving_homo_Unknown-',orientation,'-kSize-3.mat']);
bconvolving_unknown_homo4 = load(['main_norman_bioconvolving_homo_Unknown-',orientation,'-kSize-4.mat']);
bconvolving_unknown_homo8 = load(['main_norman_bioconvolving_homo_Unknown-',orientation,'-kSize-8.mat']);
bconvolving_unknown_homo16 = load(['main_norman_bioconvolving_homo_Unknown-',orientation,'-kSize-16.mat']);
bconvolving_unknown_homo25 = load(['main_norman_bioconvolving_homo_Unknown-',orientation,'-kSize-25.mat']);
figure(6)
wer(bline.scores{1,m}, bline.scores{2,m}, [],2,[],1);
wer(bconvolving_unknown_homo2.scores{1,m}, bconvolving_unknown_homo2.scores{2,m}, [],2,[],2);
wer(bconvolving_unknown_homo3.scores{1,m}, bconvolving_unknown_homo3.scores{2,m}, [],2,[],3);
wer(bconvolving_unknown_homo4.scores{1,m}, bconvolving_unknown_homo4.scores{2,m}, [],2,[],4);
wer(bconvolving_unknown_homo8.scores{1,m}, bconvolving_unknown_homo8.scores{2,m}, [],2,[],5);
wer(bconvolving_unknown_homo16.scores{1,m}, bconvolving_unknown_homo16.scores{2,m}, [],2,[],6);
wer(bconvolving_unknown_homo25.scores{1,m}, bconvolving_unknown_homo25.scores{2,m}, [],2,[],7);
legend('baseline','kSize=2','kSize=3','kSize=4','kSize=8','kSize=16','kSize=25');
title(['DET Comparison KeySize - BioConvolving - Unknown- Homogeneous-',orientation])
file=['Pictures/DET_Comparative/KeySize-DET_kNN_bline_vs_bioconvolving-',orientation,'-',scenario{1},'_Unknown.png'];
print('-dpng',file);

%%

bline = load(['main_norman-',orientation,'.mat']);
bconvolving_unknown_hete2 = load(['main_norman_bioconvolving_hete_Unknown-',orientation,'-kSize-2.mat']);
bconvolving_unknown_hete3 = load(['main_norman_bioconvolving_hete_Unknown-',orientation,'-kSize-3.mat']);
bconvolving_unknown_hete4 = load(['main_norman_bioconvolving_hete_Unknown-',orientation,'-kSize-4.mat']);
bconvolving_unknown_hete8 = load(['main_norman_bioconvolving_hete_Unknown-',orientation,'-kSize-8.mat']);
bconvolving_unknown_hete16 = load(['main_norman_bioconvolving_hete_Unknown-',orientation,'-kSize-16.mat']);
bconvolving_unknown_hete25 = load(['main_norman_bioconvolving_hete_Unknown-',orientation,'-kSize-25.mat']);
figure(7)
wer(bline.scores{1,m}, bline.scores{2,m}, [],2,[],1);
wer(bconvolving_unknown_hete2.scores{1,m}, bconvolving_unknown_hete2.scores{2,m}, [],2,[],2);
wer(bconvolving_unknown_hete3.scores{1,m}, bconvolving_unknown_hete3.scores{2,m}, [],2,[],3);
wer(bconvolving_unknown_hete4.scores{1,m}, bconvolving_unknown_hete4.scores{2,m}, [],2,[],4);
wer(bconvolving_unknown_hete8.scores{1,m}, bconvolving_unknown_hete8.scores{2,m}, [],2,[],5);
wer(bconvolving_unknown_hete16.scores{1,m}, bconvolving_unknown_hete16.scores{2,m}, [],2,[],6);
wer(bconvolving_unknown_hete25.scores{1,m}, bconvolving_unknown_hete25.scores{2,m}, [],2,[],7);
legend('baseline','kSize=2','kSize=3','kSize=4','kSize=8','kSize=16','kSize=25');
title(['DET Comparison KeySize - BioConvolving - Unknown- Heterogeneous-',orientation])
file=['Pictures/DET_Comparative/KeySize-DET_kNN_bline_vs_bioconvolving-',orientation,'-',scenario{2},'_Unknown.png'];
print('-dpng',file);


%% Known Key Attack
%%
bconvolving_known_homo2 = load(['main_norman_bioconvolving_homo_known-',orientation,'-kSize-2.mat']);
bconvolving_known_homo3 = load(['main_norman_bioconvolving_homo_known-',orientation,'-kSize-3.mat']);
bconvolving_known_homo4 = load(['main_norman_bioconvolving_homo_known-',orientation,'-kSize-4.mat']);
bconvolving_known_homo8 = load(['main_norman_bioconvolving_homo_known-',orientation,'-kSize-8.mat']);
bconvolving_known_homo16 = load(['main_norman_bioconvolving_homo_known-',orientation,'-kSize-16.mat']);
bconvolving_known_homo25 = load(['main_norman_bioconvolving_homo_known-',orientation,'-kSize-25.mat']);
figure(6)
wer(bline.scores{1,m}, bline.scores{2,m}, [],2,[],1);
wer(bconvolving_known_homo2.scores{1,m}, bconvolving_known_homo2.scores{2,m}, [],2,[],2);
wer(bconvolving_known_homo3.scores{1,m}, bconvolving_known_homo3.scores{2,m}, [],2,[],3);
wer(bconvolving_known_homo4.scores{1,m}, bconvolving_known_homo4.scores{2,m}, [],2,[],4);
wer(bconvolving_known_homo8.scores{1,m}, bconvolving_known_homo8.scores{2,m}, [],2,[],5);
wer(bconvolving_known_homo16.scores{1,m}, bconvolving_known_homo16.scores{2,m}, [],2,[],6);
wer(bconvolving_known_homo25.scores{1,m}, bconvolving_known_homo25.scores{2,m}, [],2,[],7);
legend('baseline','kSize=2','kSize=3','kSize=4','kSize=8','kSize=16','kSize=25');
title(['DET Comparison KeySize - BioConvolving - Known- Homogeneous-',orientation])
file=['Pictures/DET_Comparative/KeySize-DET_kNN_bline_vs_bioconvolving-',orientation,'-',scenario{1},'_known.png'];
print('-dpng',file);

%%
m=5
bline = load(['main_norman-',orientation,'.mat']);
bconvolving_known_hete2 = load(['main_norman_bioconvolving_hete_known-',orientation,'-kSize-2.mat']);
bconvolving_known_hete3 = load(['main_norman_bioconvolving_hete_known-',orientation,'-kSize-3.mat']);
bconvolving_known_hete4 = load(['main_norman_bioconvolving_hete_known-',orientation,'-kSize-4.mat']);
bconvolving_known_hete8 = load(['main_norman_bioconvolving_hete_known-',orientation,'-kSize-8.mat']);
bconvolving_known_hete16 = load(['main_norman_bioconvolving_hete_known-',orientation,'-kSize-16.mat']);
bconvolving_known_hete25 = load(['main_norman_bioconvolving_hete_known-',orientation,'-kSize-25.mat']);
figure(7)
wer(bline.scores{1,m}, bline.scores{2,m}, [],2,[],1);
wer(bconvolving_known_hete2.scores{1,m}, bconvolving_known_hete2.scores{2,m}, [],2,[],2);
wer(bconvolving_known_hete3.scores{1,m}, bconvolving_known_hete3.scores{2,m}, [],2,[],3);
wer(bconvolving_known_hete4.scores{1,m}, bconvolving_known_hete4.scores{2,m}, [],2,[],4);
wer(bconvolving_known_hete8.scores{1,m}, bconvolving_known_hete8.scores{2,m}, [],2,[],5);
wer(bconvolving_known_hete16.scores{1,m}, bconvolving_known_hete16.scores{2,m}, [],2,[],6);
wer(bconvolving_known_hete25.scores{1,m}, bconvolving_known_hete25.scores{2,m}, [],2,[],7);
legend('baseline','kSize=2','kSize=3','kSize=4','kSize=8','kSize=16','kSize=25');
title(['DET Comparison KeySize - BioConvolving - Known- Heterogeneous-',orientation])
file=['Pictures/DET_Comparative/KeySize-DET_kNN_bline_vs_bioconvolving-',orientation,'-',scenario{2},'_known.png'];
print('-dpng',file);
