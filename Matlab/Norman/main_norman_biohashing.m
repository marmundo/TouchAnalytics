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

clear score*;
for k=1:2,
  for m=1:4,
    scores{k,m}=[];
  end;
end;

%% Aplying BioHashing protection method
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
        index_template_test = selected_user{TEST}{i}; %use all the available samples for training
        %% Encode the client sample with a key
        if strcmp(scenario,'Homo_UK')
            key=getFixedKey('BioHashing',length(selected_));
            X_gen_train=biohashing(data(index_template,:),key);
            
        else
            key=rand(keySize);
            X_gen_train=biohashing(data(index_template,:),key);
          
        end
        
        %negative training samples
        impostor = find(ID_list ~= i);
        userlist = impostor(TRAIN_IMP);
        index_template_neg = cell2mat(cellfun(@(x) x(1:10), selected_user{TRAIN}( i ), 'UniformOutput', false));
        key_imp=rand(keySize);
        X_imp_train = double(biohashing(data(index_template_neg,:),key_imp));
        
        %% Training
        %logistic regression
        Y = [ones(1, numel(index_template)) zeros(1, numel(index_template_neg))];
        W = [ones(1, numel(index_template)) / numel(index_template) ones(1, numel(index_template_neg)) /numel(index_template_neg) ];
        com.user.b(i,:) = glmfit([X_gen_train;X_imp_train],Y', 'binomial', 'weights',W');
        
        %k-NN
        com.knn.mdl{i} = fitcknn([X_gen_train;X_imp_train],Y');
        
        %% Testing
        
        X_gen = X_gen_valid;
        
        % For all impostors take the samples of each impostor user
        userlist = impostor(VALID_IMP);
        %for iUser=1:numel(userlist)
            X_imp_valid = cell2mat(cellfun(@(x) x(1:10), selected_user{VALID}( i ), 'UniformOutput', false));
            X_imp_valid=data(X_imp_valid,:);
            key=rand(keySize);
            %% Encode the impostor user, encode its data with a key
            X_imp = double(biohashing(X_imp_valid,key));
        %end
        
%         userlist = impostor(TEST_IMP);
%         for iUser=1:numel(userlist)
%             X_imp_test = cell2mat(cellfun(@(x) x(1:10), selected_user{TEST}( iUser ), 'UniformOutput', false));
%             X_imp_test=data(X_imp_test,:);
%             key=rand(keySize);
%             %% Encode the impostor user, encode its data with a key
%             X_imp_test = double(biohashing(X_imp_valid,key));
%         end
        
 
        %METHOD 2: logistic regression
        m=2;
        score_gen{m} = glmval(com.user.b(i,:)', X_gen,'identity');
        score_imp{m} = glmval(com.user.b(i,:)', X_imp,'identity');
        
       
        %METHOD 4: K-NN
        m=4;
        com.knn.mdl{i}.NumNeighbors = 8;%4
        [~, gen_] = predict( com.knn.mdl{i}, X_gen);
        [~, imp_] = predict( com.knn.mdl{i}, X_imp);
        score_gen{m}=gen_(:,2);
        score_imp{m}=imp_(:,2);
        
        %record down the scores
        for m=2:2:4,
            scores{1,m} = [scores{1,m}; score_imp{m}];
            scores{2,m} = [scores{2,m}; score_gen{m}];
        end;
        
        for m=2:2:4,
            eer_(i,m) = wer(scores{1,m}, scores{2,m});
            %eer_(i,m) = wer(score_imp{m}, score_gen{m}, [],2,[],m);
        end;
        %pause;
        fprintf(1,'.');
    end;
    
    bline = load('main_norman.mat');
    bhash = load('main_norman_biohash.mat');
    %%
    m=4;
    wer(bline.scores{1,m}, bline.scores{2,m}, [],2,[],1);
    wer(bhash.scores{1,m}, bhash.scores{2,m}, [],2,[],2);
    wer(scores{1,m}, scores{2,m}, [],2,[],3);
    legend('baseline','biohash Known','biohash Unknown');
    print('-dpng','Pictures/main_norman_biohash_Unknown__DET_kNN_bline_vs_biohash.png');

end

%scores=runExperiments(data,selected_user,ID_list,TRAIN,TRAIN_IMP,VALID,VALID_IMP,TEST,TEST_IMP);

end