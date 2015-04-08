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
    key = round((numFeatures-1).*rand(numFeatures,1) + 1);
    
end

%protecting each biometric sample using doublesum method with the given
%key.
for i=1:numSamples
    
    % getting biometric sample
    sample=biometric_data(i,:);
    
    %alocating variable
    B=zeros(1,numFeatures);
    
    for i=1:numFeatures
        B(i)=sample(key(i));
    end
    
    C1=round((numFeatures-1).*rand(numFeatures,1) + 1);
    C2=round((numFeatures-1).*rand(numFeatures,1) + 1);
    
    %alocating variable
    transformed_sample=zeros(1, numFeatures);

    for i=1:numFeatures
       transformed_sample(i)=B(i)+sample(C1(i))+sample(C2(i));
    end    
    transformed_data= [transformed_data; transformed_sample];
end
end