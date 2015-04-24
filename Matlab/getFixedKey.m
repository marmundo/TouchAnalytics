function key=getFixedKey(cancelableFunction, keySize)
if strcmp(cancelableFunction,'Interpolation')
    key=[0.4942,0.2983,0.0715,0.9300,0.0240,0.1573,0.7370,0.2256,0.0763,0.0340,0.7855,0.1756,0.4953,0.4808,0.8389,0.9203,0.8051,0.3003,0.2362,0.1367,0.9224,0.4827,0.6794,0.1586,0.7258,0.2506,0.3365,0.5947,0.0483,0.6553,0.5235]';
    key=key(1:keySize);
elseif strcmp(cancelableFunction,'BioHashing')
    load('BioHashingKey.mat','key');
    key=key(1:keySize);
elseif strcmp(cancelableFunction,'BioConvolving')
    key=[0,round(keySize/2),keySize];
elseif strcmp(cancelableFunction,'DoubleSum')
    key=1:2:keySize;
    key=[key,2:2:keySize];
end
end