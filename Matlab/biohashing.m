%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%BioHashing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [transformed_data] = biohashing(biometric_data,key)
transformed_data=[];
numSamples=length(biometric_data(:,1));
numFeatures=length(biometric_data(1,:));


if(isempty(key))
    key=rand(numFeatures);
end

for i=1:numSamples
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

    transformed_data=[transformed_data;transformed_biometricSample];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
