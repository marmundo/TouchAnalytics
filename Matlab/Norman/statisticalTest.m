%%
%Test the statistical difference between baseline and the cancelable method scores
%%

baselineHorizontal=load('main_norman-Horizontal.mat')
baselineScrolling=load('main_norman-Scrolling.mat')

%%
gen_test=kstest2(baselineHorizontal.scores{1,5},baselineHorizontal.scores{1,5});

%%
%BioConvolving Horizontal
bioconvolving_hete_known_Horizontal=load('main_norman_bioconvolving_hete_known-Horizontal-kSize-2');
imp_test=kstest2(baselineHorizontal.scores{1,5},bioconvolving_hete_known_Horizontal.scores{1,5});
gen_test=kstest2(baselineHorizontal.scores{2,5},bioconvolving_hete_known_Horizontal.scores{2,5});
statisticaltest.bioconvolving.Horizontal.genuine=gen_test;
statisticaltest.bioconvolving.Horizontal.impostor=imp_test;
%%
%BioConvolving Scrolling
bioconvolving_hete_known_Scrolling=load('main_norman_bioconvolving_hete_known-Scrolling-kSize-2');
imp_test=kstest2(baselineScrolling.scores{1,5},bioconvolving_hete_known_Scrolling.scores{1,5});
gen_test=kstest2(baselineScrolling.scores{2,5},bioconvolving_hete_known_Scrolling.scores{2,5});
statisticaltest.bioconvolving.Scrolling.genuine=gen_test;
statisticaltest.bioconvolving.Scrolling.impostor=imp_test;

%%
%BioHashing Horizontal
bioHashing_hete_known_Horizontal=load('main_norman_biohash_hete_known-Horizontal-kSize-1');
imp_test=kstest2(baselineHorizontal.scores{1,5},bioHashing_hete_known_Horizontal.scores{1,5});
gen_test=kstest2(baselineHorizontal.scores{2,5},bioHashing_hete_known_Horizontal.scores{2,5});
statisticaltest.bioHashing.Horizontal.genuine=gen_test;
statisticaltest.bioHashing.Horizontal.impostor=imp_test;
%%
%BioHashing Scrolling
bioHashing_hete_known_Scrolling=load('main_norman_biohash_hete_known-Scrolling-kSize-1');
imp_test=kstest2(baselineScrolling.scores{1,5},bioHashing_hete_known_Scrolling.scores{1,5});
gen_test=kstest2(baselineScrolling.scores{2,5},bioHashing_hete_known_Scrolling.scores{2,5});
statisticaltest.bioHashing.Scrolling.genuine=gen_test;
statisticaltest.bioHashing.Scrolling.impostor=imp_test;

%%
%doublesum Horizontal
doublesum_hete_known_Horizontal=load('main_norman_doublesum_hete_known-Horizontal-kSize-25');
imp_test=kstest2(baselineHorizontal.scores{1,5},doublesum_hete_known_Horizontal.scores{1,5});
gen_test=kstest2(baselineHorizontal.scores{2,5},doublesum_hete_known_Horizontal.scores{2,5});
statisticaltest.doublesum.Horizontal.genuine=gen_test;
statisticaltest.doublesum.Horizontal.impostor=imp_test;
%%
%doublesum Scrolling
doublesum_hete_known_Scrolling=load('main_norman_doublesum_hete_known-Scrolling-kSize-25');
imp_test=kstest2(baselineScrolling.scores{1,5},doublesum_hete_known_Scrolling.scores{1,5});
gen_test=kstest2(baselineScrolling.scores{2,5},doublesum_hete_known_Scrolling.scores{2,5});
statisticaltest.doublesum.Scrolling.genuine=gen_test;
statisticaltest.doublesum.Scrolling.impostor=imp_test;

%%
%interpolation Horizontal
interpolation_hete_known_Horizontal=load('main_norman_interpolation_hete_known-Horizontal-kSize-25');
imp_test=kstest2(baselineHorizontal.scores{1,5},interpolation_hete_known_Horizontal.scores{1,5});
gen_test=kstest2(baselineHorizontal.scores{2,5},interpolation_hete_known_Horizontal.scores{2,5});
statisticaltest.interpolation.Horizontal.genuine=gen_test;
statisticaltest.interpolation.Horizontal.impostor=imp_test;
%%
%interpolation Scrolling
interpolation_hete_known_Scrolling=load('main_norman_interpolation_hete_known-Scrolling-kSize-25');
imp_test=kstest2(baselineScrolling.scores{1,5},interpolation_hete_known_Scrolling.scores{1,5});
gen_test=kstest2(baselineScrolling.scores{2,5},interpolation_hete_known_Scrolling.scores{2,5});
statisticaltest.interpolation.Scrolling.genuine=gen_test;
statisticaltest.interpolation.Scrolling.impostor=imp_test;
%%
genuine=statisticaltest.interpolation.Horizontal.genuine;
impostor=statisticaltest.interpolation.Horizontal.impostor;
if genuine==0 || impostor==0
  print('Similar')
end
%%
genuine=statisticaltest.interpolation.Scrolling.genuine;
impostor=statisticaltest.interpolation.Scrolling.impostor;
if genuine==0 || impostor==0
  print('Similar')
end
%%
genuine=statisticaltest.bioHashing.Horizontal.genuine;
impostor=statisticaltest.bioHashing.Horizontal.impostor;
if genuine==0 || impostor==0
  print('Similar')
end
%%
genuine=statisticaltest.bioHashing.Scrolling.genuine;
impostor=statisticaltest.bioHashing.Scrolling.impostor;
if genuine==0 || impostor==0
  print('Similar')
end
%%
genuine=statisticaltest.bioconvolving.Horizontal.genuine;
impostor=statisticaltest.bioconvolving.Horizontal.impostor;
if genuine==0 || impostor==0
  print('Similar')
end
%%
genuine=statisticaltest.bioconvolving.Scrolling.genuine;
impostor=statisticaltest.bioconvolving.Scrolling.impostor;
if genuine==0 || impostor==0
  print('Similar')
end
%%
genuine=statisticaltest.doublesum.Horizontal.genuine;
impostor=statisticaltest.doublesum.Horizontal.impostor;
if genuine==0 || impostor==0
  disp('Similar')
end
%%
genuine=statisticaltest.doublesum.Scrolling.genuine;
impostor=statisticaltest.doublesum.Scrolling.impostor;
if genuine==0 || impostor==0
  disp('Similar')
end