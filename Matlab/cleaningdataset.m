function [dataset]=cleaningdataset(dataset)
% This function remove Inf and NaN samples
dataset(isnan(dataset)) = 0 ;
dataset(isinf(dataset)) = 0 ;

%removing phoneId,docId
dataset(:,[13,2])=[];

end