function [clientScoreMatrix,impostorScoreMatrix]=prediction(classifierName,trainingDataSet,trainUserLabels,testDataSet,testUserLabels)
%classifierName=name of classifier. Can receive knn, svm or discriminant

numFeatures=length(trainingDataSet(1,:));

%training dataset without user labels
%trainingBioSamples=trainingDataSet(:,1:numFeatures-1);

%test dataset without user labels
%testDataSet=testingDataSet(:,1:numFeatures-1);

%user training Labels
%trainUserLabels=trainingBioSamples(:,1);

%user testing Labels
%testUserLabels=testDataSet(:,1);

rightPredictions=0;

wrongPredictions=0;

if strcmp(classifierName,'knn')
    %training knn
    classifier = ClassificationKNN.fit(trainingDataSet,trainUserLabels,'NumNeighbors',5);
elseif strcmp(classifierName,'svm')
    %classifier = fitcsvm(trainingDataSet,trainUserLabels,'KernelFunction','rbf');   
    classifier = fitcsvm(trainingDataSet,trainUserLabels);   
elseif strcmp(classifierName,'discriminant')
    classifier=fitcdiscr(trainingDataSet,trainUserLabels);    
end


%% Score Production



% Taking client samples
%clientData=trainingDataSet(find(trainingDataSet(:,numFeatures) == 1),:);
%numFeatures=length(clientData(1,:));

clientIndexes=[];

% storing the index of samples which belongs to the clients and impostors
clientIndex=strfind(trainUserLabels,'client');

for i=1:length(clientIndex)
    if clientIndex{i}
        clientIndexes(end+1)=i;   
    end
end

%% Calculating score Matrix to the client samples

for cIndex=1:length(clientIndexes)
    [predictedClass,score] = predict(classifier,trainingDataSet(clientIndexes(cIndex),:));
    %calculating the matrix score
    %if done because knn and discriminant gives the posterior probabilities
    %and svm gives the score
    if strcmp('knn',classifierName) | strcmp(classifierName,'discriminant')
        if score(1,1)==1
            logScore=1;
        else
         logScore=real(log(score(1,1)/score(1,2)));
        end
    else
        logScore=score(1,1);
    end
   
    
    %user label of this sample
    %clientScoreMatrix(clientIndex,1)=clientData(clientIndex,numFeatures);
    %storing the score of the classifier for this sample
    clientScoreMatrix(clientIndexes,1)=logScore;
    
    %structure used to calculate the accuracy and error rate
    if strcmp(trainUserLabels(clientIndexes),predictedClass)
        rightPredictions=rightPredictions+1;
    else
        wrongPredictions=wrongPredictions+1;
    end    
end

%% Calculating score Matrix of testSet


%testing test dataset with the recent trained classifier
numSamples=length(testDataSet(:,1));
for impostorIndexes=1:numSamples
    [predictedClass,score] = predict(classifier,testDataSet(impostorIndexes,:));
    %calculating the matrix score
     if strcmp('knn',classifierName) | strcmp(classifierName,'discriminant')
        if score(1,2)==1
            logScore=0;
        else
         logScore=real(log(score(1,1)/score(1,2)));
        end
    else
        logScore=score(1,2);
    end
       
    %user label of this sample
    %impostorScoreMatrix(impostorIndex,1)=testUserLabels(impostorIndex);
    %storing the score of the classifier for this sample
    impostorScoreMatrix(impostorIndexes,1)=logScore;
    if strcmp(testUserLabels(impostorIndexes),predictedClass)
        rightPredictions=rightPredictions+1;
    else
        wrongPredictions=wrongPredictions+1;
    end
end
disp('Right Predictions:');
disp(rightPredictions);
disp('Wrong Predictions:');
disp(wrongPredictions);
disp('Accuracy:');
disp(rightPredictions/numSamples);
disp('Error Rate:');
disp(wrongPredictions/numSamples);
end