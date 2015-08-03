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
statisticaltest.interpolation.Horizontal.genuine
statisticaltest.interpolation.Horizontal.impostor
%%
statisticaltest.interpolation.Scrolling.genuine
statisticaltest.interpolation.Scrolling.impostor
%%
statisticaltest.bioHashing.Horizontal.genuine
statisticaltest.bioHashing.Horizontal.impostor
%%
statisticaltest.bioHashing.Scrolling.genuine
statisticaltest.bioHashing.Scrolling.impostor
%%
statisticaltest.bioconvolving.Horizontal.genuine
statisticaltest.bioconvolving.Horizontal.impostor
%%
statisticaltest.bioconvolving.Scrolling.genuine
statisticaltest.bioconvolving.Scrolling.impostor
%%
statisticaltest.doublesum.Horizontal.genuine
statisticaltest.doublesum.Horizontal.impostor
%%
statisticaltest.doublesum.Scrolling.genuine
statisticaltest.doublesum.Scrolling.impostor
