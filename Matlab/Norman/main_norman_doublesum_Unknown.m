
addpath ..
addpath ../lib

%% load the data
clear
orientation='Scrolling';
%orientation='Horizontal';

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

bar(unique_count);
ylabel('Unique values');
xlabel('Feature index');
%print('-dpng','Pictures/main_norman__unique_value_feature_count.png');

% normalise
selected_ = find(unique_count>50);
ID=data(:,1);
data=(data(:,selected_));

ID_list = unique(ID)';

%% analyse the test folds (should be 1/3)
% Use the same samples for each fold in all experiments
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

% put each select used of each folder in the selected_user
% variable{fold}{user}
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
keySize=length(data(1,:));
key=getFixedKey('DoubleSum',keySize);

scenario={'homo','hete'};
for s=1:2
    %% train classifiers in the doublesum domain
    for i=1:numel(ID_list),
        
        %positive training samples
        index_template = selected_user{TRAIN}{i}; %use all the available samples for training
        
        %negative training samples
        userlist = find(ID_list ~= i);
        userlist = userlist(TRAIN_IMP);
     
        %for each user, the template is encrypted using one common key; and the attacker
        %uses another key for nonmatch
        X_imp=[];
        for iUser=1:numel(userlist)
            index_template_neg = cell2mat(cellfun(@(x) x(1:10), selected_user{TRAIN}( iUser ), 'UniformOutput', false));
            key_imp =randperm(keySize);
            % Encode the impostor user, encode its data with a key
            X_imp = [X_imp;doublesum(data(index_template_neg,:),key_imp)];
        end

        if strcmp(scenario{s},'homo')
            X_gen =doublesum(data(index_template,:),key);
        else
            com.user.key{i} = randperm(keySize);
            X_gen =doublesum(data(index_template,:),com.user.key{i});
        end
        
        index_template_neg = cell2mat(cellfun(@(x) x(1:10), selected_user{TRAIN}( userlist ), 'UniformOutput', false));
        %logistic regression
        Y = [ones(1, numel(index_template)) zeros(1, numel(index_template_neg))];
        W = [ones(1, numel(index_template)) / numel(index_template) ones(1, numel(index_template_neg)) /numel(index_template_neg) ];
        com.user.b(i,:) = glmfit([X_gen; X_imp],Y', 'binomial', 'weights',W');
        
        %k-NN
        com.knn.mdl{i} = fitcknn([X_gen; X_imp],Y','NumNeighbors',8);
    end;
    bar(median(com.user.b))
    com.median.b = median(com.user.b);
    
    %% Compare the 4 methods
    % (SIMILAR to main_norman.m)
    clear score*;
    for k=1:2,
        for m=1:4,
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
       
        X_imp=[];
        %for each user, the template is encrypted using one common key; and the attacker
        %   uses another key for nonmatch
        for iUser=1:numel(userlist)
            index_imp  = cell2mat(cellfun(@(x) x(1:10), selected_user{VALID}( iUser ), 'UniformOutput', false));
            key_imp = randperm(keySize);
            % Encode the impostor user, encode its data with a key
            X_imp = [X_imp;doublesum(data(index_imp,:),key_imp)];
        end
        %key_imp = rand(dim);
        if strcmp(scenario{s},'homo')
            X_gen = doublesum(data(index_gen,:),key);
        else
            X_gen = doublesum(data(index_gen,:),com.user.key{i});
        end
        
        
        %METHOD 2: logistic regression
        m=2;
        score_gen{m} = glmval(com.user.b(i,:)', X_gen,'identity');
        score_imp{m} = glmval(com.user.b(i,:)', X_imp,'identity');
        
        %METHOD 3: logistic regression
        m=3;
        score_gen{m} = glmval(com.median.b', X_gen,'identity');
        score_imp{m} = glmval(com.median.b', X_imp,'identity');
        
        %METHOD 4: K-NN
        m=4;
        com.knn.mdl{i}.NumNeighbors = 8;%4
        [~, gen_] = predict( com.knn.mdl{i}, X_gen);
        [~, imp_] = predict( com.knn.mdl{i}, X_imp);
        score_gen{m}=gen_(:,2);
        score_imp{m}=imp_(:,2);
        
        %record down the scores
        for m=2:4,
            scores{1,m} = [scores{1,m}; score_imp{m}];
            scores{2,m} = [scores{2,m}; score_gen{m}];
        end;
        
        for m=2:4,
            eer_(i,m) = wer(scores{1,m}, scores{2,m});
            %eer_(i,m) = wer(score_imp{m}, score_gen{m}, [],2,[],m);
        end;
        %pause;
        fprintf(1,'.');
    end;
    fprintf(1,'\n');
    fileName=['main_norman_doublesum_',scenario{s},'_Unknown-',orientation];
    extension='.mat';
    save([fileName,extension],'scores');

    %%
    figure(2);
    for m=2:4,
      eer_system(m) = wer(scores{1,m}, scores{2,m}, [],2,[],m);
    end;
    eer_system
    legend('LR user-specific','LR common', 'kNN (8)','location', 'Southwest');
    file=['Pictures/',fileName,'__DET_Euc_LR_kNN.png'];
    print('-dpng',file);

    %% compare with main_norman
    bline = load('main_norman.mat');
    bhash = load(['main_norman_doublesum_',scenario{s},'_known-',orientation]);
    %%
    figure(3);
    m=4;
    wer(bline.scores{1,m}, bline.scores{2,m}, [],2,[],1);
    wer(bhash.scores{1,m}, bhash.scores{2,m}, [],2,[],2);
    wer(scores{1,m}, scores{2,m}, [],2,[],3);
    legend('baseline','doublesum Known','doublesum Unknown');
    file=['Pictures/DET_kNN_bline_vs_doublesum-',orientation,'-',scenario{s},'_Unknown.png'];
    print('-dpng',file);
end

%% main_norman_doublesum_
bline = load('main_norman.mat');
doublesum_known=load(['main_norman_doublesum_homo_known-',orientation,'.mat']);
doublesum_unknown_homo = load(['main_norman_doublesum_homo_Unknown-',orientation,'.mat']);
doublesum_unknown_hetero = load(['main_norman_doublesum_hete_Unknown-',orientation,'.mat']);
%%
close all;
figure(3);
m=4;
wer(bline.scores{1,m}, bline.scores{2,m}, [],2,[],1);
%wer(bhash.scores{1,m}, bhash.scores{2,m}, [],2,[],2);
wer(doublesum_known.scores{1,m}, doublesum_known.scores{2,m}, [],2,[],2);
wer(doublesum_unknown_homo.scores{1,m}, doublesum_unknown_homo.scores{2,m}, [],2,[],3);
wer(doublesum_unknown_hetero.scores{1,m}, doublesum_unknown_hetero.scores{2,m}, [],2,[],4);
title({['DET - Classifier: Knn using DoubleSum-',orientation]});
legend('baseline','Known','doublesum Unknown (homo)', 'doublesum Unknown (hetero)','Location','southwest');
file=['Pictures/DET_Comparative/DET_kNN_bline_vs_doublesum(homo vs hete)-',orientation,'.png'];
print('-dpng',file);

%%
figure(4);
wer(bhash.scores{1,m}, bhash.scores{2,m}, [],4,[],1);
wer(scores{1,m}, scores{2,m}, [],4,[],2);
