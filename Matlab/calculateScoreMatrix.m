function [clientScoreMatrix,impostorScoreMatrix]=calculateScoreMatrix(classifier,trainingDataSet,trainUserLabels,testDataSet,testUserLabels,classifierName)

%rightPredictions=0;
%wrongPredictions=0;

%% Score Production

% Takes the index of impostor
if strcmp(classifierName,'libsvm') || strcmp(classifierName,'regression')
    trainIndexClient = trainUserLabels==1;
    % trainNumLabels = zeros(size(trainUserLabels));
    %trainNumLabels(trainIndexClient==1) = 1;
    %trainNumLabels(trainIndexClient==0) = -1;
else
    trainIndexClient = cellfun(@(x) strcmp(x,'client'), trainUserLabels);
    %trainNumLabels=trainUserLabels;
end
%index = strcmp(trainUserLabels{1},'impostor');


% Takes the index of impostor
if strcmp(classifierName,'libsvm') || strcmp(classifierName,'regression')
    testIndexClient=testUserLabels==1;
    %testNumLabels = zeros(size(testUserLabels));
    %testNumLabels(testIndexClient==1) = 1;
    %testNumLabels(testIndexClient==0) = -1;
else
    testIndexClient = cellfun(@(x) strcmp(x,'client'), testUserLabels);
    %testNumLabels=testUserLabels;
end

%%Predicting Client

if strcmp('libsvm',classifierName)
    [predictedClass, accuracy, clientScore] = svmpredict(trainUserLabels(trainIndexClient==1), trainingDataSet(trainIndexClient==1,:),classifier,'-b 1');
elseif strcmp(classifierName,'regression')
    %prediction
    %returns the log likelihood
    predictedClass = glmval(classifier,trainingDataSet(trainIndexClient==1,:),'logit');
    clientScore = glmval(classifier,trainingDataSet(trainIndexClient==1,:),'identity');
else
    [predictedClass,clientScore] =predict(classifier,trainingDataSet(trainIndexClient==1,:));
end

if ~strcmp(classifierName,'regression')
    clientOutput=clientScore(:,1);
    clientOutput = log(clientOutput + realmin) - log(1-clientOutput + realmin);
else
    clientOutput=clientScore;
end

%structure used to calculate the accuracy and error rate
if strcmp(classifierName,'libsvm') || strcmp(classifierName,'regression')
    comp=trainUserLabels(trainIndexClient==1)==predictedClass(trainIndexClient==1);
else
    comp=strcmp(trainUserLabels(trainIndexClient==1),predictedClass(trainIndexClient==1));
end
rightPredictions=sum(comp==1);

wrongPredictions=sum(comp==0);


%% Calculating score Matrix of testSet


%% Predicting Impostor
if strcmp('libsvm',classifierName)
    [predictedClass, accuracy, impostorScore] = svmpredict(testUserLabels, testDataSet,classifier,'-b 1');
elseif strcmp(classifierName,'regression')
    %prediction
    %returns the log likelihood
    predictedClass = glmval(classifier,testDataSet,'logit');
    impostorScore = glmval(classifier,testDataSet,'identity');
else
    [predictedClass,impostorScore] =predict(classifier,testDataSet);
end

if ~strcmp(classifierName,'regression')
    impostorOutput=impostorScore(:,1);
    impostorOutput = log(impostorOutput + realmin) - log(1-impostorOutput + realmin);
else
    impostorOutput=impostorScore;
end

if strcmp(classifierName,'libsvm') || strcmp(classifierName,'regression')
    comp=testUserLabels(testIndexClient==0)==predictedClass(testIndexClient==0);
else
    comp=strcmp(testUserLabels(testIndexClient==0),predictedClass(testIndexClient==0));
end

rightPredictions=rightPredictions+sum(comp==1);
wrongPredictions=wrongPredictions+sum(comp==0);

disp('Right Predictions:');
disp(rightPredictions);
disp('Wrong Predictions:');
disp(wrongPredictions);
disp('Accuracy:');
disp(rightPredictions/(rightPredictions+wrongPredictions));
disp('Error Rate:');
disp(wrongPredictions/(rightPredictions+wrongPredictions));

impostorScoreMatrix=impostorOutput(testIndexClient==0);
clientScoreMatrix=clientOutput(trainIndexClient==1);

end