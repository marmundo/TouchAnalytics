function key=getFixedKey(cancelableFunction, keySize)
if strcmp(cancelableFunction,'Interpolation')    
    key=[0.954985391322620,8.30768954882670,1.38514171893462,2.91395343707543,24.7037348498188,20.8448586892745,9.51298440182582,28.5066614651506,1.03338241508726,13.1623307896919,11.4467537127903,22.9655036444701,23.8559970341119,5.60617813663136,14.6929318736469,13.3675860213270,19.3893903033379,21.2809449257422,22.6406004594708,8.28075230995735,20.3910803056102,19.6529401192152,4.87835205583892,3.56993044675130,14.9509215594643,28.7923187554824,10.2115717999840,17.5580325293933,6.71435818473411,22.5380117791696,7.65285346377807,13.645636345345353];
    key=key(1:keySize);
elseif strcmp(cancelableFunction,'BioHashing')
    load('BioHashingKey.mat','key');
    key=key(1:keySize,1:keySize);
elseif strcmp(cancelableFunction,'BioConvolving')
    p=keySize.nFeatures/keySize.partitions;
    key=[1];
    for i=1:keySize.partitions-1
        if p*i>keySize.nFeatures
            break
        end
        key=[key,round(p*i)];
    end
    key=[key,keySize.nFeatures];
%     key=[0,round(keySize/2),keySize];
elseif strcmp(cancelableFunction,'DoubleSum')
    key=1:2:keySize;
    key=[key,2:2:keySize];
end
end