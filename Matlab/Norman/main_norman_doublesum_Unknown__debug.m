%% load the common key
keySize=400;
key=getFixedKey('DoubleSum',keySize);

C1=randi([1,25],1,length(key));
C2=randi([1,25],1,length(key));

scenario={'homo','hete'};
s=2; %just consider the heterogeneous key
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
    key_imp=generateDoubleSumKey(keySize);
    % Encode the impostor user, encode its data with a key
    X_imp = [X_imp;doublesum_norman(data(index_template_neg,:),key_imp, C1, C2)];
  end
  
  %generate the key and save it
  com.user.key{i} = generateDoubleSumKey(keySize);
  X_gen =doublesum_norman(data(index_template,:),com.user.key{i},C1,C2);
  
  index_template_neg = cell2mat(cellfun(@(x) x(1:10), selected_user{TRAIN}( userlist ), 'UniformOutput', false));


  Y = [ones(1, numel(index_template)) zeros(1, numel(index_template_neg))];
  %k-NN
  com.knn.mdl{i} = fitcknn([X_gen; X_imp],Y','NumNeighbors',8);

end;

% %% Compare the 4 methods
% % (SIMILAR to main_norman.m)
% clear score*;
% for k=1:2,
%   for m=1:5,
%     scores{k,m}=[];
%   end;
% end;

%% Testing
for k=1:2,
  for m=1:1,
    scores{k,m}=[];
  end;
end;

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
    key_imp=generateDoubleSumKey(keySize);
    % Encode the impostor user, encode its data with a key
    X_imp = [X_imp;doublesum(data(index_imp,:),key_imp)];
  end
  
  X_gen = doublesum_norman(data(index_gen,:),com.user.key{i},C1,C2);
  
  com.knn.mdl{i}.NumNeighbors = 8;%4
  [~, gen_] = predict( com.knn.mdl{i}, X_gen);
  [~, imp_] = predict( com.knn.mdl{i}, X_imp);
  m=1;
  score_gen{m}=gen_(:,2);
  score_imp{m}=imp_(:,2);
  
  %record down the scores
  for m=1,
    scores{1,m} = [scores{1,m}; score_imp{m}];
    scores{2,m} = [scores{2,m}; score_gen{m}];
  end;
  
  for m=1,
    eer_(i,m) = wer(scores{1,m}, scores{2,m});
    %eer_(i,m) = wer(score_imp{m}, score_gen{m}, [],2,[],m);
  end;
  %pause;
  fprintf(1,'.');
end;
fprintf(1,'\n');
fileName=['main_norman_doublesum_',scenario{s},'_Unknown-',orientation,'-kSize-',num2str(keySize)];
extension='.mat';
save([fileName,extension],'scores');

%% compare with main_norman
bline = load('main_norman.mat');
%%
figure(3);
m=4; wer(bline.scores{1,m}, bline.scores{2,m}, [],2,[],1);
m=1; wer(scores{1,m}, scores{2,m}, [],2,[],3);
legend('baseline', 'doublesum-Unknown');
legend('baseline','doublesum UnKnown');
