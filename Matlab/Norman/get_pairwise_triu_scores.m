function [score] = get_pairwise_triu_scores(data, selected_rows)

n_= numel(selected_rows);
mask=ones(n_); mask=triu(mask) - eye(n_);
index=find(mask);

%genuine scores
score = pdist(data(selected_rows,:), @distfun);
score = squareform(score);
score = score(index);
  