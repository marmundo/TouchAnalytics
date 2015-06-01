function score = get_pairwise_scores(data, selected_rows, selected_cols, method, com)

if nargin<4 || isempty(method),
  method = 'euclidean';
end;

%dist = @(x,y) sqrt( sum((x-y) .^ 2) );

n_rows= numel(selected_rows);
n_cols= numel(selected_cols);

%genuine scores
score=zeros(n_rows, n_cols);

switch method,
  case 'euclidean'
    for r=1:numel(selected_rows),
      score(r,:) =  -distfun( data(selected_rows(r),:), data(selected_cols,:));
    end;
  case 'logistic'
    for r=1:numel(selected_rows),
      score(r,:) =  glmval(com.B, data(selected_cols,:));
    end;
end;