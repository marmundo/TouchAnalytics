clear all
addpath ../lib
m=5

%% Unknown Key Attack
%bioconvolvingUnknown - homo
bioc_baseline=load('main_norman-Horizontal.mat');
data_unprotected_genuine=bioc_baseline.scores{2,m};
data_unprotected_impostor=bioc_baseline.scores{1,m};

bioc_baseline=load('main_norman_bioconvolving_homo_Unknown-Horizontal-kSize-2.mat');
data_baseline_genuine_homo_unknown=bioc_baseline.scores{2,m};
data_baseline_impostor_homo_unknown=bioc_baseline.scores{1,m};

bioc_small=load('main_norman_bioconvolving_homo_Unknown-Horizontal-kSize-3.mat');
data_small_genuine_homo_unknown=bioc_small.scores{2,m};
data_small_impostor_homo_unknown=bioc_small.scores{1,m};

bioc_medium=load('main_norman_bioconvolving_homo_Unknown-Horizontal-kSize-16.mat');
data_medium_genuine_homo_unknown=bioc_medium.scores{2,m};
data_medium_impostor_homo_unknown=bioc_medium.scores{1,m};

bioc_big=load('main_norman_bioconvolving_homo_Unknown-Horizontal-kSize-25.mat');
data_big_genuine_homo_unknown=bioc_big.scores{2,m};
data_big_impostor_homo_unknown=bioc_big.scores{1,m};

%bioconvolvingUnknown - hete

bioc_baseline=load('main_norman_bioconvolving_hete_Unknown-Horizontal-kSize-2.mat');
data_baseline_genuine_hete_unknown=bioc_baseline.scores{2,m};
data_baseline_impostor_hete_unknown=bioc_baseline.scores{1,m};

bioc_small=load('main_norman_bioconvolving_hete_Unknown-Horizontal-kSize-3.mat');
data_small_genuine_hete_unknown=bioc_small.scores{2,m};
data_small_impostor_hete_unknown=bioc_small.scores{1,m};

bioc_medium=load('main_norman_bioconvolving_hete_Unknown-Horizontal-kSize-16.mat');
data_medium_genuine_hete_unknown=bioc_medium.scores{2,m};
data_medium_impostor_hete_unknown=bioc_medium.scores{1,m};

bioc_big=load('main_norman_bioconvolving_hete_Unknown-Horizontal-kSize-25.mat');
data_big_genuine_hete_unknown=bioc_big.scores{2,m};
data_big_impostor_hete_unknown=bioc_big.scores{1,m};

%% Known Key Attack
%bioconvolvingknown - homo

bioc_baseline=load('main_norman_bioconvolving_homo_known-Horizontal-kSize-2.mat');
data_baseline_genuine_homo_known=bioc_baseline.scores{2,m};
data_baseline_impostor_homo_known=bioc_baseline.scores{1,m};

bioc_small=load('main_norman_bioconvolving_homo_known-Horizontal-kSize-3.mat');
data_small_genuine_homo_known=bioc_small.scores{2,m};
data_small_impostor_homo_known=bioc_small.scores{1,m};

bioc_medium=load('main_norman_bioconvolving_homo_known-Horizontal-kSize-16.mat');
data_medium_genuine_homo_known=bioc_medium.scores{2,m};
data_medium_impostor_homo_known=bioc_medium.scores{1,m};

bioc_big=load('main_norman_bioconvolving_homo_known-Horizontal-kSize-25.mat');
data_big_genuine_homo_known=bioc_big.scores{2,m};
data_big_impostor_homo_known=bioc_big.scores{1,m};

%bioconvolvingknown - hete

bioc_baseline=load('main_norman_bioconvolving_hete_known-Horizontal-kSize-2.mat');
data_baseline_genuine_hete_known=bioc_baseline.scores{2,m};
data_baseline_impostor_hete_known=bioc_baseline.scores{1,m};

bioc_small=load('main_norman_bioconvolving_hete_known-Horizontal-kSize-3.mat');
data_small_genuine_hete_known=bioc_small.scores{2,m};
data_small_impostor_hete_known=bioc_small.scores{1,m};

bioc_medium=load('main_norman_bioconvolving_hete_known-Horizontal-kSize-16.mat');
data_medium_genuine_hete_known=bioc_medium.scores{2,m};
data_medium_impostor_hete_known=bioc_medium.scores{1,m};

bioc_big=load('main_norman_bioconvolving_hete_known-Horizontal-kSize-25.mat');
data_big_genuine_hete_known=bioc_big.scores{2,m};
data_big_impostor_hete_known=bioc_big.scores{1,m};

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
boxplot(data,'labels',labels,'orientation','horizontal','plotstyle','compact','outliersize',1);
%boxplot(data(:,1:25),'labels',labels(1:25),'orientation','horizontal','symbol','','plotstyle','compact')
% h=findobj(gca,'tag','Outliers'); set(h,'Marker','o');
title('Box Plot of Scores - BioConvolving- Horizontal');
xlabel('Score');
file=['Pictures/Box_Plot/Box Plot of Scores - BioConvolving- Horizontal.png'];
print('-dpng',file);

x=[0.65 0.65];
y=[0.92 0.79];
annotation('doublearrow',x,y)
dim=[.65 .57 .3 .3];
annotation('textbox',dim,'String','Heterogeneous Key','FitBoxToText','on')

x=[0.65 0.65];
y=[0.16 0.675];
annotation('doublearrow',x,y)
dim=[.65 .45 .3 .3];
annotation('textbox',dim,'String','Homogeneous Key','FitBoxToText','on')

x=[0.65 0.65];
y=[0.67 0.555];
annotation('doublearrow',x,y)
dim=[.65 .32 .3 .3];
annotation('textbox',dim,'String','Heterogeneous Key','FitBoxToText','on')

x=[0.65 0.65];
y=[0.55 0.43];
annotation('doublearrow',x,y)
dim=[.65 .2 .3 .3];
annotation('textbox',dim,'String','Homogeneous Key','FitBoxToText','on')

x=[0.7 0.7];
y=[0.3165 0.273];
annotation('doublearrow',x,y)
dim=[.7 .1 .25 .25];
annotation('textbox',dim,'String','Heterogeneous Key','FitBoxToText','on')

x=[0.7 0.7];
y=[0.14 0.26];
annotation('doublearrow',x,y)
dim=[.7 .1 .15 .12];
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

x=[0.3 0.3];
y=[0.92 0.616];
annotation('doublearrow',x,y)
dim=[.25 .45 .3 .3];
annotation('textbox',dim,'String','Known Key','FitBoxToText','on')

x=[0.3 0.3];
y=[0.67 0.14];
annotation('doublearrow',x,y)
dim=[.25 .13 .31 .3];
annotation('textbox',dim,'String','UnKnown Key','FitBoxToText','on')

%%
% bioc_baseline_uk=load('main_norman_bioconvolving_homo_Unknown-Horizontal-kSize-2.mat');
% bioc_baseline_k=load('main_norman_bioconvolving_homo_known-Horizontal-kSize-2.mat');
% gen_uk=bioc_baseline_uk.scores{2,5};
% gen_k=bioc_baseline_k.scores{2,5};
% hist(gen_uk)
% figure(2)
% hist(gen_k)