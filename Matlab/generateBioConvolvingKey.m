function [key]=generateBioConvolvingKey(w,n)
%w= number of partitions. We consider the w as the size of the key
%n= number of features of the biometric data
  %% dj random numbers
    
    %random numbers between 1 and 99
    r = (99-1).*rand(w-1,1) + 1;
    d=sort(r);
    
    %% Putting 0 at index 1 and 100 in the last position
    d(2:end+1)=d;
    d(1)=0;
    d(end+1)=100;
    
    key=round((d/100)*n);

    if key(w)==n ||key(w)==0
        key=generateBioConvolvingKey(w,n);
    end
end