function [transformed_data] = bioconvolving(biometric_data,key)

transformed_data=[];
if isempty(key)
    key=generateBioConvolvingKey(2,length(biometric_data(1,:)));
end


for sample=1:length(biometric_data(:,1))
    first=0;
    c=0;
    for i=1:length(key)-1
        %  size=key(i+1)-key(i);
        % if size~=0
        if first==0
            size=key(i+1)-key(i);
            c=biometric_data(sample,1:(size+key(i)));
            first=1;
            
        else
            n=key(i)+1;
            size=key(i+1)-key(i);
            a=biometric_data(sample,n:(size+key(i)));
            %  if ~isempty(a) & ~isempty(c)
            c=conv(c,a);
            %   end
        end
        %   end
        
    end
    transformed_data=[transformed_data;c];
end
end