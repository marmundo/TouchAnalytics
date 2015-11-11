clear all
addpath ../lib
m=5

%%
%biohashing Unknown - homo
bioh_baseline=load('main_norman-Horizontal.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(bioh_baseline.scores{1,m}, bioh_baseline.scores{2,m}, [],2,[],1);
data_unprotected=[FAR,FRR,x];

bioh_baseline=load('main_norman_biohash_homo_Unknown-Horizontal-kSize-1.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(bioh_baseline.scores{1,m}, bioh_baseline.scores{2,m}, [],2,[],1);
data_baseline=[FAR,FRR,x]
bioh_small=load('main_norman_biohash_homo_Unknown-Horizontal-kSize-2.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(bioh_small.scores{1,m}, bioh_small.scores{2,m}, [],2,[],1);
data_small=[FAR,FRR,x]
bioh_medium=load('main_norman_biohash_homo_Unknown-Horizontal-kSize-4.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(bioh_medium.scores{1,m}, bioh_medium.scores{2,m}, [],2,[],1);
data_medium=[FAR,FRR,x]
bioh_big=load('main_norman_biohash_homo_Unknown-Horizontal-kSize-40.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(bioh_medium.scores{1,m}, bioh_medium.scores{2,m}, [],2,[],1);
data_big=[FAR,FRR,x]

data=data_unprotected;
data(1:numel(data_baseline(:,1)),2) = data_baseline(:,1);
data(1:numel(data_small(:,1)),3) = data_small(:,1);
data(1:numel(data_medium(:,1)),4) = data_medium(:,1);
data(1:numel(data_big(:,1)),5) = data_big(:,1);

%%
%biohashing Unknown - hete
bioh_baseline=load('main_norman_biohash_hete_Unknown-Horizontal-kSize-1.mat');
[wer_min, thrd_min, x, FAR, FRR]=wer(bioh_baseline.scores{1,m}, bioh_baseline.scores{2,m}, [],2,[],1);
data_baseline=[FAR,FRR,x];
bioh_small=load('main_norman_biohash_hete_Unknown-Horizontal-kSize-2.mat');
[wer_min, thrd_min, x, FAR, FRR]=wer(bioh_small.scores{1,m}, bioh_small.scores{2,m}, [],2,[],1);
data_small=[FAR,FRR,x];
bioh_medium=load('main_norman_biohash_hete_Unknown-Horizontal-kSize-4.mat');
[wer_min, thrd_min, x, FAR, FRR]=wer(bioh_medium.scores{1,m}, bioh_medium.scores{2,m}, [],2,[],1);
data_medium=[FAR,FRR,x];
bioh_big=load('main_norman_biohash_hete_Unknown-Horizontal-kSize-40.mat');
[wer_min, thrd_min, x, FAR, FRR]=wer(bioh_medium.scores{1,m}, bioh_medium.scores{2,m}, [],2,[],1);
data_big=[FAR,FRR,x];

data(1:numel(data_baseline(:,1)),6) = data_baseline(:,1);
data(1:numel(data_small(:,1)),7) = data_small(:,1);
data(1:numel(data_medium(:,1)),8) = data_medium(:,1);
data(1:numel(data_big(:,1)),9) = data_big(:,1);



%%
%biohashing Known - homo
bioh_baseline=load('main_norman_biohash_homo_known-Horizontal-kSize-1.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(bioh_baseline.scores{1,m}, bioh_baseline.scores{2,m}, [],2,[],1);
data_baseline=[FAR,FRR,x]
bioh_small=load('main_norman_biohash_homo_known-Horizontal-kSize-2.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(bioh_small.scores{1,m}, bioh_small.scores{2,m}, [],2,[],1);
data_small=[FAR,FRR,x]
bioh_medium=load('main_norman_biohash_homo_known-Horizontal-kSize-4.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(bioh_medium.scores{1,m}, bioh_medium.scores{2,m}, [],2,[],1);
data_medium=[FAR,FRR,x]
bioh_big=load('main_norman_biohash_homo_known-Horizontal-kSize-1.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(bioh_medium.scores{1,m}, bioh_medium.scores{2,m}, [],2,[],1);
data_big=[FAR,FRR,x]

data(1:numel(data_baseline(:,1)),10) = data_baseline(:,1);
data(1:numel(data_small(:,1)),11) = data_small(:,1);
data(1:numel(data_medium(:,1)),12) = data_medium(:,1);
data(1:numel(data_big(:,1)),13) = data_big(:,1);

%%
%biohashing known - hete
bioh_baseline=load('main_norman_biohash_hete_known-Horizontal-kSize-1.mat');
[wer_min, thrd_min, x, FAR, FRR]=wer(bioh_baseline.scores{1,m}, bioh_baseline.scores{2,m}, [],2,[],1);
data_baseline=[FAR,FRR,x];
bioh_small=load('main_norman_biohash_hete_known-Horizontal-kSize-2.mat');
[wer_min, thrd_min, x, FAR, FRR]=wer(bioh_small.scores{1,m}, bioh_small.scores{2,m}, [],2,[],1);
data_small=[FAR,FRR,x];
bioh_medium=load('main_norman_biohash_hete_known-Horizontal-kSize-4.mat');
[wer_min, thrd_min, x, FAR, FRR]=wer(bioh_medium.scores{1,m}, bioh_medium.scores{2,m}, [],2,[],1);
data_medium=[FAR,FRR,x];
bioh_big=load('main_norman_biohash_hete_known-Horizontal-kSize-1.mat');
[wer_min, thrd_min, x, FAR, FRR]=wer(bioh_medium.scores{1,m}, bioh_medium.scores{2,m}, [],2,[],1);
data_big=[FAR,FRR,x];

data(1:numel(data_baseline(:,1)),14) = data_baseline(:,1);
data(1:numel(data_small(:,1)),15) = data_small(:,1);
data(1:numel(data_medium(:,1)),16) = data_medium(:,1);
data(1:numel(data_big(:,1)),17) = data_big(:,1);
data(data==0)=NaN;


%%

boxplot(data,'labels',{'unprotected','std. length','small','medium','big','std. length','small','medium','big','std. length','small','medium','big','std. length','small','medium','big'},'plotstyle','compact','orientation','horizontal')
title('BioHashing - Horizontal Strokes')
xlabel('FAR')
ylabel('Key Size')

%%
%Scrolling Strokes

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
%Horizontal Settings

x=[0.53 0.53];
y=[0.92 0.75];
annotation('doublearrow',x,y)
dim=[.54 .55 .3 .3];
annotation('textbox',dim,'String','Heterogeneous Key','FitBoxToText','on')

x=[0.53 0.53];
y=[0.73 0.55];
annotation('doublearrow',x,y)
dim=[.54 .37 .3 .3];
annotation('textbox',dim,'String','Homogeneous Key','FitBoxToText','on')


x=[0.53 0.53];
y=[0.54 0.36];
annotation('doublearrow',x,y)
dim=[.54 .18 .3 .3];
annotation('textbox',dim,'String','Heterogeneous Key','FitBoxToText','on')

x=[0.53 0.53];
y=[0.35 0.16];
annotation('doublearrow',x,y)
dim=[.54 .1 .3 .19];
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
%%