addpath ../lib
%%
%Test the statistical difference between baseline and the cancelable method scores
%%

baselineHorizontal=load('main_norman-Horizontal.mat');
[~,~,~,FAR_baseline_Horizontal,FRR_baseline_Horizontal]=wer(baselineHorizontal.scores{1,5},baselineHorizontal.scores{2,5});
baselineScrolling=load('main_norman-Scrolling.mat');
[~,~,~,FAR_baseline_Scrolling,FRR_baseline_Scrolling]=wer(baselineScrolling.scores{1,5},baselineScrolling.scores{2,5});

%%
%Hete-Known
disp('----------------------------------');
disp('Heterogeneous Known Statistical Test');
disp('----------------------------------');
%%

%BioConvolving Horizontal
bioconvolving_hete_known_Horizontal=load('main_norman_bioconvolving_hete_known-Horizontal-kSize-2');
[~,~,~,FAR_bioconvolving_Horizontal,FRR_bioconvolving_Horizontal]=wer(bioconvolving_hete_known_Horizontal.scores{1,5},bioconvolving_hete_known_Horizontal.scores{2,5});
FAR_test=kstest2(FAR_baseline_Horizontal,FAR_bioconvolving_Horizontal,'Tail','larger');
FRR_test=kstest2(FRR_baseline_Horizontal,FRR_bioconvolving_Horizontal,'Tail','larger');
statisticaltest.hete.bioconvolving.Horizontal.FRR=FRR_test;
statisticaltest.hete.bioconvolving.Horizontal.FAR=FAR_test;
if FRR_test==1
  disp('Horizontal');
  disp('Baseline vs BioConvolving FRR - Smaller');
  disp('----------------------------------');
elseif FAR_test==1 
  disp('Horizontal');
  disp('Baseline vs BioConvolving FAR - Smaller');
  disp('----------------------------------');
end
%%
%BioConvolving Scrolling
bioconvolving_hete_known_Scrolling=load('main_norman_bioconvolving_hete_known-Scrolling-kSize-2');
[~,~,~,FAR_bioconvolving_Scrolling,FRR_bioconvolving_Scrolling]=wer(bioconvolving_hete_known_Scrolling.scores{1,5},bioconvolving_hete_known_Scrolling.scores{2,5});
FAR_test=kstest2(FAR_baseline_Scrolling,FAR_bioconvolving_Scrolling,'Tail','larger');
FRR_test=kstest2(FRR_baseline_Scrolling,FRR_bioconvolving_Scrolling,'Tail','larger');
statisticaltest.hete.bioconvolving.Scrolling.FRR=FRR_test;
statisticaltest.hete.bioconvolving.Scrolling.FAR=FAR_test;
if FRR_test==1   
  disp('Scrolling');
  disp('Baseline vs BioConvolving FRR - Smaller')
  disp('----------------------------------');
elseif FAR_test==1 
  disp('Scrolling');
  disp('Baseline vs BioConvolving FAR - Smaller')
  disp('----------------------------------');
end

%%
%BioHashing Horizontal
biohash_hete_known_Horizontal=load('main_norman_biohash_hete_known-Horizontal-kSize-1');
[~,~,~,FAR_biohash_Horizontal,FRR_biohash_Horizontal]=wer(biohash_hete_known_Horizontal.scores{1,5},biohash_hete_known_Horizontal.scores{2,5});
FAR_test=kstest2(FAR_baseline_Horizontal,FAR_biohash_Horizontal,'Tail','larger');
FRR_test=kstest2(FRR_baseline_Horizontal,FRR_biohash_Horizontal,'Tail','larger');
statisticaltest.hete.biohash.Horizontal.FRR=FRR_test;
statisticaltest.hete.biohash.Horizontal.FAR=FAR_test;
if FRR_test==1 
  disp('Horizontal');
  disp('Baseline vs BioHashing FRR - Smaller')
  disp('----------------------------------');
elseif FAR_test==1 
  disp('Horizontal');
  disp('Baseline vs BioHashing FAR - Smaller')
  disp('----------------------------------');
end

%%
%BioHashing Scrolling
biohash_hete_known_Scrolling=load('main_norman_biohash_hete_known-Scrolling-kSize-1');
[~,~,~,FAR_biohash_Scrolling,FRR_biohash_Scrolling]=wer(biohash_hete_known_Scrolling.scores{1,5},biohash_hete_known_Scrolling.scores{2,5});
FAR_test=kstest2(FAR_baseline_Scrolling,FAR_biohash_Scrolling,'Tail','larger');
FRR_test=kstest2(FRR_baseline_Scrolling,FRR_biohash_Scrolling,'Tail','larger');
statisticaltest.hete.bioHashing.Scrolling.FRR=FRR_test;
statisticaltest.hete.bioHashing.Scrolling.FAR=FAR_test;
if FRR_test==1 
  disp('Scrolling');
  disp('Baseline vs BioHashing FRR - Smaller')
  disp('----------------------------------');
elseif FAR_test==1 
  disp('Scrolling');
  disp('Baseline vs BioHashing FAR - Smaller')
  disp('----------------------------------');
end

%%
%doublesum Horizontal
doublesum_hete_known_Horizontal=load('main_norman_doublesum_hete_known-Horizontal-kSize-25');
[~,~,~,FAR_doublesum_Horizontal,FRR_doublesum_Horizontal]=wer(doublesum_hete_known_Horizontal.scores{1,5},doublesum_hete_known_Horizontal.scores{2,5});
FAR_test=kstest2(FAR_baseline_Horizontal,FAR_doublesum_Horizontal,'Tail','larger');
FRR_test=kstest2(FRR_baseline_Horizontal,FRR_doublesum_Horizontal,'Tail','larger');
statisticaltest.hete.doublesum.Horizontal.FRR=FRR_test;
statisticaltest.hete.doublesum.Horizontal.FAR=FAR_test;
if FRR_test==1 
  disp('Horizontal');
  disp('Baseline vs Double Sum FRR - Smaller')
  disp('----------------------------------');
elseif FAR_test==1 
  disp('Horizontal');
  disp('Baseline vs Double Sum FAR - Smaller')
  disp('----------------------------------');
end

%%
%doublesum Scrolling
doublesum_hete_known_Scrolling=load('main_norman_doublesum_hete_known-Scrolling-kSize-25');
[~,~,~,FAR_doublesum_Scrolling,FRR_doublesum_Scrolling]=wer(doublesum_hete_known_Scrolling.scores{1,5},doublesum_hete_known_Scrolling.scores{2,5});
FAR_test=kstest2(FAR_baseline_Scrolling,FAR_doublesum_Scrolling,'Tail','larger');
FRR_test=kstest2(FRR_baseline_Scrolling,FRR_doublesum_Scrolling,'Tail','larger');
statisticaltest.hete.doublesum.Scrolling.FRR=FRR_test;
statisticaltest.hete.doublesum.Scrolling.FAR=FAR_test;
if FRR_test==1 
  disp('Scrolling');
  disp('Baseline vs Double Sum FRR - Smaller')
  disp('----------------------------------');
elseif FAR_test==1 
  disp('Scrolling');
  disp('Baseline vs Double Sum FAR - Smaller')
  disp('----------------------------------');
end

%%
%interpolation Horizontal
interpolation_hete_known_Horizontal=load('main_norman_interpolation_hete_known-Horizontal-kSize-25');
[~,~,~,FAR_interpolation_Horizontal,FRR_interpolation_Horizontal]=wer(interpolation_hete_known_Horizontal.scores{1,5},interpolation_hete_known_Horizontal.scores{2,5});
FAR_test=kstest2(FAR_baseline_Horizontal,FAR_interpolation_Horizontal,'Tail','larger');
FRR_test=kstest2(FRR_baseline_Horizontal,FRR_interpolation_Horizontal,'Tail','larger');
statisticaltest.hete.interpolation.Horizontal.FRR=FRR_test;
statisticaltest.hete.interpolation.Horizontal.FAR=FAR_test;
if FRR_test==1 
  disp('Horizontal');
  disp('Baseline vs Interpolation FRR - Smaller')
  disp('----------------------------------');
elseif FAR_test==1 
  disp('Horizontal');
  disp('Baseline vs Interpolation FAR - Smaller')
  disp('----------------------------------');
end

%%
%interpolation Scrolling
interpolation_hete_known_Scrolling=load('main_norman_interpolation_hete_known-Scrolling-kSize-25');
[~,~,~,FAR_interpolation_Scrolling,FRR_interpolation_Scrolling]=wer(interpolation_hete_known_Scrolling.scores{1,5},interpolation_hete_known_Scrolling.scores{2,5});
FAR_test=kstest2(FAR_baseline_Scrolling,FAR_interpolation_Scrolling,'Tail','larger');
FRR_test=kstest2(FRR_baseline_Scrolling,FRR_interpolation_Scrolling,'Tail','larger');
statisticaltest.hete.interpolation.Scrolling.FRR=FRR_test;
statisticaltest.hete.interpolation.Scrolling.FAR=FAR_test;
if FRR_test==1 
  disp('Scrolling');
  disp('Baseline vs Interpolation FRR - Smaller')
  disp('----------------------------------');
elseif FAR_test==1 
  disp('Scrolling');
  disp('Baseline vs Interpolation FAR - Smaller')
  disp('----------------------------------');
end

%%
save('StatisticalTest_Known_Hete.mat','statisticaltest');
clear();
%%
baselineHorizontal=load('main_norman-Horizontal.mat');
[~,~,~,FAR_baseline_Horizontal,FRR_baseline_Horizontal]=wer(baselineHorizontal.scores{1,5},baselineHorizontal.scores{2,5});
baselineScrolling=load('main_norman-Scrolling.mat');
[~,~,~,FAR_baseline_Scrolling,FRR_baseline_Scrolling]=wer(baselineScrolling.scores{1,5},baselineScrolling.scores{2,5});
%%
%Homo-Known
disp('----------------------------------');
disp('Homogeneous Known Statistical Test');
disp('----------------------------------');
%%
%BioConvolving Horizontal
bioconvolving_homo_known_Horizontal=load('main_norman_bioconvolving_homo_known-Horizontal-kSize-2');
[~,~,~,FAR_bioconvolving_Horizontal,FRR_bioconvolving_Horizontal]=wer(bioconvolving_homo_known_Horizontal.scores{1,5},bioconvolving_homo_known_Horizontal.scores{2,5});
FAR_test=kstest2(FAR_baseline_Horizontal,FAR_bioconvolving_Horizontal,'Tail','larger');
FRR_test=kstest2(FRR_baseline_Horizontal,FRR_bioconvolving_Horizontal,'Tail','larger');
statisticaltest.homo.bioconvolving.Horizontal.FRR=FRR_test;
statisticaltest.homo.bioconvolving.Horizontal.FAR=FAR_test;
if FRR_test==1 
  disp('Horizontal');
  disp('Baseline vs BioConvolving FRR - Smaller')
  disp('----------------------------------');
elseif FAR_test==1 
  disp('Horizontal');
  disp('Baseline vs BioConvolving FAR - Smaller')
  disp('----------------------------------');
end
%%
%BioConvolving Scrolling
bioconvolving_homo_known_Scrolling=load('main_norman_bioconvolving_homo_known-Scrolling-kSize-2');
[~,~,~,FAR_bioconvolving_Scrolling,FRR_bioconvolving_Scrolling]=wer(bioconvolving_homo_known_Scrolling.scores{1,5},bioconvolving_homo_known_Scrolling.scores{2,5});
FAR_test=kstest2(FAR_baseline_Scrolling,FAR_bioconvolving_Scrolling,'Tail','larger');
FRR_test=kstest2(FRR_baseline_Scrolling,FRR_bioconvolving_Scrolling,'Tail','larger');
statisticaltest.homo.bioconvolving.Scrolling.FRR=FRR_test;
statisticaltest.homo.bioconvolving.Scrolling.FAR=FAR_test;
if FRR_test==1 
  disp('Scrolling');
  disp('Baseline vs BioConvolving FRR - Smaller')
  disp('----------------------------------');
elseif FAR_test==1 
  disp('Scrolling');
  disp('Baseline vs BioConvolving FAR - Smaller')
  disp('----------------------------------');
end

%%
%BioHashing Horizontal
biohash_homo_known_Horizontal=load('main_norman_biohash_homo_known-Horizontal-kSize-1');
[~,~,~,FAR_biohash_Horizontal,FRR_biohash_Horizontal]=wer(biohash_homo_known_Horizontal.scores{1,5},biohash_homo_known_Horizontal.scores{2,5});
FAR_test=kstest2(FAR_baseline_Horizontal,FAR_biohash_Horizontal,'Tail','larger');
FRR_test=kstest2(FRR_baseline_Horizontal,FRR_biohash_Horizontal,'Tail','larger');
statisticaltest.homo.biohash.Horizontal.FRR=FRR_test;
statisticaltest.homo.biohash.Horizontal.FAR=FAR_test;
if FRR_test==1 
  disp('Horizontal');
  disp('Baseline vs BioHashing FRR - Smaller')
  disp('----------------------------------');
elseif FAR_test==1 
  disp('Horizontal');
  disp('Baseline vs BioHashing FAR - Smaller')
  disp('----------------------------------');
end

%%
%BioHashing Scrolling
biohash_homo_known_Scrolling=load('main_norman_biohash_homo_known-Scrolling-kSize-1');
[~,~,~,FAR_biohash_Scrolling,FRR_biohash_Scrolling]=wer(biohash_homo_known_Scrolling.scores{1,5},biohash_homo_known_Scrolling.scores{2,5});
FAR_test=kstest2(FAR_baseline_Scrolling,FAR_biohash_Scrolling,'Tail','larger');
FRR_test=kstest2(FRR_baseline_Scrolling,FRR_biohash_Scrolling,'Tail','larger');
statisticaltest.homo.bioHashing.Scrolling.FRR=FRR_test;
statisticaltest.homo.bioHashing.Scrolling.FAR=FAR_test;
if FRR_test==1 
  disp('Scrolling');
  disp('Baseline vs BioHashing FRR - Smaller')
  disp('----------------------------------');
elseif FAR_test==1 
  disp('Scrolling');
  disp('Baseline vs BioHashing FAR - Smaller')
  disp('----------------------------------');
end

%%
%doublesum Horizontal
doublesum_homo_known_Horizontal=load('main_norman_doublesum_homo_known-Horizontal-kSize-25');
[~,~,~,FAR_doublesum_Horizontal,FRR_doublesum_Horizontal]=wer(doublesum_homo_known_Horizontal.scores{1,5},doublesum_homo_known_Horizontal.scores{2,5});
FAR_test=kstest2(FAR_baseline_Horizontal,FAR_doublesum_Horizontal,'Tail','larger');
FRR_test=kstest2(FRR_baseline_Horizontal,FRR_doublesum_Horizontal,'Tail','larger');
statisticaltest.homo.doublesum.Horizontal.FRR=FRR_test;
statisticaltest.homo.doublesum.Horizontal.FAR=FAR_test;
if FRR_test==1 
  disp('Horizontal');
  disp('Baseline vs Double Sum FRR - Smaller')
  disp('----------------------------------');
elseif FAR_test==1 
  disp('Horizontal');
  disp('Baseline vs Double Sum FAR - Smaller')
  disp('----------------------------------');
end

%%
%doublesum Scrolling
doublesum_homo_known_Scrolling=load('main_norman_doublesum_homo_known-Scrolling-kSize-25');
[~,~,~,FAR_doublesum_Scrolling,FRR_doublesum_Scrolling]=wer(doublesum_homo_known_Scrolling.scores{1,5},doublesum_homo_known_Scrolling.scores{2,5});
FAR_test=kstest2(FAR_baseline_Scrolling,FAR_doublesum_Scrolling,'Tail','larger');
FRR_test=kstest2(FRR_baseline_Scrolling,FRR_doublesum_Scrolling,'Tail','larger');
statisticaltest.homo.doublesum.Scrolling.FRR=FRR_test;
statisticaltest.homo.doublesum.Scrolling.FAR=FAR_test;
if FRR_test==1 
  disp('Scrolling');
  disp('Baseline vs Double Sum FRR - Smaller')
  disp('----------------------------------');
elseif FAR_test==1 
  disp('Scrolling');
  disp('Baseline vs Double Sum FAR - Smaller')
  disp('----------------------------------');
end

%%
%interpolation Horizontal
interpolation_homo_known_Horizontal=load('main_norman_interpolation_homo_known-Horizontal-kSize-25');
[~,~,~,FAR_interpolation_Horizontal,FRR_interpolation_Horizontal]=wer(interpolation_homo_known_Horizontal.scores{1,5},interpolation_homo_known_Horizontal.scores{2,5});
FAR_test=kstest2(FAR_baseline_Horizontal,FAR_interpolation_Horizontal,'Tail','larger');
FRR_test=kstest2(FRR_baseline_Horizontal,FRR_interpolation_Horizontal,'Tail','larger');
statisticaltest.homo.interpolation.Horizontal.FRR=FRR_test;
statisticaltest.homo.interpolation.Horizontal.FAR=FAR_test;
if FRR_test==1 
  disp('Horizontal');
  disp('Baseline vs Interpolation FRR - Smaller')
  disp('----------------------------------');
elseif FAR_test==1 
  disp('Horizontal');
  disp('Baseline vs Interpolation FAR - Smaller')
  disp('----------------------------------');
end

%%
%interpolation Scrolling
interpolation_homo_known_Scrolling=load('main_norman_interpolation_homo_known-Scrolling-kSize-25');
[~,~,~,FAR_interpolation_Scrolling,FRR_interpolation_Scrolling]=wer(interpolation_homo_known_Scrolling.scores{1,5},interpolation_homo_known_Scrolling.scores{2,5});
FAR_test=kstest2(FAR_baseline_Scrolling,FAR_interpolation_Scrolling,'Tail','larger');
FRR_test=kstest2(FRR_baseline_Scrolling,FRR_interpolation_Scrolling,'Tail','larger');
statisticaltest.homo.interpolation.Scrolling.FRR=FRR_test;
statisticaltest.homo.interpolation.Scrolling.FAR=FAR_test;
if FRR_test==1 
  disp('Scrolling');
  disp('Baseline vs Interpolation FRR - Smaller')
  disp('----------------------------------');
elseif FAR_test==1 
  disp('Scrolling');
  disp('Baseline vs Interpolation FAR - Smaller')
  disp('----------------------------------');
end

%%
save('StatisticalTest_Known_homo.mat','statisticaltest');
clear();