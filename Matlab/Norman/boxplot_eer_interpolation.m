clear all
addpath ../lib
m=5

%%
%Interpolation Unknown - homo
unprotected=load('main_norman-Horizontal.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(unprotected.scores{1,m}, unprotected.scores{2,m}, [],2,[],1);
data_unprotected=[FAR,FRR,x];

inter_baseline=load('main_norman_interpolation_homo_Unknown-Horizontal-kSize-25.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(inter_baseline.scores{1,m}, inter_baseline.scores{2,m}, [],2,[],1);
data_baseline=[FAR,FRR,x]
inter_small=load('main_norman_interpolation_homo_Unknown-Horizontal-kSize-50.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(inter_small.scores{1,m}, inter_small.scores{2,m}, [],2,[],1);
data_small=[FAR,FRR,x]
inter_medium=load('main_norman_interpolation_homo_Unknown-Horizontal-kSize-100.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(inter_medium.scores{1,m}, inter_medium.scores{2,m}, [],2,[],1);
data_medium=[FAR,FRR,x]
inter_big=load('main_norman_interpolation_homo_Unknown-Horizontal-kSize-400.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(inter_big.scores{1,m}, inter_big.scores{2,m}, [],2,[],1);
data_big=[FAR,FRR,x]

data=data_unprotected;
data(1:numel(data_baseline(:,1)),2) = data_baseline(:,1);
data(1:numel(data_small(:,1)),3) = data_small(:,1);
data(1:numel(data_medium(:,1)),4) = data_medium(:,1);
data(1:numel(data_big(:,1)),5) = data_big(:,1);

%%
%Interpolation Unknown - hete
inter_baseline=load('main_norman_interpolation_hete_Unknown-Horizontal-kSize-25.mat');
[wer_min, thrd_min, x, FAR, FRR]=wer(inter_baseline.scores{1,m}, inter_baseline.scores{2,m}, [],2,[],1);
data_baseline=[FAR,FRR,x];
inter_small=load('main_norman_interpolation_hete_Unknown-Horizontal-kSize-50.mat');
[wer_min, thrd_min, x, FAR, FRR]=wer(inter_small.scores{1,m}, inter_small.scores{2,m}, [],2,[],1);
data_small=[FAR,FRR,x];
inter_medium=load('main_norman_interpolation_hete_Unknown-Horizontal-kSize-100.mat');
[wer_min, thrd_min, x, FAR, FRR]=wer(inter_medium.scores{1,m}, inter_medium.scores{2,m}, [],2,[],1);
data_medium=[FAR,FRR,x];
inter_big=load('main_norman_interpolation_hete_Unknown-Horizontal-kSize-400.mat');
[wer_min, thrd_min, x, FAR, FRR]=wer(inter_big.scores{1,m}, inter_big.scores{2,m}, [],2,[],1);
data_big=[FAR,FRR,x];

data(1:numel(data_baseline(:,1)),6) = data_baseline(:,1);
data(1:numel(data_small(:,1)),7) = data_small(:,1);
data(1:numel(data_medium(:,1)),8) = data_medium(:,1);
data(1:numel(data_big(:,1)),9) = data_big(:,1);



%%
%Interpolation Known - homo
inter_baseline=load('main_norman_interpolation_homo_known-Horizontal-kSize-25.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(inter_baseline.scores{1,m}, inter_baseline.scores{2,m}, [],2,[],1);
data_baseline=[FAR,FRR,x]
inter_small=load('main_norman_interpolation_homo_known-Horizontal-kSize-50.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(inter_small.scores{1,m}, inter_small.scores{2,m}, [],2,[],1);
data_small=[FAR,FRR,x]
inter_medium=load('main_norman_interpolation_homo_known-Horizontal-kSize-100.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(inter_medium.scores{1,m}, inter_medium.scores{2,m}, [],2,[],1);
data_medium=[FAR,FRR,x]
inter_big=load('main_norman_interpolation_homo_known-Horizontal-kSize-400.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(inter_big.scores{1,m}, inter_big.scores{2,m}, [],2,[],1);
data_big=[FAR,FRR,x]

data(1:numel(data_baseline(:,1)),10) = data_baseline(:,1);
data(1:numel(data_small(:,1)),11) = data_small(:,1);
data(1:numel(data_medium(:,1)),12) = data_medium(:,1);
data(1:numel(data_big(:,1)),13) = data_big(:,1);

%%
%Interpolation known - hete
inter_baseline=load('main_norman_interpolation_hete_known-Horizontal-kSize-25.mat');
[wer_min, thrd_min, x, FAR, FRR]=wer(inter_baseline.scores{1,m}, inter_baseline.scores{2,m}, [],2,[],1);
data_baseline=[FAR,FRR,x];
inter_small=load('main_norman_interpolation_hete_known-Horizontal-kSize-50.mat');
[wer_min, thrd_min, x, FAR, FRR]=wer(inter_small.scores{1,m}, inter_small.scores{2,m}, [],2,[],1);
data_small=[FAR,FRR,x];
inter_medium=load('main_norman_interpolation_hete_known-Horizontal-kSize-100.mat');
[wer_min, thrd_min, x, FAR, FRR]=wer(inter_medium.scores{1,m}, inter_medium.scores{2,m}, [],2,[],1);
data_medium=[FAR,FRR,x];
inter_big=load('main_norman_interpolation_hete_known-Horizontal-kSize-400.mat');
[wer_min, thrd_min, x, FAR, FRR]=wer(inter_big.scores{1,m}, inter_big.scores{2,m}, [],2,[],1);
data_big=[FAR,FRR,x];

data(1:numel(data_baseline(:,1)),14) = data_baseline(:,1);
data(1:numel(data_small(:,1)),15) = data_small(:,1);
data(1:numel(data_medium(:,1)),16) = data_medium(:,1);
data(1:numel(data_big(:,1)),17) = data_big(:,1);
data(data==0)=NaN;


%%

boxplot(data,'labels',{'unprotected','std. length','small','medium','big','std. length','small','medium','big','std. length','small','medium','big','std. length','small','medium','big'},'plotstyle','compact','orientation','horizontal')
title('Interpolation - Horizontal Strokes')
xlabel('Score')
ylabel('Key Size')

%%
%Scrolling Strokes
% 
% x=[0.63 0.63];
% y=[0.92 0.75];
% annotation('doublearrow',x,y)
% dim=[.65 .55 .65 .3];
% annotation('textbox',dim,'String','Heterogeneous Key','FitBoxToText','on')
% 
% x=[0.63 0.63];
% y=[0.73 0.55];
% annotation('doublearrow',x,y)
% dim=[.65 .37 .65 .3];
% annotation('textbox',dim,'String','Homogeneous Key','FitBoxToText','on')
% 
% 
% x=[0.63 0.63];
% y=[0.54 0.36];
% annotation('doublearrow',x,y)
% dim=[.65 .18 .65 .3];
% annotation('textbox',dim,'String','Heterogeneous Key','FitBoxToText','on')
% 
% x=[0.63 0.63];
% y=[0.35 0.16];
% annotation('doublearrow',x,y)
% dim=[.65 .1 .65 .19];
% annotation('textbox',dim,'String','Homogeneous Key','FitBoxToText','on')
% 
% x=[0.37 0.37];
% y=[0.92 0.55];
% annotation('doublearrow',x,y)
% dim=[.32 .45 .32 .3];
% annotation('textbox',dim,'String','Known Key','FitBoxToText','on')
% 
% x=[0.37 0.37];
% y=[0.53 0.16];
% annotation('doublearrow',x,y)
% dim=[.31 .05 .31 .3];
% annotation('textbox',dim,'String','UnKnown Key','FitBoxToText','on')

%%
%Horizontal Strokes

x=[0.65 0.65];
y=[0.92 0.75];
annotation('doublearrow',x,y)
dim=[.66 .55 .65 .3];
annotation('textbox',dim,'String','Heterogeneous Key','FitBoxToText','on')

x=[0.65 0.65];
y=[0.73 0.55];
annotation('doublearrow',x,y)
dim=[.66 .37 .65 .3];
annotation('textbox',dim,'String','Homogeneous Key','FitBoxToText','on')


x=[0.65 0.65];
y=[0.54 0.36];
annotation('doublearrow',x,y)
dim=[.66 .18 .65 .3];
annotation('textbox',dim,'String','Heterogeneous Key','FitBoxToText','on')

x=[0.65 0.65];
y=[0.35 0.16];
annotation('doublearrow',x,y)
dim=[.66 .1 .65 .19];
annotation('textbox',dim,'String','Homogeneous Key','FitBoxToText','on')

x=[0.41 0.41];
y=[0.92 0.55];
annotation('doublearrow',x,y)
dim=[.36 .45 .32 .3];
annotation('textbox',dim,'String','Known Key','FitBoxToText','on')

x=[0.41 0.41];
y=[0.53 0.16];
annotation('doublearrow',x,y)
dim=[.36 .05 .31 .3];
annotation('textbox',dim,'String','UnKnown Key','FitBoxToText','on')

%%
%Plot the FAR of unknown key attack
%Interpolation Unknown - homo
unprotected=load('main_norman-Horizontal.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(unprotected.scores{1,m}, unprotected.scores{2,m}, [],2,[],1);
data_unprotected=[FAR,FRR,x];

inter_baseline=load('main_norman_interpolation_homo_Unknown-Horizontal-kSize-25.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(inter_baseline.scores{1,m}, inter_baseline.scores{2,m}, [],2,[],1);
data_baseline=[FAR,FRR,x]
inter_small=load('main_norman_interpolation_homo_Unknown-Horizontal-kSize-50.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(inter_small.scores{1,m}, inter_small.scores{2,m}, [],2,[],1);
data_small=[FAR,FRR,x]
inter_medium=load('main_norman_interpolation_homo_Unknown-Horizontal-kSize-100.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(inter_medium.scores{1,m}, inter_medium.scores{2,m}, [],2,[],1);
data_medium=[FAR,FRR,x]
inter_big=load('main_norman_interpolation_homo_Unknown-Horizontal-kSize-400.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(inter_big.scores{1,m}, inter_big.scores{2,m}, [],2,[],1);
data_big=[FAR,FRR,x]

data=data_unprotected;
data(1:numel(data_baseline(:,1)),2) = data_baseline(:,1);
data(1:numel(data_small(:,1)),3) = data_small(:,1);
data(1:numel(data_medium(:,1)),4) = data_medium(:,1);
data(1:numel(data_big(:,1)),5) = data_big(:,1);

boxplot(data,'labels',{'unprotected','std. length','small','medium','big'},'plotstyle','compact','orientation','horizontal')
title('Interpolation - Unknown - Homogeneus Key Horizontal Strokes')
xlabel('FAR')
ylabel('Key Size')

data1=data_unprotected;
data1(1:numel(data_baseline(:,2)),2) = data_baseline(:,2);
data1(1:numel(data_small(:,2)),3) = data_small(:,2);
data1(1:numel(data_medium(:,2)),4) = data_medium(:,2);
data1(1:numel(data_big(:,2)),5) = data_big(:,2);

figure(2)
boxplot(data1,'labels',{'unprotected','std. length','small','medium','big'},'plotstyle','compact','orientation','horizontal')
title('Interpolation - Unknown - Homogeneus Key Horizontal Strokes')
xlabel('FRR')
ylabel('Key Size')

%%
%Plot the FAR of known key attack - homo
inter_baseline=load('main_norman_interpolation_homo_known-Horizontal-kSize-25.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(inter_baseline.scores{1,m}, inter_baseline.scores{2,m}, [],2,[],1);
data_baseline=[FAR,FRR,x]
inter_small=load('main_norman_interpolation_homo_known-Horizontal-kSize-50.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(inter_small.scores{1,m}, inter_small.scores{2,m}, [],2,[],1);
data_small=[FAR,FRR,x]
inter_medium=load('main_norman_interpolation_homo_known-Horizontal-kSize-100.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(inter_medium.scores{1,m}, inter_medium.scores{2,m}, [],2,[],1);
data_medium=[FAR,FRR,x]
inter_big=load('main_norman_interpolation_homo_known-Horizontal-kSize-400.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(inter_big.scores{1,m}, inter_big.scores{2,m}, [],2,[],1);
data_big=[FAR,FRR,x]


data=data_unprotected;
data(1:numel(data_baseline(:,1)),2) = data_baseline(:,1);
data(1:numel(data_small(:,1)),3) = data_small(:,1);
data(1:numel(data_medium(:,1)),4) = data_medium(:,1);
data(1:numel(data_big(:,1)),5) = data_big(:,1);

boxplot(data,'labels',{'unprotected','std. length','small','medium','big'},'plotstyle','compact','orientation','horizontal')
title('Interpolation - Known - Homogeneus Key Horizontal Strokes')
xlabel('FAR')
ylabel('Key Size')

data1=data_unprotected;
data1(1:numel(data_baseline(:,2)),2) = data_baseline(:,2);
data1(1:numel(data_small(:,2)),3) = data_small(:,2);
data1(1:numel(data_medium(:,2)),4) = data_medium(:,2);
data1(1:numel(data_big(:,2)),5) = data_big(:,2);

figure(2)
boxplot(data1,'labels',{'unprotected','std. length','small','medium','big'},'plotstyle','compact','orientation','horizontal')
title('Interpolation - Known - Homogeneus Key Horizontal Strokes')
xlabel('FRR')
ylabel('Key Size')

%Interpolation Unknown - heterogeneous
unprotected=load('main_norman-Horizontal.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(unprotected.scores{1,m}, unprotected.scores{2,m}, [],2,[],1);
data_unprotected=[FAR,FRR,x];

inter_baseline=load('main_norman_interpolation_homo_Unknown-Horizontal-kSize-25.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(inter_baseline.scores{1,m}, inter_baseline.scores{2,m}, [],2,[],1);
data_baseline=[FAR,FRR,x]
inter_small=load('main_norman_interpolation_homo_Unknown-Horizontal-kSize-50.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(inter_small.scores{1,m}, inter_small.scores{2,m}, [],2,[],1);
data_small=[FAR,FRR,x]
inter_medium=load('main_norman_interpolation_homo_Unknown-Horizontal-kSize-100.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(inter_medium.scores{1,m}, inter_medium.scores{2,m}, [],2,[],1);
data_medium=[FAR,FRR,x]
inter_big=load('main_norman_interpolation_homo_Unknown-Horizontal-kSize-400.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(inter_big.scores{1,m}, inter_big.scores{2,m}, [],2,[],1);
data_big=[FAR,FRR,x]

data=data_unprotected;
data(1:numel(data_baseline(:,1)),2) = data_baseline(:,1);
data(1:numel(data_small(:,1)),3) = data_small(:,1);
data(1:numel(data_medium(:,1)),4) = data_medium(:,1);
data(1:numel(data_big(:,1)),5) = data_big(:,1);

boxplot(data,'labels',{'unprotected','std. length','small','medium','big'},'plotstyle','compact','orientation','horizontal')
title('Interpolation - Unknown - Homogeneus Key Horizontal Strokes')
xlabel('FAR')
ylabel('Key Size')

data1=data_unprotected;
data1(1:numel(data_baseline(:,2)),2) = data_baseline(:,2);
data1(1:numel(data_small(:,2)),3) = data_small(:,2);
data1(1:numel(data_medium(:,2)),4) = data_medium(:,2);
data1(1:numel(data_big(:,2)),5) = data_big(:,2);

figure(2)
boxplot(data1,'labels',{'unprotected','std. length','small','medium','big'},'plotstyle','compact','orientation','horizontal')
title('Interpolation - Unknown - Homogeneus Key Horizontal Strokes')
xlabel('FRR')
ylabel('Key Size')

%%
%Plot the FAR of unknown key attack - Hete
inter_baseline=load('main_norman_interpolation_hete_known-Horizontal-kSize-25.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(inter_baseline.scores{1,m}, inter_baseline.scores{2,m}, [],2,[],1);
data_baseline=[FAR,FRR,x]
inter_small=load('main_norman_interpolation_hete_known-Horizontal-kSize-50.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(inter_small.scores{1,m}, inter_small.scores{2,m}, [],2,[],1);
data_small=[FAR,FRR,x]
inter_medium=load('main_norman_interpolation_hete_known-Horizontal-kSize-100.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(inter_medium.scores{1,m}, inter_medium.scores{2,m}, [],2,[],1);
data_medium=[FAR,FRR,x]
inter_big=load('main_norman_interpolation_hete_known-Horizontal-kSize-400.mat')
[wer_min, thrd_min, x, FAR, FRR]=wer(inter_big.scores{1,m}, inter_big.scores{2,m}, [],2,[],1);
data_big=[FAR,FRR,x]


data=data_unprotected;
data(1:numel(data_baseline(:,1)),2) = data_baseline(:,1);
data(1:numel(data_small(:,1)),3) = data_small(:,1);
data(1:numel(data_medium(:,1)),4) = data_medium(:,1);
data(1:numel(data_big(:,1)),5) = data_big(:,1);

boxplot(data,'labels',{'unprotected','std. length','small','medium','big'},'plotstyle','compact','orientation','horizontal')
title('Interpolation - Known - Heterogeneous Key Horizontal Strokes')
xlabel('FAR')
ylabel('Key Size')

data1=data_unprotected;
data1(1:numel(data_baseline(:,2)),2) = data_baseline(:,2);
data1(1:numel(data_small(:,2)),3) = data_small(:,2);
data1(1:numel(data_medium(:,2)),4) = data_medium(:,2);
data1(1:numel(data_big(:,2)),5) = data_big(:,2);

figure(2)
boxplot(data1,'labels',{'unprotected','std. length','small','medium','big'},'plotstyle','compact','orientation','horizontal')
title('Interpolation - Known - Heterogeneous Key Horizontal Strokes')
xlabel('FRR')
ylabel('Key Size')