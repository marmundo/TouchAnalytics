function [clientScoreMatrix,impostorScoreMatrix]=calculateScoreMatrix(classifier,testDataSet,testUserLabels,classifierName)


%% Score Production

% Takes the index of impostor
if strcmp(classifierName,'libsvm')
    testIndexClient = testUserLabels==1;
    testIndexImpostor = testUserLabels==-1;
elseif strcmp(classifierName,'regression')
    testIndexClient = testUserLabels==1;
    testIndexImpostor = testUserLabels==0;
else
    testIndexClient = cellfun(@(x) strcmp(x,'client'), testUserLabels);
    testIndexImpostor = cellfun(@(x) strcmp(x,'impostor'), testUserLabels);

end

%%Predicting Client

if strcmp('libsvm',classifierName)
    [predictedClass, accuracy, clientScore] = svmpredict(testUserLabels(testIndexClient), testDataSet(testIndexClient,:),classifier,'-b 1');
elseif strcmp(classifierName,'regression')
    %prediction
    %returns the log likelihood
    predictedClass = glmval(classifier,testDataSet(testIndexClient,:),'logit');
    clientScore = glmval(classifier,testDataSet(testIndexClient,:),'identity');
else
    [predictedClass,clientScore] =predict(classifier,testDataSet(testIndexClient,:));
end

if ~strcmp(classifierName,'regression')
    clientOutput=clientScore(:,1);
    clientOutput = log(clientOutput + realmin) - log(1-clientOutput + realmin);
else
    clientOutput=clientScore;
end

%% Calculating score Matrix of testSet

%% Predicting Impostor
if strcmp('libsvm',classifierName)
    [predictedClass, accuracy, impostorScore] = svmpredict(testUserLabels(testIndexImpostor), testDataSet(testIndexImpostor,:),classifier,'-b 1');
elseif strcmp(classifierName,'regression')
    %prediction
    %returns the log likelihood
    %predictedClass = glmval(classifier,testDataSet(testIndexImpostor,:),'logit');
    impostorScore = glmval(classifier,testDataSet(testIndexImpostor,:),'identity');
else
    [predictedClass,impostorScore] =predict(classifier,testDataSet(testIndexImpostor,:));
end

if ~strcmp(classifierName,'regression')
    impostorOutput=impostorScore(:,1);
    impostorOutput = log(impostorOutput + realmin) - log(1-impostorOutput + realmin);
else
    impostorOutput=impostorScore;
end

impostorScoreMatrix=impostorOutput;
clientScoreMatrix=clientOutput;

end