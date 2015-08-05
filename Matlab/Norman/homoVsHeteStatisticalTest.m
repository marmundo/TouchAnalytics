addpath ../lib
%%
%Test the statistical difference between homogeneous key and heterogeneous
%key matching scores
%%


%%
%Hete-Known
disp('----------------------------------');
disp('Known Statistical Test');
disp('----------------------------------');
%%
%BioConvolving Horizontal
bioconvolving_hete_known_Scrolling=load('main_norman_bioconvolving_hete_known-Horizontal-kSize-2');
bioconvolving_homo_known_Scrolling=load('main_norman_bioconvolving_homo_known-Horizontal-kSize-2');
[eer_hete,~,~,FAR_bioconvolving_Scrolling_hete,FRR_bioconvolving_Scrolling_hete]=wer(bioconvolving_hete_known_Scrolling.scores{1,5},bioconvolving_hete_known_Scrolling.scores{2,5});
[eer_homo,~,~,FAR_bioconvolving_Scrolling_homo,FRR_bioconvolving_Scrolling_homo]=wer(bioconvolving_homo_known_Scrolling.scores{1,5},bioconvolving_homo_known_Scrolling.scores{2,5});
[~,FAR_test] = ranksum(FAR_bioconvolving_Scrolling_hete,FAR_bioconvolving_Scrolling_homo);
[~,FRR_test] = ranksum(FRR_bioconvolving_Scrolling_hete,FRR_bioconvolving_Scrolling_homo);
statisticaltest.hete.bioconvolving.Horizontal.FRR=FRR_test;
statisticaltest.hete.bioconvolving.Horizontal.FAR=FAR_test;
disp('Horizontal');
disp('Bio Convolving');
if FRR_test==1  
  if eer_hete<eer_homo
  disp('Heterogenous FRR - Smaller');
  else
    disp('Homogeneous FRR - Smaller');
  end  
else
    disp('The homogeneous and heterogeneous Key are similar');
end
disp('----------------------------------------------')
%%
%BioConvolving Scrolling

bioconvolving_hete_known_Scrolling=load('main_norman_bioconvolving_hete_known-Scrolling-kSize-2');
bioconvolving_homo_known_Scrolling=load('main_norman_bioconvolving_homo_known-Scrolling-kSize-2');
[eer_hete,~,~,FAR_bioconvolving_Scrolling_hete,FRR_bioconvolving_Scrolling_hete]=wer(bioconvolving_hete_known_Scrolling.scores{1,5},bioconvolving_hete_known_Scrolling.scores{2,5});
[eer_homo,~,~,FAR_bioconvolving_Scrolling_homo,FRR_bioconvolving_Scrolling_homo]=wer(bioconvolving_homo_known_Scrolling.scores{1,5},bioconvolving_homo_known_Scrolling.scores{2,5});
[~,FAR_test] = ranksum(FAR_bioconvolving_Scrolling_hete,FAR_bioconvolving_Scrolling_homo);
[~,FRR_test] = ranksum(FRR_bioconvolving_Scrolling_hete,FRR_bioconvolving_Scrolling_homo);
statisticaltest.hete.bioconvolving.Horizontal.FRR=FRR_test;
statisticaltest.hete.bioconvolving.Horizontal.FAR=FAR_test;
disp('Scrolling');
disp('BioConvolving');
if FRR_test==1  
  if eer_hete<eer_homo
  disp('Heterogenous FRR - Smaller');
  else
    disp('Homogeneous FRR - Smaller');
  end  
else
    disp('The homogeneous and heterogeneous Key are similar');
end
disp('----------------------------------------------')


%%
%BioHashing Horizontal
biohash_hete_known_Scrolling=load('main_norman_biohash_hete_known-Horizontal-kSize-1');
biohash_homo_known_Scrolling=load('main_norman_biohash_homo_known-Horizontal-kSize-1');
[eer_hete,~,~,FAR_biohash_Scrolling_hete,FRR_biohash_Scrolling_hete]=wer(biohash_hete_known_Scrolling.scores{1,5},biohash_hete_known_Scrolling.scores{2,5});
[eer_homo,~,~,FAR_biohash_Scrolling_homo,FRR_biohash_Scrolling_homo]=wer(biohash_homo_known_Scrolling.scores{1,5},biohash_homo_known_Scrolling.scores{2,5});
[~,FAR_test] = ranksum(FAR_biohash_Scrolling_hete,FAR_biohash_Scrolling_homo);
[~,FRR_test] = ranksum(FRR_biohash_Scrolling_hete,FRR_biohash_Scrolling_homo);
statisticaltest.hete.biohash.Horizontal.FRR=FRR_test;
statisticaltest.hete.biohash.Horizontal.FAR=FAR_test;
disp('Horizontal');
disp('BioHashing');
if FRR_test==1  
  if eer_hete<eer_homo
  disp('Heterogenous FRR - Smaller');
  else
    disp('Homogeneous FRR - Smaller');
  end  
else
    disp('The homogeneous and heterogeneous Key are similar');
end
disp('----------------------------------------------')



%%
%BioHashing Scrolling
biohash_hete_known_Scrolling=load('main_norman_biohash_hete_known-Scrolling-kSize-1');
biohash_homo_known_Scrolling=load('main_norman_biohash_homo_known-Scrolling-kSize-1');
[eer_hete,~,~,FAR_biohash_Scrolling_hete,FRR_biohash_Scrolling_hete]=wer(biohash_hete_known_Scrolling.scores{1,5},biohash_hete_known_Scrolling.scores{2,5});
[eer_homo,~,~,FAR_biohash_Scrolling_homo,FRR_biohash_Scrolling_homo]=wer(biohash_homo_known_Scrolling.scores{1,5},biohash_homo_known_Scrolling.scores{2,5});
homo_mean=mean(FRR_biohash_Scrolling_homo);
hete_mean=mean(FRR_biohash_Scrolling_hete);
[~,FAR_test] = ranksum(FAR_biohash_Scrolling_hete,FAR_biohash_Scrolling_homo);
[~,FRR_test] = ranksum(FRR_biohash_Scrolling_hete,FRR_biohash_Scrolling_homo);
statisticaltest.hete.biohash.Horizontal.FRR=FRR_test;
statisticaltest.hete.biohash.Horizontal.FAR=FAR_test;
disp('Scrolling');
disp('BioHashing');
if FRR_test==1  
  if eer_hete<eer_homo
  disp('Heterogenous FRR - Smaller');
  else
    disp('Homogeneous FRR - Smaller');
  end  
else
    disp('The homogeneous and heterogeneous Key are similar');
end
disp('----------------------------------------------')



%%
%doublesum Horizontal
doublesum_hete_known_Scrolling=load('main_norman_doublesum_hete_known-Horizontal-kSize-25');
doublesum_homo_known_Scrolling=load('main_norman_doublesum_homo_known-Horizontal-kSize-25');
[eer_hete,~,~,FAR_doublesum_Scrolling_hete,FRR_doublesum_Scrolling_hete]=wer(doublesum_hete_known_Scrolling.scores{1,5},doublesum_hete_known_Scrolling.scores{2,5});
[eer_homo,~,~,FAR_doublesum_Scrolling_homo,FRR_doublesum_Scrolling_homo]=wer(doublesum_homo_known_Scrolling.scores{1,5},doublesum_homo_known_Scrolling.scores{2,5});
[~,FAR_test] = ranksum(FAR_doublesum_Scrolling_hete,FAR_doublesum_Scrolling_homo);
[~,FRR_test] = ranksum(FRR_doublesum_Scrolling_hete,FRR_doublesum_Scrolling_homo);
statisticaltest.hete.doublesum.Horizontal.FRR=FRR_test;
statisticaltest.hete.doublesum.Horizontal.FAR=FAR_test;
disp('Horizontal');
disp('Double Sum');
if FRR_test==1  
  if eer_hete<eer_homo
  disp('Heterogenous FRR - Smaller');
  else
    disp('Homogeneous FRR - Smaller');
  end  
else
    disp('The homogeneous and heterogeneous Key are similar');
end
disp('----------------------------------------------')


%%
%doublesum Scrolling
doublesum_hete_known_Scrolling=load('main_norman_doublesum_hete_known-Scrolling-kSize-25');
doublesum_homo_known_Scrolling=load('main_norman_doublesum_homo_known-Scrolling-kSize-25');
[eer_hete,~,~,FAR_doublesum_Scrolling_hete,FRR_doublesum_Scrolling_hete]=wer(doublesum_hete_known_Scrolling.scores{1,5},doublesum_hete_known_Scrolling.scores{2,5});
[eer_homo,~,~,FAR_doublesum_Scrolling_homo,FRR_doublesum_Scrolling_homo]=wer(doublesum_homo_known_Scrolling.scores{1,5},doublesum_homo_known_Scrolling.scores{2,5});
[~,FAR_test] = ranksum(FAR_doublesum_Scrolling_hete,FAR_doublesum_Scrolling_homo);
[~,FRR_test] = ranksum(FRR_doublesum_Scrolling_hete,FRR_doublesum_Scrolling_homo);
statisticaltest.hete.doublesum.Horizontal.FRR=FRR_test;
statisticaltest.hete.doublesum.Horizontal.FAR=FAR_test;
disp('Scrolling');
disp('Double Sum');
if FRR_test==1  
  if eer_hete<eer_homo
  disp('Heterogenous FRR - Smaller');
  else
    disp('Homogeneous FRR - Smaller');
  end  
else
    disp('The homogeneous and heterogeneous Key are similar');
end
disp('----------------------------------------------')

%%
%interpolation Horizontal
interpolation_hete_known_Scrolling=load('main_norman_interpolation_hete_known-Horizontal-kSize-25');
interpolation_homo_known_Scrolling=load('main_norman_interpolation_homo_known-Horizontal-kSize-25');
[eer_hete,~,~,FAR_interpolation_Scrolling_hete,FRR_interpolation_Scrolling_hete]=wer(interpolation_hete_known_Scrolling.scores{1,5},interpolation_hete_known_Scrolling.scores{2,5});
[eer_homo,~,~,FAR_interpolation_Scrolling_homo,FRR_interpolation_Scrolling_homo]=wer(interpolation_homo_known_Scrolling.scores{1,5},interpolation_homo_known_Scrolling.scores{2,5});
[~,FAR_test] = ranksum(FAR_interpolation_Scrolling_hete,FAR_interpolation_Scrolling_homo);
[~,FRR_test] = ranksum(FRR_interpolation_Scrolling_hete,FRR_interpolation_Scrolling_homo);
statisticaltest.hete.interpolation.Horizontal.FRR=FRR_test;
statisticaltest.hete.interpolation.Horizontal.FAR=FAR_test;
disp('Horizontal');
disp('Interpolation');
if FRR_test==1  
  if eer_hete<eer_homo
  disp('Heterogenous FRR - Smaller');
  else
    disp('Homogeneous FRR - Smaller');
  end  
else
    disp('The homogeneous and heterogeneous Key are similar');
end
disp('----------------------------------------------')


%%
%interpolation Scrolling
interpolation_hete_known_Scrolling=load('main_norman_interpolation_hete_known-Scrolling-kSize-25');
interpolation_homo_known_Scrolling=load('main_norman_interpolation_homo_known-Scrolling-kSize-25');
[eer_hete,~,~,FAR_interpolation_Scrolling_hete,FRR_interpolation_Scrolling_hete]=wer(interpolation_hete_known_Scrolling.scores{1,5},interpolation_hete_known_Scrolling.scores{2,5});
[eer_homo,~,~,FAR_interpolation_Scrolling_homo,FRR_interpolation_Scrolling_homo]=wer(interpolation_homo_known_Scrolling.scores{1,5},interpolation_homo_known_Scrolling.scores{2,5});
[~,FAR_test] = ranksum(FAR_interpolation_Scrolling_hete,FAR_interpolation_Scrolling_homo);
[~,FRR_test] = ranksum(FRR_interpolation_Scrolling_hete,FRR_interpolation_Scrolling_homo);
statisticaltest.hete.interpolation.Horizontal.FRR=FRR_test;
statisticaltest.hete.interpolation.Horizontal.FAR=FAR_test;
disp('Scrolling');
disp('Interpolation');
if FRR_test==1  
  if eer_hete<eer_homo
  disp('Heterogenous FRR - Smaller');
  else
    disp('Homogeneous FRR - Smaller');
  end  
else
    disp('The homogeneous and heterogeneous Key are similar');
end
disp('----------------------------------------------')



%%
save('HomogeneousvsHeterogeneousStatisticalTest_Known.mat','statisticaltest');
clear('statisticaltest');
%%
%Hete-Known
disp('----------------------------------');
disp('UnKnown Statistical Test');
disp('----------------------------------');
%%
%BioConvolving Horizontal
bioconvolving_hete_Unknown_Scrolling=load('main_norman_bioconvolving_hete_Unknown-Horizontal-kSize-2');
bioconvolving_homo_Unknown_Scrolling=load('main_norman_bioconvolving_homo_Unknown-Horizontal-kSize-2');
[eer_hete,~,~,FAR_bioconvolving_Scrolling_hete,FRR_bioconvolving_Scrolling_hete]=wer(bioconvolving_hete_Unknown_Scrolling.scores{1,5},bioconvolving_hete_Unknown_Scrolling.scores{2,5});
[eer_homo,~,~,FAR_bioconvolving_Scrolling_homo,FRR_bioconvolving_Scrolling_homo]=wer(bioconvolving_homo_Unknown_Scrolling.scores{1,5},bioconvolving_homo_Unknown_Scrolling.scores{2,5});
[~,FAR_test] = ranksum(FAR_bioconvolving_Scrolling_hete,FAR_bioconvolving_Scrolling_homo);
[~,FRR_test] = ranksum(FRR_bioconvolving_Scrolling_hete,FRR_bioconvolving_Scrolling_homo);
statisticaltest.hete.bioconvolving.Horizontal.FRR=FRR_test;
statisticaltest.hete.bioconvolving.Horizontal.FAR=FAR_test;
disp('Horizontal');
disp('Bio Convolving');
if FRR_test==1  
  if eer_hete<eer_homo
  disp('Heterogenous FRR - Smaller');
  else
    disp('Homogeneous FRR - Smaller');
  end  
else
    disp('The homogeneous and heterogeneous Key are similar');
end
disp('----------------------------------------------')
%%
%BioConvolving Scrolling

bioconvolving_hete_Unknown_Scrolling=load('main_norman_bioconvolving_hete_Unknown-Scrolling-kSize-2');
bioconvolving_homo_Unknown_Scrolling=load('main_norman_bioconvolving_homo_Unknown-Scrolling-kSize-2');
[eer_hete,~,~,FAR_bioconvolving_Scrolling_hete,FRR_bioconvolving_Scrolling_hete]=wer(bioconvolving_hete_Unknown_Scrolling.scores{1,5},bioconvolving_hete_Unknown_Scrolling.scores{2,5});
[eer_homo,~,~,FAR_bioconvolving_Scrolling_homo,FRR_bioconvolving_Scrolling_homo]=wer(bioconvolving_homo_Unknown_Scrolling.scores{1,5},bioconvolving_homo_Unknown_Scrolling.scores{2,5});
[~,FAR_test] = ranksum(FAR_bioconvolving_Scrolling_hete,FAR_bioconvolving_Scrolling_homo);
[~,FRR_test] = ranksum(FRR_bioconvolving_Scrolling_hete,FRR_bioconvolving_Scrolling_homo);
statisticaltest.hete.bioconvolving.Horizontal.FRR=FRR_test;
statisticaltest.hete.bioconvolving.Horizontal.FAR=FAR_test;
disp('Scrolling');
disp('BioConvolving');
if FRR_test==1  
  if eer_hete<eer_homo
  disp('Heterogenous FRR - Smaller');
  else
    disp('Homogeneous FRR - Smaller');
  end  
else
    disp('The homogeneous and heterogeneous Key are similar');
end
disp('----------------------------------------------')


%%
%BioHashing Horizontal
biohash_hete_Unknown_Scrolling=load('main_norman_biohash_hete_Unknown-Horizontal-kSize-1');
biohash_homo_Unknown_Scrolling=load('main_norman_biohash_homo_Unknown-Horizontal-kSize-1');
[eer_hete,~,~,FAR_biohash_Scrolling_hete,FRR_biohash_Scrolling_hete]=wer(biohash_hete_Unknown_Scrolling.scores{1,5},biohash_hete_Unknown_Scrolling.scores{2,5});
[eer_homo,~,~,FAR_biohash_Scrolling_homo,FRR_biohash_Scrolling_homo]=wer(biohash_homo_Unknown_Scrolling.scores{1,5},biohash_homo_Unknown_Scrolling.scores{2,5});
[~,FAR_test] = ranksum(FAR_biohash_Scrolling_hete,FAR_biohash_Scrolling_homo);
[~,FRR_test] = ranksum(FRR_biohash_Scrolling_hete,FRR_biohash_Scrolling_homo);
statisticaltest.hete.biohash.Horizontal.FRR=FRR_test;
statisticaltest.hete.biohash.Horizontal.FAR=FAR_test;
disp('Horizontal');
disp('BioHashing');
if FRR_test==1  
  if eer_hete<eer_homo
  disp('Heterogenous FRR - Smaller');
  else
    disp('Homogeneous FRR - Smaller');
  end  
else
    disp('The homogeneous and heterogeneous Key are similar');
end
disp('----------------------------------------------')



%%
%BioHashing Scrolling
biohash_hete_Unknown_Scrolling=load('main_norman_biohash_hete_Unknown-Scrolling-kSize-1');
biohash_homo_Unknown_Scrolling=load('main_norman_biohash_homo_Unknown-Scrolling-kSize-1');
[eer_hete,~,~,FAR_biohash_Scrolling_hete,FRR_biohash_Scrolling_hete]=wer(biohash_hete_Unknown_Scrolling.scores{1,5},biohash_hete_Unknown_Scrolling.scores{2,5});
[eer_homo,~,~,FAR_biohash_Scrolling_homo,FRR_biohash_Scrolling_homo]=wer(biohash_homo_Unknown_Scrolling.scores{1,5},biohash_homo_Unknown_Scrolling.scores{2,5});
[~,FAR_test] = ranksum(FAR_biohash_Scrolling_hete,FAR_biohash_Scrolling_homo);
[~,FRR_test] = ranksum(FRR_biohash_Scrolling_hete,FRR_biohash_Scrolling_homo);
statisticaltest.hete.biohash.Horizontal.FRR=FRR_test;
statisticaltest.hete.biohash.Horizontal.FAR=FAR_test;
disp('Scrolling');
disp('BioHashing');
if FRR_test==1  
  if eer_hete<eer_homo
  disp('Heterogenous FRR - Smaller');
  else
    disp('Homogeneous FRR - Smaller');
  end  
else
    disp('The homogeneous and heterogeneous Key are similar');
end
disp('----------------------------------------------')



%%
%doublesum Horizontal
doublesum_hete_Unknown_Scrolling=load('main_norman_doublesum_hete_Unknown-Horizontal-kSize-25');
doublesum_homo_Unknown_Scrolling=load('main_norman_doublesum_homo_Unknown-Horizontal-kSize-25');
[eer_hete,~,~,FAR_doublesum_Scrolling_hete,FRR_doublesum_Scrolling_hete]=wer(doublesum_hete_Unknown_Scrolling.scores{1,5},doublesum_hete_Unknown_Scrolling.scores{2,5});
[eer_homo,~,~,FAR_doublesum_Scrolling_homo,FRR_doublesum_Scrolling_homo]=wer(doublesum_homo_Unknown_Scrolling.scores{1,5},doublesum_homo_Unknown_Scrolling.scores{2,5});
[~,FAR_test] = ranksum(FAR_doublesum_Scrolling_hete,FAR_doublesum_Scrolling_homo);
[~,FRR_test] = ranksum(FRR_doublesum_Scrolling_hete,FRR_doublesum_Scrolling_homo);
statisticaltest.hete.doublesum.Horizontal.FRR=FRR_test;
statisticaltest.hete.doublesum.Horizontal.FAR=FAR_test;
disp('Horizontal');
disp('Double Sum');
if FRR_test==1  
  if eer_hete<eer_homo
  disp('Heterogenous FRR - Smaller');
  else
    disp('Homogeneous FRR - Smaller');
  end  
else
    disp('The homogeneous and heterogeneous Key are similar');
end
disp('----------------------------------------------')


%%
%doublesum Scrolling
doublesum_hete_Unknown_Scrolling=load('main_norman_doublesum_hete_Unknown-Scrolling-kSize-25');
doublesum_homo_Unknown_Scrolling=load('main_norman_doublesum_homo_Unknown-Scrolling-kSize-25');
[eer_hete,~,~,FAR_doublesum_Scrolling_hete,FRR_doublesum_Scrolling_hete]=wer(doublesum_hete_Unknown_Scrolling.scores{1,5},doublesum_hete_Unknown_Scrolling.scores{2,5});
[eer_homo,~,~,FAR_doublesum_Scrolling_homo,FRR_doublesum_Scrolling_homo]=wer(doublesum_homo_Unknown_Scrolling.scores{1,5},doublesum_homo_Unknown_Scrolling.scores{2,5});
[~,FAR_test] = ranksum(FAR_doublesum_Scrolling_hete,FAR_doublesum_Scrolling_homo);
[~,FRR_test] = ranksum(FRR_doublesum_Scrolling_hete,FRR_doublesum_Scrolling_homo);
statisticaltest.hete.doublesum.Horizontal.FRR=FRR_test;
statisticaltest.hete.doublesum.Horizontal.FAR=FAR_test;
disp('Scrolling');
disp('Double Sum');
if FRR_test==1  
  if eer_hete<eer_homo
  disp('Heterogenous FRR - Smaller');
  else
    disp('Homogeneous FRR - Smaller');
  end  
else
    disp('The homogeneous and heterogeneous Key are similar');
end
disp('----------------------------------------------')

%%
%interpolation Horizontal
interpolation_hete_Unknown_Scrolling=load('main_norman_interpolation_hete_Unknown-Horizontal-kSize-25');
interpolation_homo_Unknown_Scrolling=load('main_norman_interpolation_homo_Unknown-Horizontal-kSize-25');
[eer_hete,~,~,FAR_interpolation_Scrolling_hete,FRR_interpolation_Scrolling_hete]=wer(interpolation_hete_Unknown_Scrolling.scores{1,5},interpolation_hete_Unknown_Scrolling.scores{2,5});
[eer_homo,~,~,FAR_interpolation_Scrolling_homo,FRR_interpolation_Scrolling_homo]=wer(interpolation_homo_Unknown_Scrolling.scores{1,5},interpolation_homo_Unknown_Scrolling.scores{2,5});
[~,FAR_test] = ranksum(FAR_interpolation_Scrolling_hete,FAR_interpolation_Scrolling_homo);
[~,FRR_test] = ranksum(FRR_interpolation_Scrolling_hete,FRR_interpolation_Scrolling_homo);
statisticaltest.hete.interpolation.Horizontal.FRR=FRR_test;
statisticaltest.hete.interpolation.Horizontal.FAR=FAR_test;
disp('Horizontal');
disp('Interpolation');
if FRR_test==1  
  if eer_hete<eer_homo
  disp('Heterogenous FRR - Smaller');
  else
    disp('Homogeneous FRR - Smaller');
  end  
else
    disp('The homogeneous and heterogeneous Key are similar');
end
disp('----------------------------------------------')


%%
%interpolation Scrolling
interpolation_hete_Unknown_Scrolling=load('main_norman_interpolation_hete_Unknown-Scrolling-kSize-25');
interpolation_homo_Unknown_Scrolling=load('main_norman_interpolation_homo_Unknown-Scrolling-kSize-25');
[eer_hete,~,~,FAR_interpolation_Scrolling_hete,FRR_interpolation_Scrolling_hete]=wer(interpolation_hete_Unknown_Scrolling.scores{1,5},interpolation_hete_Unknown_Scrolling.scores{2,5});
[eer_homo,~,~,FAR_interpolation_Scrolling_homo,FRR_interpolation_Scrolling_homo]=wer(interpolation_homo_Unknown_Scrolling.scores{1,5},interpolation_homo_Unknown_Scrolling.scores{2,5});
[~,FAR_test] = ranksum(FAR_interpolation_Scrolling_hete,FAR_interpolation_Scrolling_homo);
[~,FRR_test] = ranksum(FRR_interpolation_Scrolling_hete,FRR_interpolation_Scrolling_homo);
statisticaltest.hete.interpolation.Horizontal.FRR=FRR_test;
statisticaltest.hete.interpolation.Horizontal.FAR=FAR_test;
disp('Scrolling');
disp('Interpolation');
if FRR_test==1  
  if eer_hete<eer_homo
  disp('Heterogenous FRR - Smaller');
  else
    disp('Homogeneous FRR - Smaller');
  end  
else
    disp('The homogeneous and heterogeneous Key are similar');
end
disp('----------------------------------------------')



%%
save('HomogeneousvsHeterogeneousStatisticalTest_UnKnown.mat','statisticaltest');
clear('statisticaltest');