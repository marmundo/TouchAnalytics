clear all
addpath ../lib
m=5

%% Unknown Key Attack
%interpolation Unknown - homo
inter_baseline=load('main_norman-Horizontal.mat');
data_unprotected_genuine=inter_baseline.scores{2,m};
data_unprotected_impostor=inter_baseline.scores{1,m};

inter_baseline=load('main_norman_interpolation_homo_Unknown-Horizontal-kSize-25.mat');
data_baseline_genuine_homo_unknown=inter_baseline.scores{2,m};
data_baseline_impostor_homo_unknown=inter_baseline.scores{1,m};

inter_small=load('main_norman_interpolation_homo_Unknown-Horizontal-kSize-50.mat');
data_small_genuine_homo_unknown=inter_small.scores{2,m};
data_small_impostor_homo_unknown=inter_small.scores{1,m};

inter_medium=load('main_norman_interpolation_homo_Unknown-Horizontal-kSize-100.mat');
data_medium_genuine_homo_unknown=inter_medium.scores{2,m};
data_medium_impostor_homo_unknown=inter_medium.scores{1,m};

inter_big=load('main_norman_interpolation_homo_Unknown-Horizontal-kSize-400.mat');
data_big_genuine_homo_unknown=inter_big.scores{2,m};
data_big_impostor_homo_unknown=inter_big.scores{1,m};

%interpolation Unknown - hete

inter_baseline=load('main_norman_interpolation_hete_Unknown-Horizontal-kSize-25.mat');
data_baseline_genuine_hete_unknown=inter_baseline.scores{2,m};
data_baseline_impostor_hete_unknown=inter_baseline.scores{1,m};

inter_small=load('main_norman_interpolation_hete_Unknown-Horizontal-kSize-50.mat');
data_small_genuine_hete_unknown=inter_small.scores{2,m};
data_small_impostor_hete_unknown=inter_small.scores{1,m};

inter_medium=load('main_norman_interpolation_hete_Unknown-Horizontal-kSize-100.mat');
data_medium_genuine_hete_unknown=inter_medium.scores{2,m};
data_medium_impostor_hete_unknown=inter_medium.scores{1,m};

inter_big=load('main_norman_interpolation_hete_Unknown-Horizontal-kSize-400.mat');
data_big_genuine_hete_unknown=inter_big.scores{2,m};
data_big_impostor_hete_unknown=inter_big.scores{1,m};

%% Known Key Attack
%interpolation known - homo

inter_baseline=load('main_norman_interpolation_homo_known-Horizontal-kSize-25.mat');
data_baseline_genuine_homo_known=inter_baseline.scores{2,m};
data_baseline_impostor_homo_known=inter_baseline.scores{1,m};

inter_small=load('main_norman_interpolation_homo_known-Horizontal-kSize-50.mat');
data_small_genuine_homo_known=inter_small.scores{2,m};
data_small_impostor_homo_known=inter_small.scores{1,m};

inter_medium=load('main_norman_interpolation_homo_known-Horizontal-kSize-100.mat');
data_medium_genuine_homo_known=inter_medium.scores{2,m};
data_medium_impostor_homo_known=inter_medium.scores{1,m};

inter_big=load('main_norman_interpolation_homo_known-Horizontal-kSize-400.mat');
data_big_genuine_homo_known=inter_big.scores{2,m};
data_big_impostor_homo_known=inter_big.scores{1,m};

%interpolation known - hete

inter_baseline=load('main_norman_interpolation_hete_known-Horizontal-kSize-25.mat');
data_baseline_genuine_hete_known=inter_baseline.scores{2,m};
data_baseline_impostor_hete_known=inter_baseline.scores{1,m};

inter_small=load('main_norman_interpolation_hete_known-Horizontal-kSize-50.mat');
data_small_genuine_hete_known=inter_small.scores{2,m};
data_small_impostor_hete_known=inter_small.scores{1,m};

inter_medium=load('main_norman_interpolation_hete_known-Horizontal-kSize-100.mat');
data_medium_genuine_hete_known=inter_medium.scores{2,m};
data_medium_impostor_hete_known=inter_medium.scores{1,m};

inter_big=load('main_norman_interpolation_hete_known-Horizontal-kSize-400.mat');
data_big_genuine_hete_known=inter_big.scores{2,m};
data_big_impostor_hete_known=inter_big.scores{1,m};

%% Data Organiztion

%% Unknown Key
%genuine scores
data=data_unprotected_genuine;

%homogeneous key score
data(1:numel(data_baseline_genuine_homo_unknown(:,1)),2) = data_baseline_genuine_homo_unknown(:,1);
data(1:numel(data_small_genuine_homo_unknown(:,1)),3) = data_small_genuine_homo_unknown(:,1);
data(1:numel(data_medium_genuine_homo_unknown(:,1)),4) = data_medium_genuine_homo_unknown(:,1);
data(1:numel(data_big_genuine_homo_unknown(:,1)),5) = data_big_genuine_homo_unknown(:,1);
%heterogenoeus key score
data(1:numel(data_baseline_genuine_hete_unknown(:,1)),6) = data_baseline_genuine_hete_unknown(:,1);
data(1:numel(data_small_genuine_hete_unknown(:,1)),7) = data_small_genuine_hete_unknown(:,1);
data(1:numel(data_medium_genuine_hete_unknown(:,1)),8) = data_medium_genuine_hete_unknown(:,1);
data(1:numel(data_big_genuine_hete_unknown(:,1)),9) = data_big_genuine_hete_unknown(:,1);


%impostor scores
data(1:numel(data_unprotected_impostor(:,1)),10) = data_unprotected_impostor(:,1);
%homogeneous key score
data(1:numel(data_baseline_impostor_homo_unknown(:,1)),11) = data_baseline_impostor_homo_unknown(:,1);
data(1:numel(data_small_impostor_homo_unknown(:,1)),12) = data_small_impostor_homo_unknown(:,1);
data(1:numel(data_medium_impostor_homo_unknown(:,1)),13) = data_medium_impostor_homo_unknown(:,1);
data(1:numel(data_big_impostor_homo_unknown(:,1)),14) = data_big_impostor_homo_unknown(:,1);
%heterogeneous key score
data(1:numel(data_baseline_impostor_hete_unknown(:,1)),15) = data_baseline_impostor_hete_unknown(:,1);
data(1:numel(data_small_impostor_hete_unknown(:,1)),16) = data_small_impostor_hete_unknown(:,1);
data(1:numel(data_medium_impostor_hete_unknown(:,1)),17) = data_medium_impostor_hete_unknown(:,1);
data(1:numel(data_big_impostor_hete_unknown(:,1)),18) = data_big_impostor_hete_unknown(:,1);

%% Known Key
%genuine scores
%homogeneous key score
%data(1:numel(data_baseline_genuine_homo_known(:,1)),19) = data_baseline_genuine_homo_known(:,1);
%data(1:numel(data_small_genuine_homo_known(:,1)),20) = data_small_genuine_homo_known(:,1);
%data(1:numel(data_medium_genuine_homo_known(:,1)),21) = data_medium_genuine_homo_known(:,1);
%data(1:numel(data_big_genuine_homo_known(:,1)),22) = data_big_genuine_homo_known(:,1);
%heterogenoeus key score
%data(1:numel(data_baseline_genuine_hete_known(:,1)),19) = data_baseline_genuine_hete_known(:,1);
%data(1:numel(data_small_genuine_hete_known(:,1)),20) = data_small_genuine_hete_known(:,1);
%data(1:numel(data_medium_genuine_hete_known(:,1)),21) = data_medium_genuine_hete_known(:,1);
%data(1:numel(data_big_genuine_hete_known(:,1)),22) = data_big_genuine_hete_known(:,1);


%homogeneous key score
data(1:numel(data_baseline_impostor_homo_known(:,1)),19) = data_baseline_impostor_homo_known(:,1);
data(1:numel(data_small_impostor_homo_known(:,1)),20) = data_small_impostor_homo_known(:,1);
data(1:numel(data_medium_impostor_homo_known(:,1)),21) = data_medium_impostor_homo_known(:,1);
data(1:numel(data_big_impostor_homo_known(:,1)),22) = data_big_impostor_homo_known(:,1);
%heterogeneous key score
data(1:numel(data_baseline_impostor_hete_known(:,1)),23) = data_baseline_impostor_hete_known(:,1);
data(1:numel(data_small_impostor_hete_known(:,1)),24) = data_small_impostor_hete_known(:,1);
data(1:numel(data_medium_impostor_hete_known(:,1)),25) = data_medium_impostor_hete_known(:,1);
data(1:numel(data_big_impostor_hete_known(:,1)),26) = data_big_impostor_hete_known(:,1);


%%
%Boxplot
labels={'Unprotected','Std. Length','Small','Medium','Big','Std. Length','Small','Medium','Big','Unprotected','Std. Length','Small','Medium','Big','Std. Length','Small','Medium','Big','Std. Length','Small','Medium','Big','Std. Length','Small','Medium','Big'};
%labels={'unprotected_gen','std_gen','small_gen','medium_gen','big_gen','std_gen','small_gen','medium_gen','big_gen','unprotected_imp','std_imp','small_imp','medium_imp','big_imp','std_imp','small_imp','medium_imp','big_imp'};
%boxplot(data,'labels',labels,'orientation','horizontal','plotstyle','compact','outliersize',1);
boxplot(data,'labels',labels,'orientation','horizontal','plotstyle','compact','symbol','');
title('Box Plot of Scores - Interpolation - Horizontal');
xlabel('Score');
file=['Pictures/Box_Plot/Box Plot of Scores - Interpolation - Horizontal.png'];
print('-dpng',file);

x=[0.8 0.8];
y=[0.92 0.79];
annotation('doublearrow',x,y)
dim=[.8 .57 .3 .3];
annotation('textbox',dim,'String','Heterogeneous Key','FitBoxToText','on')

x=[0.58 0.58];
y=[0.8 0.675];
annotation('doublearrow',x,y)
dim=[.58 .45 .3 .3];
annotation('textbox',dim,'String','Homogeneous Key','FitBoxToText','on')

x=[0.58 0.58];
y=[0.67 0.555];
annotation('doublearrow',x,y)
dim=[.58 .32 .3 .3];
annotation('textbox',dim,'String','Heterogeneous Key','FitBoxToText','on')

x=[0.58 0.58];
y=[0.55 0.43];
annotation('doublearrow',x,y)
dim=[.58 .2 .3 .3];
annotation('textbox',dim,'String','Homogeneous Key','FitBoxToText','on')

x=[0.82 0.82];
y=[0.385 0.273];
annotation('doublearrow',x,y)
dim=[.82 .1 .25 .25];
annotation('textbox',dim,'String','Heterogeneous Key','FitBoxToText','on')

x=[0.62 0.62];
y=[0.14 0.26];
annotation('doublearrow',x,y)
dim=[.62 .1 .15 .12];
annotation('textbox',dim,'String','Homogeneous Key','FitBoxToText','on')

x=[0.2 0.2];
y=[0.92 0.4];
annotation('doublearrow',x,y)
dim=[0.2 .48 .3 .19];
annotation('textbox',dim,'String','Impostor Score','FitBoxToText','on')

x=[0.2 0.2];
y=[0.39 0.11];
annotation('doublearrow',x,y)
dim=[0.2 .085 .3 .19];
annotation('textbox',dim,'String','Genuine Score','FitBoxToText','on')

x=[0.3 0.3];
y=[0.92 0.68];
annotation('doublearrow',x,y)
dim=[.25 .45 .3 .3];
annotation('textbox',dim,'String','Known Key','FitBoxToText','on')

x=[0.3 0.3];
y=[0.67 0.14];
annotation('doublearrow',x,y)
dim=[.25 .13 .31 .3];
annotation('textbox',dim,'String','UnKnown Key','FitBoxToText','on')


%%
% inter_baseline_uk=load('main_norman_interpolation_homo_Unknown-Horizontal-kSize-25.mat');
% inter_baseline_k=load('main_norman_interpolation_homo_known-Horizontal-kSize-25.mat');
% gen_uk=inter_baseline_uk.scores{2,5};
% gen_k=inter_baseline_k.scores{2,5};
% hist(gen_uk)
% figure(2)
% hist(gen_k)