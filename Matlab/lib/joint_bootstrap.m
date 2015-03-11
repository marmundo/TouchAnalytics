function rad_list = joint_bootstrap(oexpe, chosen, n_user_bstrp, n_bstrp)

user_seq = unique(oexpe.label{1,1})';

rad_list=[];
fprintf(1,'%d iterations: ',n_user_bstrp);
for n_=1:n_user_bstrp,
  
  if n_user_bstrp==1,
    %use the original data set
    expe = filter_users(oexpe, chosen, user_seq);
    
  else %with permutation only / no original data set
    chosen_ID = floor(rand(1,length(user_seq))* length(user_seq) ) + 1;
    expe = filter_users(oexpe, chosen, user_seq(chosen_ID));
  end;
      
  for t = 1:n_bstrp,
    if n_bstrp ==1, %DO NOT PERFORM SAMPLING IN CASE OF ONE BOOTSTRAP
      rexpe = expe;
    else
      d=1;
      for k=1:2, %perform bootstrap but keep the size the same as the original data set
          rexpe.dset{d,k}= bootstrap_replace(expe.dset{d,k},size(oexpe.dset{d,k},1));
      end;
    end;
        
    [wer_min, tmp_, tmp_, FAR, FRR] = wer(rexpe.dset{1,1},rexpe.dset{1,2});
    [deg_list, rad] = DET2polar(FAR,FRR,[],[]);
    rad_list=[rad_list; rad];
    
  end;
  fprintf(1,'.');
end;
fprintf(1,'\n');