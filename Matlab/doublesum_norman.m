function [transformed_data] = doublesum_norman(biometric_data,key, C1, C2)
% DOUBLE SUM function protects a biometric data using biometric method
% transformed_data=doublesum(biometric_data,key)
% biometric_data is the biometric data
% key is optional. key which will be used to encode the data

[numSamples, numFeatures]=size(biometric_data);


%check if the key is empty. If yes, create a random key based in the number of
%features of the biometric data
if(isempty(key))
    key = randperm(numFeatures);
end
if nargin<3|| isempty(C1),
  C1=randi([1,25],1,length(key));
end;
if nargin<4|| isempty(C2),
  C2=randi([1,25],1,length(key));
end;

%starting variable
transformed_data=zeros(numSamples, numFeatures);

for i=1:numFeatures
  if(i>length(key))
    transformed_data(:,i)=biometric_data(:,i);
  else
    transformed_data(:,i)=biometric_data(:,key(i))+biometric_data(:,C1(i))+biometric_data(:,C2(i));
  end
end;