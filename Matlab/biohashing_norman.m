function [transformed_data] = biohashing(biometric_data,key)
% BIOHASHING function protects a biometric data using biometric method
% transformed_data=biohashing(biometric_data,key)
% biometric_data is the biometric data
% key is optional. key which will be used to encode the data

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

%% do the following first, out of the loop
% Q is a orthonormal vector
[Q, R] = qr(key);

%normalizing Q
Q=Q/norm(Q);

%%
t=biometric_data*Q;

%%
%[h,p]=hist(t(:),100);
%[k,i]=max(h);
    
transformed_data = t>0;