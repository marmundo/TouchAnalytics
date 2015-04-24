% Takes the index of impostor
trainIndexClient = cellfun(@(x) strcmp(x,'client'), trainUserLabels);
%index = strcmp(trainUserLabels{1},'impostor');

trainNumLabels = zeros(size(trainUserLabels));
trainNumLabels(trainIndexClient==1) = 1;
trainNumLabels(trainIndexClient~=0) = -1;

% Takes the index of impostor
testIndexClient = cellfun(@(x) strcmp(x,'client'), testUserLabels);
%index = strcmp(trainUserLabels{1},'impostor');

testNumLabels = zeros(size(testUserLabels));
testNumLabels(testIndexClient==1) = 1;
testNumLabels(testIndexClient~=0) = -1;

%%Predicting Client
[predictedClass,clientScore] =predict(classifier,trainingDataSet(trainIndexClient==1,:));
clientOutput=clientScore(:,1);
clientOutput = log(clientOutput + realmin) - log(1-clientOutput + realmin);


%% Predicting Impostor
[predictedClass,impostorScore] =predict(classifier,testDataSet);
impostorOutput=impostorScore(:,1);
impostorOutput = log(impostorOutput + realmin) - log(1-impostorOutput + realmin);


wer(impostorOutput(testIndexClient==0),clientOutput(trainIndexClient==1),[],1)
wer(impostorOutput(testIndexClient==0),clientOutput(trainIndexClient==1))
%%
sum(trainIndexClient==0)
sum(trainIndexClient~=0)
%
%range_ = unique(output);
%%
range_=linspace(-0.1,1.1,13);

[count_client] = hist(impostorOutput(trainIndexClient==1), range_);
FAR = 1 - cumsum(count_client) / sum(count_client);
[count_impostor] = hist(impostorOutput(testIndexClient==0), range_);
FRR = cumsum(count_impostor) / sum(count_impostor);

%
clc
[range_'  FRR' FAR']

[range_' count_client' count_impostor']

%%
plot(range_, [1-FRR' 1-FAR'])