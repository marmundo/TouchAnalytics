function [clientScoreMatrix,impostorScoreMatrix]=prediction(classifierName,trainingDataSet,trainUserLabels,testDataSet,testUserLabels,saveFilePath,user)
%classifierName=name of classifier. Can receive knn, svm or discriminant

%addpath('lib/Inpaint_nans');

numFeatures=length(trainingDataSet(1,:));

%training dataset without user labels
%trainingBioSamples=trainingDataSet(:,1:numFeatures-1);

%test dataset without user labels
%testDataSet=testingDataSet(:,1:numFeatures-1);

%user training Labels
%trainUserLabels=trainingBioSamples(:,1);

%user testing Labels
%testUserLabels=testDataSet(:,1);

if strcmp(classifierName,'knn')
    %training knn
    classifier = ClassificationKNN.fit(trainingDataSet,trainUserLabels,'NumNeighbors',5);
elseif strcmp(classifierName,'svm')
    %classifier = fitcsvm(trainingDataSet,trainUserLabels,'KernelFunction','rbf');
    classifier = fitcsvm(trainingDataSet,trainUserLabels);
     classifier = fitSVMPosterior(classifier);
elseif strcmp(classifierName,'discriminant')
    classifier=fitcdiscr(trainingDataSet,trainUserLabels);
end

%save classifier
save(strcat(saveFilePath,'/Classifier_User_',num2str(user),'.mat'),'classifier');

%taking client and impostor score matrix
[clientScoreMatrix,impostorScoreMatrix]=calculateScoreMatrix(classifier,trainingDataSet,trainUserLabels,testDataSet,testUserLabels);
end