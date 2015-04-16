function [clientScoreMatrix,impostorScoreMatrix]=calculateScoreMatrixtrainingDataSet(classifier,trainingDataSet,trainUserLabels,testDataSet,testUserLabels,classifierName)

rightPredictions=0;
wrongPredictions=0;

%% Score Production

clientIndexes=[];

% storing the index of samples which belongs to the clients and impostors
if strcmp('svm',classifierName)
    clientIndex=trainUserLabels==1;
    for i=1:length(clientIndex)
        if clientIndex(i)
            clientIndexes(end+1)=i;
        end
    end
else
    clientIndex=strfind(trainUserLabels,'client');
    for i=1:length(clientIndex)
        if clientIndex{i}
            clientIndexes(end+1)=i;
        end
    end
end




%% Calculating score Matrix to the client samples
for cIndex=1:length(clientIndexes)
    
    sample=trainingDataSet(clientIndexes(cIndex),:);
    
    sample(isnan(sample)) = 0;
    sample(isinf(sample)) = 0;
    
    if strcmp('svm',classifierName)
        [predictedClass, accuracy, score] = svmpredict(trainUserLabels(cIndex), sample,classifier,'-b 1');
    else
        [predictedClass,score] = predict(classifier,sample);
    end
    %calculating the matrix score
    %if done because knn and discriminant gives the posterior probabilities
    %and svm gives the score
    %    if strcmp('knn',classifierName) | strcmp(classifierName,'discriminant')
    if score(1,1)==1
        score(1,2)=10^-100;
    elseif score(1,1)==0
        score(1,1)=10^-100;
    end
    logScore=real(log(score(1,1)/score(1,2)));
    if isnan(logScore)  | isinf(logScore)
        logScore=real(log(score(1,1)));
    end
    
    % else
    %     logScore=score;
    % end
    
    %storing the score of the classifier for this sample
    clientScoreMatrix(cIndex,1)=logScore;
    
    %structure used to calculate the accuracy and error rate
    if strcmp('svm',classifierName)
        if trainUserLabels(cIndex)==predictedClass
            rightPredictions=rightPredictions+1;
        else
            wrongPredictions=wrongPredictions+1;
        end
    else
        if strcmp(trainUserLabels(cIndex),predictedClass)
            rightPredictions=rightPredictions+1;
        else
            wrongPredictions=wrongPredictions+1;
        end
    end
    
end

%% Calculating score Matrix of testSet
disp(rightPredictions);
disp(wrongPredictions);

%testing test dataset with the recent trained classifier
numSamples=length(testDataSet(:,1));
for impostorIndexes=1:numSamples
    
    sample=testDataSet(impostorIndexes,:);
    
    %existsNan=isnan(sample);
    sample(isnan(sample)) = 0;
    sample(isinf(sample)) = 0;
    
    %if ismember(1,existsNan)
    %    sample = inpaint_nans(sample);
    %end
    
    if strcmp('svm',classifierName)
        [predictedClass, accuracy, score] = svmpredict(testUserLabels(impostorIndexes), sample,classifier,'-b 1');
    else
        [predictedClass,score] = predict(classifier,sample);
    end
    %calculating the matrix score
    %if strcmp('knn',classifierName) | strcmp(classifierName,'discriminant')
    
    if score(1,2)==1
        score(1,1)=10^-100;
    elseif score(1,2)==0
        score(1,2)=10^-100;
    end
    
    logScore=real(log(score(1,1)/score(1,2)));
    if isnan(logScore) | isinf(logScore)
        %logScore=real(log(score(1,2)));
        logScore=-100;
    end
    % else
    %     logScore=score;
    % end
    
    %storing the score of the classifier for this sample
    impostorScoreMatrix(impostorIndexes,1)=logScore;
    if strcmp('svm',classifierName)
        if testUserLabels(impostorIndexes)==predictedClass
            rightPredictions=rightPredictions+1;
        else
            wrongPredictions=wrongPredictions+1;
        end
    else
        if strcmp(testUserLabels(impostorIndexes),predictedClass)
            rightPredictions=rightPredictions+1;
        else
            wrongPredictions=wrongPredictions+1;
        end
    end
    
end
disp('Right Predictions:');
disp(rightPredictions);
disp('Wrong Predictions:');
disp(wrongPredictions);
disp('Accuracy:');
disp(rightPredictions/(rightPredictions+wrongPredictions));
disp('Error Rate:');
disp(wrongPredictions/(rightPredictions+wrongPredictions));
end