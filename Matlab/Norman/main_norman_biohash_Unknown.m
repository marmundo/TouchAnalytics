% program is very similar to main_norman_biohash

addpath ../lib
addpath ../
% addpath C:\Users\Poh\Dropbox\LivDet\program\lib\VR-EER

%% load the data
clear
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

%% Cleaning and normalizing data
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

selected_ = find(unique_count>50);
ID=data(:,1);
data=(data(:,selected_));

data=zscore(data);

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

%selected users per fold (TRAIN, VALID and TEST)
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
VALID_IMP=21:41;%impostor used for validation
TEST_IMP =21:41;%impostor used for test

%% load the common key
load('BioHashingKey.mat','key');

keySize=1;
dim = round(size(data,2)*keySize);
key = key(1:dim, 1:dim);

%% train classifiers in the biohashing domain
scenario={'homo','hete'};
for s=1:2
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
            key_imp = rand(dim);
            % Encode the impostor user, encode its data with a key
            X_imp = [X_imp;double(biohashing(data(index_template_neg,:),key_imp))];
        end
        %key_imp = rand(dim);
        if strcmp(scenario{s},'homo')
            X_gen = double(biohashing(data(index_template,:),key));
        else
            com.user.key{i} = rand(dim);
            X_gen = double(biohashing(data(index_template,:),com.user.key{i}));
        end
        %X_imp = double(biohashing(data(index_template_neg,:),key_imp));
        
        index_template_neg = cell2mat(cellfun(@(x) x(1:10), selected_user{TRAIN}( userlist ), 'UniformOutput', false));
        %logistic regression
        Y = [ones(1, numel(index_template)) zeros(1, numel(index_template_neg))];
        W = [ones(1, numel(index_template)) / numel(index_template) ones(1, numel(index_template_neg)) /numel(index_template_neg) ];
        com.user.b(i,:) = glmfit([X_gen; X_imp],Y', 'binomial', 'weights',W');
        
        %k-NN
        com.knn.mdl{i} = fitcknn([X_gen; X_imp],Y');

        %SVM
        com.svm{i}=fitcsvm([X_gen;X_imp],Y','KernelFunction','rbf','Standardize',true,'KernelScale','auto');
        com.svm{i} = fitSVMPosterior(com.svm{i});
    end;
    bar(median(com.user.b))
    com.median.b = median(com.user.b);
    
    %% Compare the 4 methods
    % (SIMILAR to main_norman.m)
    clear score*;
    for k=1:2,
        for m=1:5,
            scores{k,m,keySize}=[];
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
            key_imp = rand(dim);
            % Encode the impostor user, encode its data with a key
            X_imp = [X_imp;double(biohashing(data(index_imp,:),key_imp))];
        end
        %key_imp = rand(dim);
        if strcmp(scenario{s},'homo')
            X_gen = double(biohashing(data(index_gen,:),key));
        else
            X_gen = double(biohashing(data(index_gen,:),com.user.key{i}));
        end
        %X_imp = double(biohashing(data(index_imp,:),key_imp));
        
        
        %METHOD 2: logistic regression
        m=2;
        score_gen{m,keySize} = glmval(com.user.b(i,:)', X_gen,'identity');
        score_imp{m,keySize} = glmval(com.user.b(i,:)', X_imp,'identity');
        
        %METHOD 3: logistic regression
        m=3;
        score_gen{m,keySize} = glmval(com.median.b', X_gen,'identity');
        score_imp{m,keySize} = glmval(com.median.b', X_imp,'identity');
        
        %METHOD 4: K-NN
        m=4;
        com.knn.mdl{i}.NumNeighbors = 8;%4
        [~, gen_] = predict( com.knn.mdl{i}, X_gen);
        [~, imp_] = predict( com.knn.mdl{i}, X_imp);
        score_gen{m,keySize}=gen_(:,2);
        score_imp{m,keySize}=imp_(:,2);

        %METHOD 5: SVM
        m=5;
        [~,gen_] =predict(com.svm{i},X_gen);
        [~,imp_] =predict(com.svm{i},X_imp);
        score_gen{m,keySize}=gen_(:,2);
        score_imp{m,keySize}=imp_(:,2);
  
        
        %record down the scores
        for m=2:5,
            scores{1,m} = [scores{1,m}; score_imp{m,keySize}];
            scores{2,m} = [scores{2,m}; score_gen{m,keySize}];
        end;
        
        for m=2:5,
            eer_(i,m) = wer(scores{1,m}, scores{2,m});
            %eer_(i,m) = wer(score_imp{m}, score_gen{m}, [],2,[],m);
        end;
        %pause;
        fprintf(1,'.');
    end;
    fprintf(1,'\n');
    fileName=['main_norman_biohash_',scenario{s},'_Unknown-',orientation,'-kSize-',num2str(keySize)];
    extension='.mat';
    save([fileName,extension],'scores');

    %%
%     figure(2);
%     for m=2:5,
%       eer_system(m) = wer(scores{1,m}, scores{2,m}, [],2,[],m);
%     end;
%     eer_system
%     legend('LR user-specific','LR common', 'kNN (8)','location', 'Southwest');
%     file=['Pictures/',fileName,'__DET_Euc_LR_kNN.png'];
%     print('-dpng',file);
% 
%     %% compare with main_norman
%      bline = load('main_norman.mat');
%     bhash = load(['main_norman_biohash_',scenario{s},'_known-',orientation]);
    %%
%     figure(3);
%     m=5;
%     wer(bline.scores{1,m}, bline.scores{2,m}, [],2,[],1);
%     wer(bhash.scores{1,m}, bhash.scores{2,m}, [],2,[],2);
%     wer(scores{1,m}, scores{2,m}, [],2,[],3);
%     legend('baseline','biohash Known','biohash Unknown');
%     file=['Pictures/DET_kNN_bline_vs_biohash-',orientation,'-',scenario{s},'_Unknown.png'];
%     print('-dpng',file);
end

%% main_norman_biohash_
bline = load('main_norman.mat');
bhash_known=load(['main_norman_biohash_homo_known-',orientation,'.mat']);
bhash_unknown_homo = load(['main_norman_biohash_homo_Unknown-',orientation,'.mat']);
bhash_unknown_hetero = load(['main_norman_biohash_hete_Unknown-',orientation,'.mat']);
%%
close all;
figure(3);
m=5;

wer(bline.scores{1,m}, bline.scores{2,m}, [],2,[],1);
%wer(bhash.scores{1,m}, bhash.scores{2,m}, [],2,[],2);
wer(bhash_known.scores{1,m}, bhash_known.scores{2,m}, [],2,[],2);
wer(bhash_unknown_homo.scores{1,m}, bhash_unknown_homo.scores{2,m}, [],2,[],3);
wer(bhash_unknown_hetero.scores{1,m}, bhash_unknown_hetero.scores{2,m}, [],2,[],4);
classifiers={'','Logistic per User','Logistic per data','kNN','SVM'}
title({['DET - Classifier: ',classifiers{m},' using BioHashing-',orientation]});
legend('baseline','Known','biohash Unknown (homo)', 'biohash Unknown (hetero)');
file=['Pictures/DET_Comparative/DET_',classifiers{m},'_bline_vs_biohashing(homo vs hete)-',orientation,'.png'];
print('-dpng',file);

%%
figure(4);
wer(bhash.scores{1,m}, bhash.scores{2,m}, [],4,[],1);
wer(scores{1,m}, scores{2,m}, [],4,[],2);

%%
bhash_unknown_homo1 = load(['main_norman_biohash_homo_Unknown-',orientation,'-kSize-1.mat']);
bhash_unknown_homo2 = load(['main_norman_biohash_homo_Unknown-',orientation,'-kSize-2.mat']);
bhash_unknown_homo3 = load(['main_norman_biohash_homo_Unknown-',orientation,'-kSize-3.mat']);
bhash_unknown_homo4 = load(['main_norman_biohash_homo_Unknown-',orientation,'-kSize-4.mat']);
bhash_unknown_homo8 = load(['main_norman_biohash_homo_Unknown-',orientation,'-kSize-8.mat']);
bhash_unknown_homo40 = load(['main_norman_biohash_homo_Unknown-',orientation,'-kSize-40.mat']);
figure(6)
wer(bline.scores{1,m}, bline.scores{2,m}, [],2,[],1);
wer(bhash_unknown_homo1.scores{1,m,1}, bhash_unknown_homo1.scores{2,m,1}, [],2,[],2);
wer(bhash_unknown_homo2.scores{1,m,2}, bhash_unknown_homo2.scores{2,m,2}, [],2,[],3);
wer(bhash_unknown_homo3.scores{1,m,3}, bhash_unknown_homo3.scores{2,m,3}, [],2,[],4);
wer(bhash_unknown_homo4.scores{1,m,4}, bhash_unknown_homo4.scores{2,m,4}, [],2,[],5);
wer(bhash_unknown_homo8.scores{1,m,8}, bhash_unknown_homo8.scores{2,m,8}, [],2,[],6);
wer(bhash_unknown_homo40.scores{1,m,40}, bhash_unknown_homo40.scores{2,m,40}, [],2,[],7);
legend('baseline','biohash Unknown-kSize=25','biohash Unknown-kSize=50','biohash Unknown-kSize=75','biohash Unknown-kSize=100','biohash Unknown-kSize=200','biohash Unknown-kSize=1000');
title(['DET Comparison KeySize - Biohashing - Unknown- Homogeneous-',orientation])
file=['Pictures/DET_Comparative/DET_kNN_bline_vs_biohash-',orientation,'-',scenario{1},'_Unknown.png'];
print('-dpng',file);

%%
bhash_unknown_hete1 = load(['main_norman_biohash_hete_Unknown-',orientation,'-kSize-1.mat']);
bhash_unknown_hete2 = load(['main_norman_biohash_hete_Unknown-',orientation,'-kSize-2.mat']);
bhash_unknown_hete3 = load(['main_norman_biohash_hete_Unknown-',orientation,'-kSize-3.mat']);
bhash_unknown_hete4 = load(['main_norman_biohash_hete_Unknown-',orientation,'-kSize-4.mat']);
bhash_unknown_hete8 = load(['main_norman_biohash_hete_Unknown-',orientation,'-kSize-8.mat']);
bhash_unknown_hete40 = load(['main_norman_biohash_hete_Unknown-',orientation,'-kSize-40.mat']);
figure(7)
wer(bline.scores{1,m}, bline.scores{2,m}, [],2,[],1);
wer(bhash_unknown_hete1.scores{1,m,1}, bhash_unknown_hete1.scores{2,m,1}, [],2,[],2);
wer(bhash_unknown_hete2.scores{1,m,2}, bhash_unknown_hete2.scores{2,m,2}, [],2,[],3);
wer(bhash_unknown_hete3.scores{1,m,3}, bhash_unknown_hete3.scores{2,m,3}, [],2,[],4);
wer(bhash_unknown_hete4.scores{1,m,4}, bhash_unknown_hete4.scores{2,m,4}, [],2,[],5);
wer(bhash_unknown_hete8.scores{1,m,8}, bhash_unknown_hete8.scores{2,m,8}, [],2,[],6);
wer(bhash_unknown_hete40.scores{1,m,40}, bhash_unknown_hete40.scores{2,m,40}, [],2,[],7);
legend('baseline','biohash Unknown-kSize=25','biohash Unknown-kSize=50','biohash Unknown-kSize=75','biohash Unknown-kSize=100','biohash Unknown-kSize=200','biohash Unknown-kSize=1000');
title(['DET Comparison KeySize - Biohashing - Unknown- Heterogeneous-',orientation])
file=['Pictures/DET_Comparative/KeySize-DET_kNN_bline_vs_biohash-',orientation,'-',scenario{2},'_Unknown.png'];
print('-dpng',file);
