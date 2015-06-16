function key=generateDoubleSumKey(keySize)
key=[];
for i=1:round(keySize/25)
    k=randperm(25);
    key =[key,k];
end
end