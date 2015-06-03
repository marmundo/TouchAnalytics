function nexpe = filter_users(expe, chosen, user_seq, d)
if nargin<2|length(chosen)==0,
  chosen = 1;
end;
if nargin<4,
  d=1;
end;

model_ID = unique(expe.label{1,1})';

for k=1:2,
  nexpe.dset{d,k} = [];
  nexpe.label{d,k} = [];
end;

%for id=1:size(model_ID,1),
for id=user_seq,
  %get the data set associated to the ID
  %fprintf(1,'%d\n',id);
  for k=1:2,
    index{d,k} = find(expe.label{d,k} == id);
    tmp{d,k} = expe.dset{d,k}(index{d,k},chosen);
    nexpe.dset{d,k} = [nexpe.dset{d,k}; tmp{d,k}];
    nexpe.label{d,k} = [nexpe.label{d,k}; expe.label{d,k}(index{d,k})];
  end;
end;