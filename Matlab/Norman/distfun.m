function score = distfun(x, X, metric)

if nargin<3,
  metric='euclidean';  
end;

switch metric 
  case 'euclidean'
    n = size(X,1);
    score = sqrt (sum( (repmat(x, n,1) - X) .^ 2, 2));
  case 'spearman'
    X_ = mat2cell(X,[ones(size(X,1),1)]);
    out = cellfun(@(z) corr(z', x', 'type','Spearman'), X_, 'UniformOutput', false);
    score = cell2mat(out);
end;

