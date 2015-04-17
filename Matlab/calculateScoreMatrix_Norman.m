index = cellfun(@(x) strcmp(x,'impostor'), trainUserLabels);
%index = strcmp(trainUserLabels{1},'impostor');

trainNumLabels = zeros(size(trainUserLabels));
trainNumLabels(index==0) = 1;
trainNumLabels(index~=0) = -1;
%%
[predictedClass,score] =predict(classifier,trainingDataSet);
output=score(:,1);
output = log(output + realmin) - log(1-output + realmin);


wer(output(index~=0),output(index==0),[],1)
wer(output(index~=0),output(index==0))
%%
sum(index==0)
sum(index~=0)
%
%range_ = unique(output);
%%
range_=linspace(-0.1,1.1,13);

[count_client] = hist(output(index==0), range_);
FAR = 1 - cumsum(count_client) / sum(count_client);
[count_impostor] = hist(output(index~=0), range_);
FRR = cumsum(count_impostor) / sum(count_impostor);

%
clc
[range_'  FRR' FAR']

[range_' count_client' count_impostor']

%%
plot(range_, [1-FRR' 1-FAR'])