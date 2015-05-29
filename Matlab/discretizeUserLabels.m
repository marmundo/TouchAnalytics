function [trainUserLabels,testUserLabels]=discretizeUserLabels(trainUserLabels,testUserLabels,classifierName)
if strcmp(classifierName,'libsvm')
    %% Changing the label of train and test sets. client to 1 and impostor to -1
    trainLabels(strcmp(trainUserLabels,'client'))=+1;
    trainLabels(strcmp(trainUserLabels,'impostor'))=-1;
    trainLabels=trainLabels';
    trainUserLabels=trainLabels;
    
    testLabels(strcmp(testUserLabels,'client'))=+1;
    testLabels(strcmp(testUserLabels,'impostor'))=-1;
    testLabels=testLabels';
    testUserLabels=testLabels;
elseif strcmp(classifierName,'regression')
    %% Changing the label of train and test sets. client to 1 and impostor to 0
    trainLabels(strcmp(trainUserLabels,'client'))=1;
    trainLabels(strcmp(trainUserLabels,'impostor'))=0;
    trainLabels=trainLabels';
    trainUserLabels=trainLabels;
    
    testLabels(strcmp(testUserLabels,'client'))=1;
    testLabels(strcmp(testUserLabels,'impostor'))=0;
    testLabels=testLabels';
    testUserLabels=testLabels;
end
end