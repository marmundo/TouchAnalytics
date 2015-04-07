function [transformed_data] = interpolation(biometric_data,key)
% BIOHASHING function protects a biometric data using biometric method
% transformed_data=biohashing(biometric_data,key)
% biometric_data is the biometric data
% key is optional. key which will be used to encode the data

%starting variable
transformed_data=[];

%number of samples in the biometric data
numSamples=length(biometric_data(:,1));

%number of features in the biometric data
numFeatures=length(biometric_data(1,:));

%check if the key is empty. If yes, create a key based in the number of
%features of the biometric data
if(isempty(key))
    key=rand(numFeatures,1);
end


%protecting each biometric sample using bioghashing method with the given
%key.
for i=1:numSamples
    % getting biometric sample and normalizint it to 0 to 1
    sample=biometric_data(i,:);
    
    xCoordinates=[0:numFeature];
    xCoordinates=xCoordinates/norm(xCoordinates);
    
    %polynomial creation based on interpolation
    [P,R,S] = lagrangepoly(xCoordinates,sample);
    
    transformed_sample= polyVal(P,key)
    transformed_data=[transformed_data, transformed_sample]
end


end

