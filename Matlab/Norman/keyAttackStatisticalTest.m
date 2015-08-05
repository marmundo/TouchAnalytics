addpath ../lib
%%
%Test the statistical difference between baseline and the cancelable method scores
%%

baselineHorizontal=load('main_norman-Horizontal.mat');
[eer_baseline_horizontal,~,~,FAR_baseline_Horizontal,FRR_baseline_Horizontal]=wer(baselineHorizontal.scores{1,5},baselineHorizontal.scores{2,5});
baselineScrolling=load('main_norman-Scrolling.mat');
[eer_baseline_scrolling,~,~,FAR_baseline_Scrolling,FRR_baseline_Scrolling]=wer(baselineScrolling.scores{1,5},baselineScrolling.scores{2,5});

%%
%Hete-Known
disp('----------------------------------');
disp('Heterogeneous Known Statistical Test');
disp('----------------------------------');
%%
eer_horizontal=zeros(4,4)
eer_scrolling=zeros(4,4)
%BioConvolving Horizontal
bioconvolving_hete_known_Horizontal=load('main_norman_bioconvolving_hete_known-Horizontal-kSize-2');
[eer,~,~,FAR_bioconvolving_Horizontal,FRR_bioconvolving_Horizontal]=wer(bioconvolving_hete_known_Horizontal.scores{1,5},bioconvolving_hete_known_Horizontal.scores{2,5});
eer_horizontal(3,2)=eer;
FAR_test=kstest2(FAR_baseline_Horizontal,FAR_bioconvolving_Horizontal);
FRR_test=kstest2(FRR_baseline_Horizontal,FRR_bioconvolving_Horizontal);
statisticaltest.hete.bioconvolving.Horizontal.FRR=FRR_test;
statisticaltest.hete.bioconvolving.Horizontal.FAR=FAR_test;
if FRR_test==1
  disp('Horizontal');
  if eer_baseline_horizontal<eer
  disp('Baseline vs BioConvolving FRR - Smaller');
  else
    disp('Baseline vs BioConvolving FRR - Larger');
  end  
  disp('----------------------------------------------')
end
%%
%BioConvolving Scrolling
bioconvolving_hete_known_Scrolling=load('main_norman_bioconvolving_hete_known-Scrolling-kSize-2');
[eer,~,~,FAR_bioconvolving_Scrolling,FRR_bioconvolving_Scrolling]=wer(bioconvolving_hete_known_Scrolling.scores{1,5},bioconvolving_hete_known_Scrolling.scores{2,5});
eer_scrolling(3,2)=eer;
FAR_test=kstest2(FAR_baseline_Scrolling,FAR_bioconvolving_Scrolling);
FRR_test=kstest2(FRR_baseline_Scrolling,FRR_bioconvolving_Scrolling);
statisticaltest.hete.bioconvolving.Scrolling.FRR=FRR_test;
statisticaltest.hete.bioconvolving.Scrolling.FAR=FAR_test;
if FRR_test==1
  disp('Scrolling');
  if eer_baseline_scrolling<eer
  disp('Baseline vs BioConvolving FRR - Smaller');
  else
    disp('Baseline vs BioConvolving FRR - Larger');
  end  
  disp('----------------------------------------------')
end


%%
%BioHashing Horizontal
biohash_hete_known_Horizontal=load('main_norman_biohash_hete_known-Horizontal-kSize-1');
[eer,~,~,FAR_biohash_Horizontal,FRR_biohash_Horizontal]=wer(biohash_hete_known_Horizontal.scores{1,5},biohash_hete_known_Horizontal.scores{2,5});
eer_horizontal(2,2)=eer;
FAR_test=kstest2(FAR_baseline_Horizontal,FAR_biohash_Horizontal);
FRR_test=kstest2(FRR_baseline_Horizontal,FRR_biohash_Horizontal);
statisticaltest.hete.biohash.Horizontal.FRR=FRR_test;
statisticaltest.hete.biohash.Horizontal.FAR=FAR_test;
if FRR_test==1
  disp('Horizontal');
  if eer_baseline_horizontal<eer
  disp('Baseline vs BioHashing FRR - Smaller');
  else
    disp('Baseline vs BioHashing FRR - Larger');
  end  
  disp('----------------------------------------------')
end

%%
%BioHashing Scrolling
biohash_hete_known_Scrolling=load('main_norman_biohash_hete_known-Scrolling-kSize-1');
[eer,~,~,FAR_biohash_Scrolling,FRR_biohash_Scrolling]=wer(biohash_hete_known_Scrolling.scores{1,5},biohash_hete_known_Scrolling.scores{2,5});
eer_scrolling(2,2)=eer;
FAR_test=kstest2(FAR_baseline_Scrolling,FAR_biohash_Scrolling);
FRR_test=kstest2(FRR_baseline_Scrolling,FRR_biohash_Scrolling);
statisticaltest.hete.bioHashing.Scrolling.FRR=FRR_test;
statisticaltest.hete.bioHashing.Scrolling.FAR=FAR_test;
if FRR_test==1
  disp('Scrolling');
  if eer_baseline_scrolling<eer
  disp('Baseline vs BioHashing FRR - Smaller');
  else
    disp('Baseline vs BioHashing FRR - Larger');
  end  
  disp('----------------------------------------------')
end

%%
%doublesum Horizontal
doublesum_hete_known_Horizontal=load('main_norman_doublesum_hete_known-Horizontal-kSize-25');
[eer,~,~,FAR_doublesum_Horizontal,FRR_doublesum_Horizontal]=wer(doublesum_hete_known_Horizontal.scores{1,5},doublesum_hete_known_Horizontal.scores{2,5});
eer_horizontal(4,2)=eer;
FAR_test=kstest2(FAR_baseline_Horizontal,FAR_doublesum_Horizontal);
FRR_test=kstest2(FRR_baseline_Horizontal,FRR_doublesum_Horizontal);
statisticaltest.hete.doublesum.Horizontal.FRR=FRR_test;
statisticaltest.hete.doublesum.Horizontal.FAR=FAR_test;
if FRR_test==1
  disp('Horizontal');
  if eer_baseline_horizontal<eer
  disp('Baseline vs DoubleSum FRR - Smaller');
  else
    disp('Baseline vs DoubleSum FRR - Larger');
  end  
  disp('----------------------------------------------')
end

%%
%doublesum Scrolling
doublesum_hete_known_Scrolling=load('main_norman_doublesum_hete_known-Scrolling-kSize-25');
[eer,~,~,FAR_doublesum_Scrolling,FRR_doublesum_Scrolling]=wer(doublesum_hete_known_Scrolling.scores{1,5},doublesum_hete_known_Scrolling.scores{2,5});
eer_scrolling(4,2)=eer;
FAR_test=kstest2(FAR_baseline_Scrolling,FAR_doublesum_Scrolling);
FRR_test=kstest2(FRR_baseline_Scrolling,FRR_doublesum_Scrolling);
statisticaltest.hete.doublesum.Scrolling.FRR=FRR_test;
statisticaltest.hete.doublesum.Scrolling.FAR=FAR_test;
if FRR_test==1
  disp('Scrolling');
  if eer_baseline_scrolling<eer
  disp('Baseline vs DoubleSum FRR - Smaller');
  else
    disp('Baseline vs DoubleSum FRR - Larger');
  end  
  disp('----------------------------------------------')
end

%%
%interpolation Horizontal
interpolation_hete_known_Horizontal=load('main_norman_interpolation_hete_known-Horizontal-kSize-25');
[eer,~,~,FAR_interpolation_Horizontal,FRR_interpolation_Horizontal]=wer(interpolation_hete_known_Horizontal.scores{1,5},interpolation_hete_known_Horizontal.scores{2,5});
eer_horizontal(1,2)=eer;
FAR_test=kstest2(FAR_baseline_Horizontal,FAR_interpolation_Horizontal);
FRR_test=kstest2(FRR_baseline_Horizontal,FRR_interpolation_Horizontal);
statisticaltest.hete.interpolation.Horizontal.FRR=FRR_test;
statisticaltest.hete.interpolation.Horizontal.FAR=FAR_test;
if FRR_test==1
  disp('Horizontal');
  if eer_baseline_horizontal<eer
  disp('Baseline vs Interpolation FRR - Smaller');
  else
    disp('Baseline vs Interpolation FRR - Larger');
  end  
  disp('----------------------------------------------')
end

%%
%interpolation Scrolling
interpolation_hete_known_Scrolling=load('main_norman_interpolation_hete_known-Scrolling-kSize-25');
[eer,~,~,FAR_interpolation_Scrolling,FRR_interpolation_Scrolling]=wer(interpolation_hete_known_Scrolling.scores{1,5},interpolation_hete_known_Scrolling.scores{2,5});
eer_scrolling(1,2)=eer;
FAR_test=kstest2(FAR_baseline_Scrolling,FAR_interpolation_Scrolling);
FRR_test=kstest2(FRR_baseline_Scrolling,FRR_interpolation_Scrolling);
statisticaltest.hete.interpolation.Scrolling.FRR=FRR_test;
statisticaltest.hete.interpolation.Scrolling.FAR=FAR_test;
if FRR_test==1
  disp('Scrolling');
  if eer_baseline_scrolling<eer
  disp('Baseline vs Interpolation FRR - Smaller');
  else
    disp('Baseline vs Interpolation FRR - Larger');
  end  
  disp('----------------------------------------------')
end


%%
save('StatisticalTest_Known_Hete.mat','statisticaltest');

%%
baselineHorizontal=load('main_norman-Horizontal.mat');
[eer_baseline_horizontal,~,~,FAR_baseline_Horizontal,FRR_baseline_Horizontal]=wer(baselineHorizontal.scores{1,5},baselineHorizontal.scores{2,5});
baselineScrolling=load('main_norman-Scrolling.mat');
[eer_baseline_scrolling,~,~,FAR_baseline_Scrolling,FRR_baseline_Scrolling]=wer(baselineScrolling.scores{1,5},baselineScrolling.scores{2,5});
%%
%Homo-Known
disp('----------------------------------');
disp('Homogeneous Known Statistical Test');
disp('----------------------------------');
%%
%BioConvolving Horizontal
bioconvolving_homo_known_Horizontal=load('main_norman_bioconvolving_homo_known-Horizontal-kSize-2');
[eer,~,~,FAR_bioconvolving_Horizontal,FRR_bioconvolving_Horizontal]=wer(bioconvolving_homo_known_Horizontal.scores{1,5},bioconvolving_homo_known_Horizontal.scores{2,5});
eer_horizontal(3,1)=eer;
FAR_test=kstest2(FAR_baseline_Horizontal,FAR_bioconvolving_Horizontal);
FRR_test=kstest2(FRR_baseline_Horizontal,FRR_bioconvolving_Horizontal);
statisticaltest.homo.bioconvolving.Horizontal.FRR=FRR_test;
statisticaltest.homo.bioconvolving.Horizontal.FAR=FAR_test;
if FRR_test==1
  disp('Horizontal');
  if eer_baseline_horizontal<eer
  disp('Baseline vs BioConvolving FRR - Smaller');
  else
    disp('Baseline vs BioConvolving FRR - Larger');
  end  
  disp('----------------------------------------------')
end
%%
%BioConvolving Scrolling
bioconvolving_homo_known_Scrolling=load('main_norman_bioconvolving_homo_known-Scrolling-kSize-2');
[eer,~,~,FAR_bioconvolving_Scrolling,FRR_bioconvolving_Scrolling]=wer(bioconvolving_homo_known_Scrolling.scores{1,5},bioconvolving_homo_known_Scrolling.scores{2,5});
eer_scrolling(3,1)=eer;
FAR_test=kstest2(FAR_baseline_Scrolling,FAR_bioconvolving_Scrolling);
FRR_test=kstest2(FRR_baseline_Scrolling,FRR_bioconvolving_Scrolling);
statisticaltest.homo.bioconvolving.Scrolling.FRR=FRR_test;
statisticaltest.homo.bioconvolving.Scrolling.FAR=FAR_test;
if FRR_test==1
  disp('Scrolling');
  if eer_baseline_scrolling<eer
  disp('Baseline vs BioConvolving FRR - Smaller');
  else
    disp('Baseline vs BioConvolving FRR - Larger');
  end  
  disp('----------------------------------------------')
end

%%
%BioHashing Horizontal
biohash_homo_known_Horizontal=load('main_norman_biohash_homo_known-Horizontal-kSize-1');
[eer,~,~,FAR_biohash_Horizontal,FRR_biohash_Horizontal]=wer(biohash_homo_known_Horizontal.scores{1,5},biohash_homo_known_Horizontal.scores{2,5});
eer_horizontal(2,1)=eer;
FAR_test=kstest2(FAR_baseline_Horizontal,FAR_biohash_Horizontal);
FRR_test=kstest2(FRR_baseline_Horizontal,FRR_biohash_Horizontal);
statisticaltest.homo.biohash.Horizontal.FRR=FRR_test;
statisticaltest.homo.biohash.Horizontal.FAR=FAR_test;
if FRR_test==1
  disp('Horizontal');
  if eer_baseline_horizontal<eer
  disp('Baseline vs BioHashing FRR - Smaller');
  else
    disp('Baseline vs BioHashing FRR - Larger');
  end  
  disp('----------------------------------------------')
end

%%
%BioHashing Scrolling
biohash_homo_known_Scrolling=load('main_norman_biohash_homo_known-Scrolling-kSize-1');
[eer,~,~,FAR_biohash_Scrolling,FRR_biohash_Scrolling]=wer(biohash_homo_known_Scrolling.scores{1,5},biohash_homo_known_Scrolling.scores{2,5});
eer_scrolling(2,1)=eer;
FAR_test=kstest2(FAR_baseline_Scrolling,FAR_biohash_Scrolling);
FRR_test=kstest2(FRR_baseline_Scrolling,FRR_biohash_Scrolling);
statisticaltest.homo.bioHashing.Scrolling.FRR=FRR_test;
statisticaltest.homo.bioHashing.Scrolling.FAR=FAR_test;
if FRR_test==1
  disp('Scrolling');
  if eer_baseline_scrolling<eer
  disp('Baseline vs BioHashing FRR - Smaller');
  else
    disp('Baseline vs BioHashing FRR - Larger');
  end  
  disp('----------------------------------------------')
end

%%
%doublesum Horizontal
doublesum_homo_known_Horizontal=load('main_norman_doublesum_homo_known-Horizontal-kSize-25');
[eer,~,~,FAR_doublesum_Horizontal,FRR_doublesum_Horizontal]=wer(doublesum_homo_known_Horizontal.scores{1,5},doublesum_homo_known_Horizontal.scores{2,5});
eer_horizontal(4,1)=eer;
FAR_test=kstest2(FAR_baseline_Horizontal,FAR_doublesum_Horizontal);
FRR_test=kstest2(FRR_baseline_Horizontal,FRR_doublesum_Horizontal);
statisticaltest.homo.doublesum.Horizontal.FRR=FRR_test;
statisticaltest.homo.doublesum.Horizontal.FAR=FAR_test;
if FRR_test==1
  disp('Horizontal');
  if eer_baseline_horizontal<eer
  disp('Baseline vs DoubleSum FRR - Smaller');
  else
    disp('Baseline vs DoubleSum FRR - Larger');
  end  
  disp('----------------------------------------------')
end

%%
%doublesum Scrolling
doublesum_homo_known_Scrolling=load('main_norman_doublesum_homo_known-Scrolling-kSize-25');
[eer,~,~,FAR_doublesum_Scrolling,FRR_doublesum_Scrolling]=wer(doublesum_homo_known_Scrolling.scores{1,5},doublesum_homo_known_Scrolling.scores{2,5});
eer_scrolling(4,1)=eer;
FAR_test=kstest2(FAR_baseline_Scrolling,FAR_doublesum_Scrolling);
FRR_test=kstest2(FRR_baseline_Scrolling,FRR_doublesum_Scrolling);
statisticaltest.homo.doublesum.Scrolling.FRR=FRR_test;
statisticaltest.homo.doublesum.Scrolling.FAR=FAR_test;
if FRR_test==1
  disp('Scrolling');
  if eer_baseline_scrolling<eer
  disp('Baseline vs DoubleSum FRR - Smaller');
  else
    disp('Baseline vs DoubleSum FRR - Larger');
  end  
  disp('----------------------------------------------')
end

%%
%interpolation Horizontal
interpolation_homo_known_Horizontal=load('main_norman_interpolation_homo_known-Horizontal-kSize-25');
[eer,~,~,FAR_interpolation_Horizontal,FRR_interpolation_Horizontal]=wer(interpolation_homo_known_Horizontal.scores{1,5},interpolation_homo_known_Horizontal.scores{2,5});
eer_horizontal(1,1)=eer;
FAR_test=kstest2(FAR_baseline_Horizontal,FAR_interpolation_Horizontal);
FRR_test=kstest2(FRR_baseline_Horizontal,FRR_interpolation_Horizontal);
statisticaltest.homo.interpolation.Horizontal.FRR=FRR_test;
statisticaltest.homo.interpolation.Horizontal.FAR=FAR_test;
if FRR_test==1
  disp('Horizontal');
  if eer_baseline_horizontal<eer
  disp('Baseline vs Interpolation FRR - Smaller');
  else
    disp('Baseline vs Interpolation FRR - Larger');
  end  
  disp('----------------------------------------------')
end

%%
%interpolation Scrolling
interpolation_homo_known_Scrolling=load('main_norman_interpolation_homo_known-Scrolling-kSize-25');
[eer,~,~,FAR_interpolation_Scrolling,FRR_interpolation_Scrolling]=wer(interpolation_homo_known_Scrolling.scores{1,5},interpolation_homo_known_Scrolling.scores{2,5});
eer_scrolling(1,1)=eer;
FAR_test=kstest2(FAR_baseline_Scrolling,FAR_interpolation_Scrolling);
FRR_test=kstest2(FRR_baseline_Scrolling,FRR_interpolation_Scrolling);
statisticaltest.homo.interpolation.Scrolling.FRR=FRR_test;
statisticaltest.homo.interpolation.Scrolling.FAR=FAR_test;
if FRR_test==1
  disp('Scrolling');
  if eer_baseline_scrolling<eer
  disp('Baseline vs Interpolation FRR - Smaller');
  else
    disp('Baseline vs Interpolation FRR - Larger');
  end  
  disp('----------------------------------------------')
end

%%
save('StatisticalTest_Known_homo.mat','statisticaltest');


%%
baselineHorizontal=load('main_norman-Horizontal.mat');
[eer_baseline_horizontal,~,~,FAR_baseline_Horizontal,FRR_baseline_Horizontal]=wer(baselineHorizontal.scores{1,5},baselineHorizontal.scores{2,5});
baselineScrolling=load('main_norman-Scrolling.mat');
[eer_baseline_scrolling,~,~,FAR_baseline_Scrolling,FRR_baseline_Scrolling]=wer(baselineScrolling.scores{1,5},baselineScrolling.scores{2,5});

%%
%Hete-Unknown
disp('----------------------------------');
disp('Heterogeneous Unknown Statistical Test');
disp('----------------------------------');
%%

%BioConvolving Horizontal
bioconvolving_hete_Unknown_Horizontal=load('main_norman_bioconvolving_hete_Unknown-Horizontal-kSize-2');
[eer,~,~,FAR_bioconvolving_Horizontal,FRR_bioconvolving_Horizontal]=wer(bioconvolving_hete_Unknown_Horizontal.scores{1,5},bioconvolving_hete_Unknown_Horizontal.scores{2,5});
eer_horizontal(3,4)=eer;
FAR_test=kstest2(FAR_baseline_Horizontal,FAR_bioconvolving_Horizontal);
FRR_test=kstest2(FRR_baseline_Horizontal,FRR_bioconvolving_Horizontal);
statisticaltest.hete.bioconvolving.Horizontal.FRR=FRR_test;
statisticaltest.hete.bioconvolving.Horizontal.FAR=FAR_test;
if FRR_test==1
  disp('Horizontal');
  if eer_baseline_horizontal<eer
  disp('Baseline vs BioConvolving FRR - Smaller');
  else
    disp('Baseline vs BioConvolving FRR - Larger');
  end  
  disp('----------------------------------------------')
end
%%
%BioConvolving Scrolling
bioconvolving_hete_Unknown_Scrolling=load('main_norman_bioconvolving_hete_Unknown-Scrolling-kSize-2');
[eer,~,~,FAR_bioconvolving_Scrolling,FRR_bioconvolving_Scrolling]=wer(bioconvolving_hete_Unknown_Scrolling.scores{1,5},bioconvolving_hete_Unknown_Scrolling.scores{2,5});
eer_scrolling(3,4)=eer;
FAR_test=kstest2(FAR_baseline_Scrolling,FAR_bioconvolving_Scrolling);
FRR_test=kstest2(FRR_baseline_Scrolling,FRR_bioconvolving_Scrolling);
statisticaltest.hete.bioconvolving.Scrolling.FRR=FRR_test;
statisticaltest.hete.bioconvolving.Scrolling.FAR=FAR_test;
if FRR_test==1
  disp('Scrolling');
  if eer_baseline_scrolling<eer
  disp('Baseline vs BioConvolving FRR - Smaller');
  else
    disp('Baseline vs BioConvolving FRR - Larger');
  end  
  disp('----------------------------------------------')
end


%%
%BioHashing Horizontal
biohash_hete_Unknown_Horizontal=load('main_norman_biohash_hete_Unknown-Horizontal-kSize-1');
[eer,~,~,FAR_biohash_Horizontal,FRR_biohash_Horizontal]=wer(biohash_hete_Unknown_Horizontal.scores{1,5},biohash_hete_Unknown_Horizontal.scores{2,5});
eer_horizontal(2,4)=eer;
FAR_test=kstest2(FAR_baseline_Horizontal,FAR_biohash_Horizontal);
FRR_test=kstest2(FRR_baseline_Horizontal,FRR_biohash_Horizontal);
statisticaltest.hete.biohash.Horizontal.FRR=FRR_test;
statisticaltest.hete.biohash.Horizontal.FAR=FAR_test;
if FRR_test==1
  disp('Horizontal');
  if eer_baseline_horizontal<eer
  disp('Baseline vs BioConvolving FRR - Smaller');
  else
    disp('Baseline vs BioConvolving FRR - Larger');
  end  
  disp('----------------------------------------------')
end

%%
%BioHashing Scrolling
biohash_hete_Unknown_Scrolling=load('main_norman_biohash_hete_Unknown-Scrolling-kSize-1');
[eer,~,~,FAR_biohash_Scrolling,FRR_biohash_Scrolling]=wer(biohash_hete_Unknown_Scrolling.scores{1,5},biohash_hete_Unknown_Scrolling.scores{2,5});
eer_scrolling(2,4)=eer;
FAR_test=kstest2(FAR_baseline_Scrolling,FAR_biohash_Scrolling);
FRR_test=kstest2(FRR_baseline_Scrolling,FRR_biohash_Scrolling);
statisticaltest.hete.bioHashing.Scrolling.FRR=FRR_test;
statisticaltest.hete.bioHashing.Scrolling.FAR=FAR_test;
if FRR_test==1
  disp('Scrolling');
  if eer_baseline_scrolling<eer
  disp('Baseline vs BioConvolving FRR - Smaller');
  else
    disp('Baseline vs BioConvolving FRR - Larger');
  end  
  disp('----------------------------------------------')
end

%%
%doublesum Horizontal
doublesum_hete_Unknown_Horizontal=load('main_norman_doublesum_hete_Unknown-Horizontal-kSize-25');
[eer,~,~,FAR_doublesum_Horizontal,FRR_doublesum_Horizontal]=wer(doublesum_hete_Unknown_Horizontal.scores{1,5},doublesum_hete_Unknown_Horizontal.scores{2,5});
eer_horizontal(4,4)=eer;
FAR_test=kstest2(FAR_baseline_Horizontal,FAR_doublesum_Horizontal);
FRR_test=kstest2(FRR_baseline_Horizontal,FRR_doublesum_Horizontal);
statisticaltest.hete.doublesum.Horizontal.FRR=FRR_test;
statisticaltest.hete.doublesum.Horizontal.FAR=FAR_test;
if FRR_test==1
  disp('Horizontal');
  if eer_baseline_horizontal<eer
  disp('Baseline vs DoubleSum FRR - Smaller');
  else
    disp('Baseline vs DoubleSum FRR - Larger');
  end  
  disp('----------------------------------------------')
end

%%
%doublesum Scrolling
doublesum_hete_Unknown_Scrolling=load('main_norman_doublesum_hete_Unknown-Scrolling-kSize-25');
[eer,~,~,FAR_doublesum_Scrolling,FRR_doublesum_Scrolling]=wer(doublesum_hete_Unknown_Scrolling.scores{1,5},doublesum_hete_Unknown_Scrolling.scores{2,5});
eer_scrolling(4,4)=eer;
FAR_test=kstest2(FAR_baseline_Scrolling,FAR_doublesum_Scrolling);
FRR_test=kstest2(FRR_baseline_Scrolling,FRR_doublesum_Scrolling);
statisticaltest.hete.doublesum.Scrolling.FRR=FRR_test;
statisticaltest.hete.doublesum.Scrolling.FAR=FAR_test;
if FRR_test==1
  disp('Scrolling');
  if eer_baseline_scrolling<eer
  disp('Baseline vs DoubleSum FRR - Smaller');
  else
    disp('Baseline vs DoubleSum FRR - Larger');
  end  
  disp('----------------------------------------------')
end

%%
%interpolation Horizontal
interpolation_hete_Unknown_Horizontal=load('main_norman_interpolation_hete_Unknown-Horizontal-kSize-25');
[eer,~,~,FAR_interpolation_Horizontal,FRR_interpolation_Horizontal]=wer(interpolation_hete_Unknown_Horizontal.scores{1,5},interpolation_hete_Unknown_Horizontal.scores{2,5});
eer_horizontal(1,4)=eer;
FAR_test=kstest2(FAR_baseline_Horizontal,FAR_interpolation_Horizontal);
FRR_test=kstest2(FRR_baseline_Horizontal,FRR_interpolation_Horizontal);
statisticaltest.hete.interpolation.Horizontal.FRR=FRR_test;
statisticaltest.hete.interpolation.Horizontal.FAR=FAR_test;
if FRR_test==1
  disp('Horizontal');
  if eer_baseline_horizontal<eer
  disp('Baseline vs Interpolation FRR - Smaller');
  else
    disp('Baseline vs Interpolation FRR - Larger');
  end  
  disp('----------------------------------------------')
end

%%
%interpolation Scrolling
interpolation_hete_Unknown_Scrolling=load('main_norman_interpolation_hete_Unknown-Scrolling-kSize-25');
[eer,~,~,FAR_interpolation_Scrolling,FRR_interpolation_Scrolling]=wer(interpolation_hete_Unknown_Scrolling.scores{1,5},interpolation_hete_Unknown_Scrolling.scores{2,5});
eer_scrolling(1,4)=eer;
FAR_test=kstest2(FAR_baseline_Scrolling,FAR_interpolation_Scrolling);
FRR_test=kstest2(FRR_baseline_Scrolling,FRR_interpolation_Scrolling);
statisticaltest.hete.interpolation.Scrolling.FRR=FRR_test;
statisticaltest.hete.interpolation.Scrolling.FAR=FAR_test;
if FRR_test==1
  disp('Scrolling');
  if eer_baseline_scrolling<eer
  disp('Baseline vs Interpolation FRR - Smaller');
  else
    disp('Baseline vs Interpolation FRR - Larger');
  end  
  disp('----------------------------------------------')
end


%%
save('StatisticalTest_Unknown_Hete.mat','statisticaltest');

%%
baselineHorizontal=load('main_norman-Horizontal.mat');
[eer_baseline_horizontal,~,~,FAR_baseline_Horizontal,FRR_baseline_Horizontal]=wer(baselineHorizontal.scores{1,5},baselineHorizontal.scores{2,5});
baselineScrolling=load('main_norman-Scrolling.mat');
[eer_baseline_scrolling,~,~,FAR_baseline_Scrolling,FRR_baseline_Scrolling]=wer(baselineScrolling.scores{1,5},baselineScrolling.scores{2,5});
%%
%Homo-Unknown
disp('----------------------------------');
disp('Homogeneous Unknown Statistical Test');
disp('----------------------------------');
%%
%BioConvolving Horizontal
bioconvolving_homo_Unknown_Horizontal=load('main_norman_bioconvolving_homo_Unknown-Horizontal-kSize-2');
[eer,~,~,FAR_bioconvolving_Horizontal,FRR_bioconvolving_Horizontal]=wer(bioconvolving_homo_Unknown_Horizontal.scores{1,5},bioconvolving_homo_Unknown_Horizontal.scores{2,5});
eer_horizontal(3,3)=eer;
FAR_test=kstest2(FAR_baseline_Horizontal,FAR_bioconvolving_Horizontal);
FRR_test=kstest2(FRR_baseline_Horizontal,FRR_bioconvolving_Horizontal);
statisticaltest.homo.bioconvolving.Horizontal.FRR=FRR_test;
statisticaltest.homo.bioconvolving.Horizontal.FAR=FAR_test;
if FRR_test==1
  disp('Horizontal');
  if eer_baseline_horizontal<eer
  disp('Baseline vs BioConvolving FRR - Smaller');
  else
    disp('Baseline vs BioConvolving FRR - Larger');
  end  
  disp('----------------------------------------------')
end
%%
%BioConvolving Scrolling
bioconvolving_homo_Unknown_Scrolling=load('main_norman_bioconvolving_homo_Unknown-Scrolling-kSize-2');
[eer,~,~,FAR_bioconvolving_Scrolling,FRR_bioconvolving_Scrolling]=wer(bioconvolving_homo_Unknown_Scrolling.scores{1,5},bioconvolving_homo_Unknown_Scrolling.scores{2,5});
eer_scrolling(3,3)=eer;
FAR_test=kstest2(FAR_baseline_Scrolling,FAR_bioconvolving_Scrolling);
FRR_test=kstest2(FRR_baseline_Scrolling,FRR_bioconvolving_Scrolling);
statisticaltest.homo.bioconvolving.Scrolling.FRR=FRR_test;
statisticaltest.homo.bioconvolving.Scrolling.FAR=FAR_test;
if FRR_test==1
  disp('Scrolling');
  if eer_baseline_scrolling<eer
  disp('Baseline vs BioConvolving FRR - Smaller');
  else
    disp('Baseline vs BioConvolving FRR - Larger');
  end  
  disp('----------------------------------------------')
end

%%
%BioHashing Horizontal
biohash_homo_Unknown_Horizontal=load('main_norman_biohash_homo_Unknown-Horizontal-kSize-1');
[eer,~,~,FAR_biohash_Horizontal,FRR_biohash_Horizontal]=wer(biohash_homo_Unknown_Horizontal.scores{1,5},biohash_homo_Unknown_Horizontal.scores{2,5});
eer_horizontal(2,3)=eer;
FAR_test=kstest2(FAR_baseline_Horizontal,FAR_biohash_Horizontal);
FRR_test=kstest2(FRR_baseline_Horizontal,FRR_biohash_Horizontal);
statisticaltest.homo.biohash.Horizontal.FRR=FRR_test;
statisticaltest.homo.biohash.Horizontal.FAR=FAR_test;
if FRR_test==1
  disp('Horizontal');
  if eer_baseline_horizontal<eer
  disp('Baseline vs BioHashing FRR - Smaller');
  else
    disp('Baseline vs BioHashing FRR - Larger');
  end  
  disp('----------------------------------------------')
end

%%
%BioHashing Scrolling
biohash_homo_Unknown_Scrolling=load('main_norman_biohash_homo_Unknown-Scrolling-kSize-1');
[eer,~,~,FAR_biohash_Scrolling,FRR_biohash_Scrolling]=wer(biohash_homo_Unknown_Scrolling.scores{1,5},biohash_homo_Unknown_Scrolling.scores{2,5});
eer_scrolling(2,3)=eer;
FAR_test=kstest2(FAR_baseline_Scrolling,FAR_biohash_Scrolling);
FRR_test=kstest2(FRR_baseline_Scrolling,FRR_biohash_Scrolling);
statisticaltest.homo.bioHashing.Scrolling.FRR=FRR_test;
statisticaltest.homo.bioHashing.Scrolling.FAR=FAR_test;
if FRR_test==1
  disp('Scrolling');
  if eer_baseline_scrolling<eer
  disp('Baseline vs BioHashing FRR - Smaller');
  else
    disp('Baseline vs BioHashing FRR - Larger');
  end  
  disp('----------------------------------------------')
end

%%
%doublesum Horizontal
doublesum_homo_Unknown_Horizontal=load('main_norman_doublesum_homo_Unknown-Horizontal-kSize-25');
[eer,~,~,FAR_doublesum_Horizontal,FRR_doublesum_Horizontal]=wer(doublesum_homo_Unknown_Horizontal.scores{1,5},doublesum_homo_Unknown_Horizontal.scores{2,5});
eer_horizontal(4,3)=eer;
FAR_test=kstest2(FAR_baseline_Horizontal,FAR_doublesum_Horizontal);
FRR_test=kstest2(FRR_baseline_Horizontal,FRR_doublesum_Horizontal);
statisticaltest.homo.doublesum.Horizontal.FRR=FRR_test;
statisticaltest.homo.doublesum.Horizontal.FAR=FAR_test;
if FRR_test==1
  disp('Horizontal');
  if eer_baseline_horizontal<eer
  disp('Baseline vs DoubleSum FRR - Smaller');
  else
    disp('Baseline vs DoubleSum FRR - Larger');
  end  
  disp('----------------------------------------------')
end

%%
%doublesum Scrolling
doublesum_homo_Unknown_Scrolling=load('main_norman_doublesum_homo_Unknown-Scrolling-kSize-25');
[eer,~,~,FAR_doublesum_Scrolling,FRR_doublesum_Scrolling]=wer(doublesum_homo_Unknown_Scrolling.scores{1,5},doublesum_homo_Unknown_Scrolling.scores{2,5});
eer_scrolling(4,3)=eer;
FAR_test=kstest2(FAR_baseline_Scrolling,FAR_doublesum_Scrolling);
FRR_test=kstest2(FRR_baseline_Scrolling,FRR_doublesum_Scrolling);
statisticaltest.homo.doublesum.Scrolling.FRR=FRR_test;
statisticaltest.homo.doublesum.Scrolling.FAR=FAR_test;
if FRR_test==1
  disp('Scrolling');
  if eer_baseline_scrolling<eer
  disp('Baseline vs DoubleSum FRR - Smaller');
  else
    disp('Baseline vs DoubleSum FRR - Larger');
  end  
  disp('----------------------------------------------')
end

%%
%interpolation Horizontal
interpolation_homo_Unknown_Horizontal=load('main_norman_interpolation_homo_Unknown-Horizontal-kSize-25');
[eer,~,~,FAR_interpolation_Horizontal,FRR_interpolation_Horizontal]=wer(interpolation_homo_Unknown_Horizontal.scores{1,5},interpolation_homo_Unknown_Horizontal.scores{2,5});
eer_horizontal(1,3)=eer;
FAR_test=kstest2(FAR_baseline_Horizontal,FAR_interpolation_Horizontal);
FRR_test=kstest2(FRR_baseline_Horizontal,FRR_interpolation_Horizontal);
statisticaltest.homo.interpolation.Horizontal.FRR=FRR_test;
statisticaltest.homo.interpolation.Horizontal.FAR=FAR_test;
if FRR_test==1
  disp('Horizontal');
  if eer_baseline_horizontal<eer
  disp('Baseline vs Interpolation FRR - Smaller');
  else
    disp('Baseline vs Interpolation FRR - Larger');
  end  
  disp('----------------------------------------------')
end

%%
%interpolation Scrolling
interpolation_homo_Unknown_Scrolling=load('main_norman_interpolation_homo_Unknown-Scrolling-kSize-25');
[eer,~,~,FAR_interpolation_Scrolling,FRR_interpolation_Scrolling]=wer(interpolation_homo_Unknown_Scrolling.scores{1,5},interpolation_homo_Unknown_Scrolling.scores{2,5});
eer_scrolling(1,3)=eer;
FAR_test=kstest2(FAR_baseline_Scrolling,FAR_interpolation_Scrolling);
FRR_test=kstest2(FRR_baseline_Scrolling,FRR_interpolation_Scrolling);
statisticaltest.homo.interpolation.Scrolling.FRR=FRR_test;
statisticaltest.homo.interpolation.Scrolling.FAR=FAR_test;
if FRR_test==1
  disp('Scrolling');
  if eer_baseline_scrolling<eer
  disp('Baseline vs Interpolation FRR - Smaller');
  else
    disp('Baseline vs Interpolation FRR - Larger');
  end  
  disp('----------------------------------------------')
end

%%
save('StatisticalTest_Unknown_homo.mat','statisticaltest');
save('eer_horizontal.mat','eer_horizontal');
save('eer_scrolling.mat','eer_scrolling');
clear();

%%