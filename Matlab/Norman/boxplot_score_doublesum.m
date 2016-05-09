clear all
addpath ../lib
m=5

%% Unknown Key Attack
%doublesumUnknown - homo
ds_baseline=load('main_norman-Horizontal.mat');
data_unprotected_genuine=ds_baseline.scores{2,m};
data_unprotected_impostor=ds_baseline.scores{1,m};

ds_baseline=load('main_norman_doublesum_homo_Unknown-Horizontal-kSize-25.mat');
data_baseline_genuine_homo_unknown=ds_baseline.scores{2,m};
data_baseline_impostor_homo_unknown=ds_baseline.scores{1,m};

ds_small=load('main_norman_doublesum_homo_Unknown-Horizontal-kSize-50.mat');
data_small_genuine_homo_unknown=ds_small.scores{2,m};
data_small_impostor_homo_unknown=ds_small.scores{1,m};

ds_medium=load('main_norman_doublesum_homo_Unknown-Horizontal-kSize-100.mat');
data_medium_genuine_homo_unknown=ds_medium.scores{2,m};
data_medium_impostor_homo_unknown=ds_medium.scores{1,m};

ds_big=load('main_norman_doublesum_homo_Unknown-Horizontal-kSize-400.mat');
data_big_genuine_homo_unknown=ds_big.scores{2,m};
data_big_impostor_homo_unknown=ds_big.scores{1,m};

%doublesumUnknown - hete

ds_baseline=load('main_norman_doublesum_hete_Unknown-Horizontal-kSize-25.mat');
data_baseline_genuine_hete_unknown=ds_baseline.scores{2,m};
data_baseline_impostor_hete_unknown=ds_baseline.scores{1,m};

ds_small=load('main_norman_doublesum_hete_Unknown-Horizontal-kSize-50.mat');
data_small_genuine_hete_unknown=ds_small.scores{2,m};
data_small_impostor_hete_unknown=ds_small.scores{1,m};

ds_medium=load('main_norman_doublesum_hete_Unknown-Horizontal-kSize-100.mat');
data_medium_genuine_hete_unknown=ds_medium.scores{2,m};
data_medium_impostor_hete_unknown=ds_medium.scores{1,m};

ds_big=load('main_norman_doublesum_hete_Unknown-Horizontal-kSize-400.mat');
data_big_genuine_hete_unknown=ds_big.scores{2,m};
data_big_impostor_hete_unknown=ds_big.scores{1,m};

%% Known Key Attack
%doublesumknown - homo

ds_baseline=load('main_norman_doublesum_homo_known-Horizontal-kSize-25.mat');
data_baseline_genuine_homo_known=ds_baseline.scores{2,m};
data_baseline_impostor_homo_known=ds_baseline.scores{1,m};

ds_small=load('main_norman_doublesum_homo_known-Horizontal-kSize-50.mat');
data_small_genuine_homo_known=ds_small.scores{2,m};
data_small_impostor_homo_known=ds_small.scores{1,m};

ds_medium=load('main_norman_doublesum_homo_known-Horizontal-kSize-100.mat');
data_medium_genuine_homo_known=ds_medium.scores{2,m};
data_medium_impostor_homo_known=ds_medium.scores{1,m};

ds_big=load('main_norman_doublesum_homo_known-Horizontal-kSize-400.mat');
data_big_genuine_homo_known=ds_big.scores{2,m};
data_big_impostor_homo_known=ds_big.scores{1,m};

%doublesumknown - hete

ds_baseline=load('main_norman_doublesum_hete_known-Horizontal-kSize-25.mat');
data_baseline_genuine_hete_known=ds_baseline.scores{2,m};
data_baseline_impostor_hete_known=ds_baseline.scores{1,m};

ds_small=load('main_norman_doublesum_hete_known-Horizontal-kSize-50.mat');
data_small_genuine_hete_known=ds_small.scores{2,m};
data_small_impostor_hete_known=ds_small.scores{1,m};

ds_medium=load('main_norman_doublesum_hete_known-Horizontal-kSize-100.mat');
data_medium_genuine_hete_known=ds_medium.scores{2,m};
data_medium_impostor_hete_known=ds_medium.scores{1,m};

ds_big=load('main_norman_doublesum_hete_known-Horizontal-kSize-400.mat');
data_big_genuine_hete_known=ds_big.scores{2,m};
data_big_impostor_hete_known=ds_big.scores{1,m};

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

data=normc(data);
%%
%Boxplot
labels={'Unprotected','Std. Length','Small','Medium','Big','Std. Length','Small','Medium','Big','Unprotected','Std. Length','Small','Medium','Big','Std. Length','Small','Medium','Big','Std. Length','Small','Medium','Big','Std. Length','Small','Medium','Big'};
%labels={'unprotected_gen','std_gen','small_gen','medium_gen','big_gen','std_gen','small_gen','medium_gen','big_gen','unprotected_imp','std_imp','small_imp','medium_imp','big_imp','std_imp','small_imp','medium_imp','big_imp'};
%boxplot(data,'labels',labels,'orientation','horizontal','plotstyle','compact','outliersize',1);

%%
%remove outliers
% mu = mean(data);
% sigma = std(data);
% [n,p] = size(data); 
% MeanMat = repmat(mu,n,1);
% SigmaMat = repmat(sigma,n,1);
% outliers = abs(data - MeanMat) > 3*SigmaMat; 
% nout = sum(outliers); 
% data(any(outliers,2),:) = []; 
% %boxplot(data) 
% %h=findobj(gca,'tag','Outliers'); set(h,'Marker','o');
%%
%boxplot(data,'labels',labels,'orientation','horizontal','plotstyle','compact','outliersize',1);
boxplot(data,'labels',labels,'orientation','horizontal','plotstyle','compact','symbol','');
%boxplot(data(:,1:25),'labels',labels(1:25),'orientation','horizontal','symbol','','plotstyle','compact')
% h=findobj(gca,'tag','Outliers'); set(h,'Marker','o');
title('Box Plot of Scores - DoubleSum- Horizontal');
xlabel('Score');
file=['Pictures/Box_Plot/Box Plot of Scores - DoubleSum- Horizontal.png'];
print('-dpng',file);

x=[0.48 0.48];
y=[0.92 0.81];
annotation('doublearrow',x,y)
dim=[0.48 .57 .3 .3];
annotation('textbox',dim,'String','Heterogeneous Key','FitBoxToText','on')

x=[0.44 0.44];
y=[0.79 0.68];
annotation('doublearrow',x,y)
dim=[0.44 .45 .3 .3];
annotation('textbox',dim,'String','Homogeneous Key','FitBoxToText','on')

x=[0.44 0.44];
y=[0.67 0.555];
annotation('doublearrow',x,y)
dim=[0.44 .32 .3 .3];
annotation('textbox',dim,'String','Heterogeneous Key','FitBoxToText','on')

x=[0.48 0.48];
y=[0.55 0.43];
annotation('doublearrow',x,y)
dim=[0.48 .2 .3 .3];
annotation('textbox',dim,'String','Homogeneous Key','FitBoxToText','on')

x=[0.65 0.65];
y=[0.39 0.273];
annotation('doublearrow',x,y)
dim=[.65 .1 .25 .25];
annotation('textbox',dim,'String','Heterogeneous Key','FitBoxToText','on')

x=[0.65 0.65];
y=[0.14 0.26];
annotation('doublearrow',x,y)
dim=[.65 .1 .15 .12];
annotation('textbox',dim,'String','Homogeneous Key','FitBoxToText','on')

x=[0.2 0.2];
y=[0.92 0.4];
annotation('doublearrow',x,y)
dim=[0.2 .416 .3 .19];
annotation('textbox',dim,'String','Impostor Score','FitBoxToText','on')

x=[0.2 0.2];
y=[0.39 0.11];
annotation('doublearrow',x,y)
dim=[0.2 .0165 .3 .19];
annotation('textbox',dim,'String','Genuine Score','FitBoxToText','on')

x=[0.29 0.29];
y=[0.92 0.488];
annotation('doublearrow',x,y)
dim=[.25 .45 .3 .3];
annotation('textbox',dim,'String','Known Key','FitBoxToText','on')

x=[0.29 0.29];
y=[0.487 0.14];
annotation('doublearrow',x,y)
dim=[.24 .13 .31 .3];
annotation('textbox',dim,'String','UnKnown Key','FitBoxToText','on')

%%
% ds_baseline_uk=load('main_norman_doublesum_homo_Unknown-Horizontal-kSize-25.mat');
% ds_baseline_k=load('main_norman_doublesum_homo_known-Horizontal-kSize-25.mat');
% gen_uk=ds_baseline_uk.scores{2,5};
% gen_k=ds_baseline_k.scores{2,5};
% hist(gen_uk)
% figure(2)
% hist(gen_k)