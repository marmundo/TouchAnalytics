addpath ../lib
m=5;
%%
%bioconvolving Unknown - homo
bioc_baseline=load('main_norman-Horizontal.mat');
[wer_min, thrd_min, x, FAR, FRR]=wer(bioc_baseline.scores{1,m}, bioc_baseline.scores{2,m}, [],0,[],1);

unprotected_FAR_001=FAR(find(FRR>=0.001,1));
unprotected_FAR_01=FAR(find(FRR>=0.01,1));
unprotected_FAR_1=FAR(find(FRR>=0.1,1));

bioc_baseline=load('main_norman_bioconvolving_homo_Unknown-Horizontal-kSize-2.mat');
[wer_min, thrd_min, x, FAR, FRR]=wer(bioc_baseline.scores{1,m}, bioc_baseline.scores{2,m}, [],0,[],1);

baseline_FAR_001=FAR(find(FRR>=0.001,1));
baseline_FAR_01=FAR(find(FRR>=0.01,1));
baseline_FAR_1=FAR(find(FRR>=0.1,1));

bioc_small=load('main_norman_bioconvolving_homo_Unknown-Horizontal-kSize-3.mat');
[wer_min, thrd_min, x, FAR, FRR]=wer(bioc_small.scores{1,m}, bioc_small.scores{2,m}, [],0,[],1);

small_FAR_001=FAR(find(FRR>=0.001,1));
small_FAR_01=FAR(find(FRR>=0.01,1));
small_FAR_1=FAR(find(FRR>=0.1,1));

bioc_medium=load('main_norman_bioconvolving_homo_Unknown-Horizontal-kSize-8.mat');
[wer_min, thrd_min, x, FAR, FRR]=wer(bioc_medium.scores{1,m}, bioc_medium.scores{2,m}, [],0,[],1);

medium_FAR_001=FAR(find(FRR>=0.001,1));
medium_FAR_01=FAR(find(FRR>=0.01,1));
medium_FAR_1=FAR(find(FRR>=0.1,1));

bioc_big=load('main_norman_bioconvolving_homo_Unknown-Horizontal-kSize-25.mat');
[wer_min, thrd_min, x, FAR, FRR]=wer(bioc_medium.scores{1,m}, bioc_medium.scores{2,m}, [],0,[],1);

big_FAR_001=FAR(find(FRR>=0.001,1));
big_FAR_01=FAR(find(FRR>=0.01,1));
big_FAR_1=FAR(find(FRR>=0.1,1));

%%
 unknown_homo_FAR=[unprotected_FAR_001,baseline_FAR_001,small_FAR_001,medium_FAR_001,big_FAR_001;unprotected_FAR_01,baseline_FAR_01,small_FAR_01,medium_FAR_01,big_FAR_01;unprotected_FAR_1,baseline_FAR_1,small_FAR_1,medium_FAR_1,big_FAR_1];
%%
% hbar=bar(unknown_homo_FAR);
% legend('unprotected','baseline','small','medium','big');
% set(gca,'XTickLabel',{'0.1%','1%','10%'});
% xlabel('FRR');
% ylabel('FAR');
% title('Bioconvolving - Unknown Key Attack - Homogeneous Key');
%%
% plot([0.1,1,10],unknown_homo_FAR,'MarkerSize',100,'MarkerEdgeColor','b');
% legend('unprotected','baseline','small','medium','big');
% %set(gca,'XTickLabel',{'0.1%','1%','10%'});
% xlabel('FRR');
% ylabel('FAR');
% title('Bioconvolving - Unknown Key Attack - Homogeneous Key');
%%
%bioconvolving Unknown - hete
bioc_baseline=load('main_norman-Horizontal.mat');
[wer_min, thrd_min, x, FAR, FRR]=wer(bioc_baseline.scores{1,m}, bioc_baseline.scores{2,m}, [],0,[],1);

unprotected_FAR_001=FAR(find(FRR>=0.001,1));
unprotected_FAR_01=FAR(find(FRR>=0.01,1));
unprotected_FAR_1=FAR(find(FRR>=0.1,1));

bioc_baseline=load('main_norman_bioconvolving_hete_Unknown-Horizontal-kSize-2.mat');
[wer_min, thrd_min, x, FAR, FRR]=wer(bioc_baseline.scores{1,m}, bioc_baseline.scores{2,m}, [],0,[],1);

baseline_FAR_001=FAR(find(FRR>=0.001,1));
baseline_FAR_01=FAR(find(FRR>=0.01,1));
baseline_FAR_1=FAR(find(FRR>=0.1,1));

bioc_small=load('main_norman_bioconvolving_hete_Unknown-Horizontal-kSize-3.mat');
[wer_min, thrd_min, x, FAR, FRR]=wer(bioc_small.scores{1,m}, bioc_small.scores{2,m}, [],0,[],1);

small_FAR_001=FAR(find(FRR>=0.001,1));
small_FAR_01=FAR(find(FRR>=0.01,1));
small_FAR_1=FAR(find(FRR>=0.1,1));

bioc_medium=load('main_norman_bioconvolving_hete_Unknown-Horizontal-kSize-8.mat');
[wer_min, thrd_min, x, FAR, FRR]=wer(bioc_medium.scores{1,m}, bioc_medium.scores{2,m}, [],0,[],1);

medium_FAR_001=FAR(find(FRR>=0.001,1));
medium_FAR_01=FAR(find(FRR>=0.01,1));
medium_FAR_1=FAR(find(FRR>=0.1,1));

bioc_big=load('main_norman_bioconvolving_hete_Unknown-Horizontal-kSize-25.mat');
[wer_min, thrd_min, x, FAR, FRR]=wer(bioc_medium.scores{1,m}, bioc_medium.scores{2,m}, [],0,[],1);

big_FAR_001=FAR(find(FRR>=0.001,1));
big_FAR_01=FAR(find(FRR>=0.01,1));
big_FAR_1=FAR(find(FRR>=0.1,1));


%%
% Draw the bar plot for homogeneous 
unknown_hete_FAR=[unprotected_FAR_001,baseline_FAR_001,small_FAR_001,medium_FAR_001,big_FAR_001;unprotected_FAR_01,baseline_FAR_01,small_FAR_01,medium_FAR_01,big_FAR_01;unprotected_FAR_1,baseline_FAR_1,small_FAR_1,medium_FAR_1,big_FAR_1];
bar([unknown_homo_FAR;unknown_hete_FAR])
legend('unprotected','baseline','small','medium','big');
set(gca,'XTickLabel',{'0.1%','1%','10%'});
xlabel('FRR');
ylabel('FAR');
title('Bioconvolving - Unknown Key Attack');
%%
% Plot the bioconvolving at fixed FRR using lines

plot([unknown_homo_FAR',unknown_hete_FAR'],'-o')
set(gca,'XTick',1:5,'XTickLabel',{'UnProt.','Std. Length','Small','Medium','Big'});
legend('0.1% - Homo. Key','1% - Homo. Key','10% - Homo. Key','0.1% - Hete Key','1% - Hete Key','10% - Hete Key');
ylabel('FAR');
xlabel('Key Length');
title('Bioconvolving - Unknown Key Attack - Fixed FRR at 0.1%, 1% and 10%');