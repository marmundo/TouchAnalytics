function [clientScoreMatrix,impostorScoreMatrix]=prediction(classifierName,trainingDataSet,trainUserLabels,testDataSet,testUserLabels,saveFilePath,user)
%classifierName=name of classifier. Can receive knn, svm or discriminant


numFeatures=length(trainingDataSet(1,:));

if strcmp(classifierName,'knn')
    %training knn
    classifier = ClassificationKNN.fit(trainingDataSet,trainUserLabels,'NumNeighbors',5);
elseif strcmp(classifierName,'svm')
    
   %% Using builtin svm  function of Matlab   
    %classifier = fitcsvm(trainingDataSet,trainUserLabels,'KernelFunction','rbf','Standardize',true,,'ScoreTransform','invlogit');
     classifier = fitcsvm(trainingDataSet,trainUserLabels,'KernelFunction','rbf','Standardize',true,'ClassNames',{'impostor','client'},'KernelScale','auto');
     classifier = fitSVMPosterior(classifier);
elseif strcmp(classifierName,'libsvm')
    %% Using libsvm function
    addpath('lib/libsvm');
    %% Changing the label of train and test sets. client to 0 and impsotor to 1
    trainLabels(strcmp(trainUserLabels,'client'))=+1;
    trainLabels(strcmp(trainUserLabels,'impostor'))=-1;
    trainLabels=trainLabels';     
    trainUserLabels=trainLabels;
    
    testLabels(strcmp(testUserLabels,'client'))=+1;
    testLabels(strcmp(testUserLabels,'impostor'))=-1;
    testLabels=testLabels';
    testUserLabels=testLabels;
    
    %% Training
    classifier = svmtrain(trainUserLabels, trainingDataSet,'-b 1');
    
elseif strcmp(classifierName,'discriminant')
    classifier=fitcdiscr(trainingDataSet,trainUserLabels);
end

%save classifier
save(strcat(saveFilePath,'/Classifier_User_',num2str(user),'.mat'),'classifier');

%taking client and impostor score matrix
[clientScoreMatrix,impostorScoreMatrix]=calculateScoreMatrix(classifier,trainingDataSet,trainUserLabels,testDataSet,testUserLabels,classifierName);
end