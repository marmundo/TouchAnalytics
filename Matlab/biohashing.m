function [transformed_data] = biohashing(biometric_data,key)
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
% if(isempty(key))
%     key=rand(numFeatures);
% end

%protecting each biometric sample using bioghashing method with the given
%key.
for i=1:numSamples
    %biometric sample
    sample=biometric_data(i,:);
    
    % Q is a orthonormal vector
    [Q, R] = qr(key);
    
    %normalizing Q
    Q=Q/norm(Q);
    
    %inner product
    t=sample*Q;
    
    %threshold
    [h,p]=hist(t);
    [k,i]=max(h);
    
    %More frequent value get from the histogram
    threshold=p(i);
    
    %transformed biometric sample
    transformed_biometricSample=t>threshold;
    
    %transformed_biometricSample has added to the transformed data
    transformed_data=[transformed_data;transformed_biometricSample];
end

end
