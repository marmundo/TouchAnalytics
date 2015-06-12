function [transformed_data] = doublesum(biometric_data,key)
% DOUBLE SUM function protects a biometric data using biometric method
% transformed_data=doublesum(biometric_data,key)
% biometric_data is the biometric data
% key is optional. key which will be used to encode the data

%number of samples in the biometric data
numSamples=length(biometric_data(:,1));

%number of features in the biometric data
numFeatures=length(biometric_data(1,:));

%starting variable
transformed_data=[];

%check if the key is empty. If yes, create a random key based in the number of
%features of the biometric data
if(isempty(key))
    key = randperm(numFeatures);
end

%protecting each biometric sample using doublesum method with the given
%key.

C1=randperm(length(key));
C2=randperm(length(key));


for i=1:numFeatures
    if(i>length(key))
        transformed_data(:,i)=biometric_data(:,i);
    else
        transformed_data(:,i)=biometric_data(:,key(i))+biometric_data(:,C1(i))+biometric_data(:,C2(i));
    end
end
end