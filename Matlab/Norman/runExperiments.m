function scores= runExperiments(data,selected_user,ID_list,TRAIN,TRAIN_IMP,VALID,VALID_IMP,TEST,TEST_IMP,orientation)
%% train the logistic regression classifier
for i=1:numel(ID_list),
    
    %positive training samples
    index_template = selected_user{TRAIN}{i}; %use all the available samples for training
    
    %negative training samples
    userlist = find(ID_list ~= i);
    userlist = userlist(TRAIN_IMP);
    index_template_neg = cell2mat(cellfun(@(x) x(1:10), selected_user{TRAIN}( userlist ), 'UniformOutput', false));
    
    %logistic regression
    Y = [ones(1, numel(index_template)) zeros(1, numel(index_template_neg))];
    W = [ones(1, numel(index_template)) / numel(index_template) ones(1, numel(index_template_neg)) /numel(index_template_neg) ];
    com.user.b(i,:) = glmfit(data([index_template index_template_neg],:),Y', 'binomial', 'weights',W');
    
    %k-NN
    com.knn.mdl{i} = fitcknn(data([index_template index_template_neg],:),Y');
    
    %SVM
    com.svm{i}=fitcsvm(data([index_template index_template_neg],:),Y','KernelFunction','rbf','Standardize',true,'KernelScale','auto');
    %com.svm{i} = fitSVMPosterior(com.svm{i});
end;
% bar(median(com.user.b))
com.median.b = median(com.user.b);

%% Compare the 4 methods
clear score*;
for k=1:2,
    for m=1:5,
        scores{k,m}=[];
    end;
end;

for i=1:numel(ID_list),
    
    %positive training samples
    index_template = selected_user{TRAIN}{i}; %use all the available samples for training
    
    %negative training samples
    userlist = find(ID_list ~= i);
    userlist = userlist(TRAIN_IMP);
    index_template_neg = cell2mat(cellfun(@(x) x(1:10), selected_user{TRAIN}( userlist ), 'UniformOutput', false));
    
    %METHOD 1: Euclidean distance
    m=1;
    %genuine scores
    %score_gen = get_pairwise_triu_scores(data, selected_user{1}{i});
    %index_template = selected_user{TRAIN}{i}(1:min_train_samples);
    %score_gen_ = get_pairwise_scores(data, index_template, selected_user{VALID}{i});
    %score_gen{m} = - mean(score_gen_)';
    
    %impostor scores -- select only 10 samples
    userlist = find(ID_list ~= i);
    userlist = userlist(VALID_IMP);
    index_imp = cell2mat(cellfun(@(x) x(1:10), selected_user{VALID}( userlist ), 'UniformOutput', false));
    
    %score_imp_ = get_pairwise_scores(data, index_template, index_imp);
    %score_imp{m} = - mean(score_imp_)';
    
    %METHOD 2: logistic regression
    m=2;
    
    score_gen{m}= glmval(com.user.b(i,:)', data(selected_user{VALID}{i},:),'identity');
    score_imp{m} = glmval(com.user.b(i,:)', data(index_imp,:),'identity');
    
    %METHOD 3: logistic regression
    m=3;
    score_gen{m} = glmval(com.median.b', data(selected_user{VALID}{i},:),'identity');
    score_imp{m} = glmval(com.median.b', data(index_imp,:),'identity');
    
    %METHOD 4: K-NN
    m=4;
    com.knn.mdl{i}.NumNeighbors = 8;%4
    [~, gen_] = predict( com.knn.mdl{i}, data(selected_user{VALID}{i},:));
    [~, imp_] = predict( com.knn.mdl{i}, data(index_imp,:));
    score_gen{m}=gen_(:,2);
    score_imp{m}=imp_(:,2);
    
    %METHOD 5: SVM
    m=5;
    [~,gen_] =predict(com.svm{i},data(selected_user{VALID}{i},:));
    [~,imp_] =predict(com.svm{i},data(index_imp,:));
    score_gen{m}=gen_(:,2);
    score_imp{m}=imp_(:,2);
    
    
    %record down the scores
    for m=2:5,
        scores{1,m} = [scores{1,m}; score_imp{m}];
        scores{2,m} = [scores{2,m}; score_gen{m}];
    end;
    
    for m=2:5,
        eer_(i,m) = wer(scores{1,m}, scores{2,m});
        %eer_(i,m) = wer(score_imp{m}, score_gen{m}, [],2,[],m);
    end;
    %pause;
    fprintf(1,'.');
end;

fprintf(1,'\n');

fileName=['main_norman-',orientation,'.mat'];
save(fileName,'scores');
%%
% for m=1:4,
%     eer_system(m) = wer(scores{1,m}, scores{2,m}, [],2,[],m);
% end;
% eer_system
% legend('Euclidean','LR user-specific','LR common', 'kNN (4)','location', 'Southwest');
%
% print('-dpng','Pictures/main_norman__DET_Euc_LR_kNN.png');
%%
end