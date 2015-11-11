clear all
addpath ../lib
m=5

%%
%bioconvolving Unknown - homo
bioc_baseline=load('main_norman-Horizontal.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(bioc_baseline.scores{1,m}, bioc_baseline.scores{2,m}, [],2,[],1);
data_unprotected=[FAR,FRR,x];

bioc_baseline=load('main_norman_bioconvolving_homo_Unknown-Horizontal-kSize-2.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(bioc_baseline.scores{1,m}, bioc_baseline.scores{2,m}, [],2,[],1);
data_baseline=[FAR,FRR,x]
bioc_small=load('main_norman_bioconvolving_homo_Unknown-Horizontal-kSize-3.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(bioc_small.scores{1,m}, bioc_small.scores{2,m}, [],2,[],1);
data_small=[FAR,FRR,x]
bioc_medium=load('main_norman_bioconvolving_homo_Unknown-Horizontal-kSize-8.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(bioc_medium.scores{1,m}, bioc_medium.scores{2,m}, [],2,[],1);
data_medium=[FAR,FRR,x]
bioc_big=load('main_norman_bioconvolving_homo_Unknown-Horizontal-kSize-25.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(bioc_medium.scores{1,m}, bioc_medium.scores{2,m}, [],2,[],1);
data_big=[FAR,FRR,x]

data=data_unprotected;
data(1:numel(data_baseline(:,1)),2) = data_baseline(:,1);
data(1:numel(data_small(:,1)),3) = data_small(:,1);
data(1:numel(data_medium(:,1)),4) = data_medium(:,1);
data(1:numel(data_big(:,1)),5) = data_big(:,1);

%%
%bioconvolving Unknown - hete
bioc_baseline=load('main_norman_bioconvolving_hete_Unknown-Horizontal-kSize-2.mat');
[wer_min, thrd_min, x, FAR, FRR]=wer(bioc_baseline.scores{1,m}, bioc_baseline.scores{2,m}, [],2,[],1);
data_baseline=[FAR,FRR,x];
bioc_small=load('main_norman_bioconvolving_hete_Unknown-Horizontal-kSize-3.mat');
[wer_min, thrd_min, x, FAR, FRR]=wer(bioc_small.scores{1,m}, bioc_small.scores{2,m}, [],2,[],1);
data_small=[FAR,FRR,x];
bioc_medium=load('main_norman_bioconvolving_hete_Unknown-Horizontal-kSize-8.mat');
[wer_min, thrd_min, x, FAR, FRR]=wer(bioc_medium.scores{1,m}, bioc_medium.scores{2,m}, [],2,[],1);
data_medium=[FAR,FRR,x];
bioc_big=load('main_norman_bioconvolving_hete_Unknown-Horizontal-kSize-25.mat');
[wer_min, thrd_min, x, FAR, FRR]=wer(bioc_medium.scores{1,m}, bioc_medium.scores{2,m}, [],2,[],1);
data_big=[FAR,FRR,x];

data(1:numel(data_baseline(:,1)),6) = data_baseline(:,1);
data(1:numel(data_small(:,1)),7) = data_small(:,1);
data(1:numel(data_medium(:,1)),8) = data_medium(:,1);
data(1:numel(data_big(:,1)),9) = data_big(:,1);



%%
%bioconvolving Known - homo
bioc_baseline=load('main_norman_bioconvolving_homo_known-Horizontal-kSize-2.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(bioc_baseline.scores{1,m}, bioc_baseline.scores{2,m}, [],2,[],1);
data_baseline=[FAR,FRR,x]
bioc_small=load('main_norman_bioconvolving_homo_known-Horizontal-kSize-3.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(bioc_small.scores{1,m}, bioc_small.scores{2,m}, [],2,[],1);
data_small=[FAR,FRR,x]
bioc_medium=load('main_norman_bioconvolving_homo_known-Horizontal-kSize-8.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(bioc_medium.scores{1,m}, bioc_medium.scores{2,m}, [],2,[],1);
data_medium=[FAR,FRR,x]
bioc_big=load('main_norman_bioconvolving_homo_known-Horizontal-kSize-2.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(bioc_medium.scores{1,m}, bioc_medium.scores{2,m}, [],2,[],1);
data_big=[FAR,FRR,x]

data(1:numel(data_baseline(:,1)),10) = data_baseline(:,1);
data(1:numel(data_small(:,1)),11) = data_small(:,1);
data(1:numel(data_medium(:,1)),12) = data_medium(:,1);
data(1:numel(data_big(:,1)),13) = data_big(:,1);

%%
%bioconvolving known - hete
bioc_baseline=load('main_norman_bioconvolving_hete_known-Horizontal-kSize-2.mat');
[wer_min, thrd_min, x, FAR, FRR]=wer(bioc_baseline.scores{1,m}, bioc_baseline.scores{2,m}, [],2,[],1);
data_baseline=[FAR,FRR,x];
bioc_small=load('main_norman_bioconvolving_hete_known-Horizontal-kSize-3.mat');
[wer_min, thrd_min, x, FAR, FRR]=wer(bioc_small.scores{1,m}, bioc_small.scores{2,m}, [],2,[],1);
data_small=[FAR,FRR,x];
bioc_medium=load('main_norman_bioconvolving_hete_known-Horizontal-kSize-8.mat');
[wer_min, thrd_min, x, FAR, FRR]=wer(bioc_medium.scores{1,m}, bioc_medium.scores{2,m}, [],2,[],1);
data_medium=[FAR,FRR,x];
bioc_big=load('main_norman_bioconvolving_hete_known-Horizontal-kSize-2.mat');
[wer_min, thrd_min, x, FAR, FRR]=wer(bioc_medium.scores{1,m}, bioc_medium.scores{2,m}, [],2,[],1);
data_big=[FAR,FRR,x];

data(1:numel(data_baseline(:,1)),14) = data_baseline(:,1);
data(1:numel(data_small(:,1)),15) = data_small(:,1);
data(1:numel(data_medium(:,1)),16) = data_medium(:,1);
data(1:numel(data_big(:,1)),17) = data_big(:,1);
data(data==0)=NaN;


%%

boxplot(data,'labels',{'unprotected','std. length','small','medium','big','std. length','small','medium','big','std. length','small','medium','big','std. length','small','medium','big'},'plotstyle','compact','orientation','horizontal')
title('BioConvolving - Horizontal Strokes')
xlabel('FAR')
ylabel('Key Size')

%%
%Scrolling Settings
% 
% x=[0.52 0.52];
% y=[0.92 0.75];
% annotation('doublearrow',x,y)
% dim=[.53 .55 .3 .3];
% annotation('textbox',dim,'String','Heterogeneous Key','FitBoxToText','on')
% 
% x=[0.52 0.52];
% y=[0.73 0.55];
% annotation('doublearrow',x,y)
% dim=[.53 .37 .3 .3];
% annotation('textbox',dim,'String','Homogeneous Key','FitBoxToText','on')
% 
% 
% x=[0.52 0.52];
% y=[0.54 0.36];
% annotation('doublearrow',x,y)
% dim=[.53 .18 .3 .3];
% annotation('textbox',dim,'String','Heterogeneous Key','FitBoxToText','on')
% 
% x=[0.52 0.52];
% y=[0.35 0.16];
% annotation('doublearrow',x,y)
% dim=[.53 .1 .3 .19];
% annotation('textbox',dim,'String','Homogeneous Key','FitBoxToText','on')
% 
% x=[0.65 0.65];
% y=[0.92 0.55];
% annotation('doublearrow',x,y)
% dim=[.66 .45 .32 .3];
% annotation('textbox',dim,'String','Known Key','FitBoxToText','on')
% 
% x=[0.65 0.65];
% y=[0.53 0.16];
% annotation('doublearrow',x,y)
% dim=[.66 .05 .31 .3];
% annotation('textbox',dim,'String','UnKnown Key','FitBoxToText','on')
%%

%%
%Horizontal Settings

x=[0.54 0.54];
y=[0.92 0.75];
annotation('doublearrow',x,y)
dim=[.55 .55 .3 .3];
annotation('textbox',dim,'String','Heterogeneous Key','FitBoxToText','on')

x=[0.54 0.54];
y=[0.73 0.55];
annotation('doublearrow',x,y)
dim=[.55 .37 .3 .3];
annotation('textbox',dim,'String','Homogeneous Key','FitBoxToText','on')


x=[0.54 0.54];
y=[0.54 0.36];
annotation('doublearrow',x,y)
dim=[.55 .18 .3 .3];
annotation('textbox',dim,'String','Heterogeneous Key','FitBoxToText','on')

x=[0.54 0.54];
y=[0.35 0.16];
annotation('doublearrow',x,y)
dim=[.55 .1 .3 .19];
annotation('textbox',dim,'String','Homogeneous Key','FitBoxToText','on')

x=[0.65 0.65];
y=[0.92 0.55];
annotation('doublearrow',x,y)
dim=[.66 .45 .32 .3];
annotation('textbox',dim,'String','Known Key','FitBoxToText','on')

x=[0.65 0.65];
y=[0.53 0.16];
annotation('doublearrow',x,y)
dim=[.66 .05 .31 .3];
annotation('textbox',dim,'String','UnKnown Key','FitBoxToText','on')
