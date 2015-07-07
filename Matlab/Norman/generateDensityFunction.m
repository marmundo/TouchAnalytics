clear all;
close all;


orientation={'Horizontal','Scrolling'};
scenario={'hete','homo'};
%i controls scenario
i=1;
% j controls orientation
j=1;


%% Interpolation
%plotTitle=strcat('Interpolation-Heterogeneous Key-',orientation{j});
plotTitle=strcat('Interpolation-Homogeneous Key-',orientation{j});
method='interpolation';
unknown=load(strcat('main_norman_',method,'_',scenario{i},'_Unknown-',orientation{j},'-kSize-25.mat'));
known=load(strcat('main_norman_',method,'_',scenario{i},'_known-',orientation{j},'-kSize-25.mat'));
plotDistribution(unknown.scores{1,5},known.scores{1,5},known.scores{2,5},plotTitle);
file=strcat('Pictures/DensityComparison/',plotTitle,'.png');
print('-dpng',file);
close all;

%% BioHashing
%plotTitle=strcat('BioHashing-Heterogeneous Key-',orientation{j});
plotTitle=strcat('BioHashing-Homogeneous Key-',orientation{j});
method='biohash';
unknown=load(strcat('main_norman_',method,'_',scenario{i},'_Unknown-',orientation{j},'-kSize-1.mat'));
known=load(strcat('main_norman_',method,'_',scenario{i},'_known-',orientation{j},'-kSize-1.mat'));
plotDistribution(unknown.scores{1,5},known.scores{1,5},known.scores{2,5},plotTitle);
file=strcat('Pictures/DensityComparison/',plotTitle,'.png');
print('-dpng',file);
close all;

%% BioConvolving
%plotTitle=strcat('BioConvolving-Heterogeneous Key-',orientation{j});
plotTitle=strcat('BioConvolving-Homogeneous Key-',orientation{j});
method='bioconvolving';
unknown=load(strcat('main_norman_',method,'_',scenario{i},'_Unknown-',orientation{j},'-kSize-2.mat'));
known=load(strcat('main_norman_',method,'_',scenario{i},'_known-',orientation{j},'-kSize-2.mat'));
plotDistribution(unknown.scores{1,5},known.scores{1,5},known.scores{2,5},plotTitle);
file=strcat('Pictures/DensityComparison/',plotTitle,'.png');
print('-dpng',file);
close all;

%% Double Sum
plotTitle=strcat('DoubleSum-Heterogeneous Key-',orientation{j});
%plotTitle=strcat('DoubleSum-Homogeneous Key-',orientation{j});
method='doublesum';
unknown=load(strcat('main_norman_',method,'_',scenario{i},'_Unknown-',orientation{j},'-kSize-25.mat'));
known=load(strcat('main_norman_',method,'_',scenario{i},'_known-',orientation{j},'-kSize-25.mat'));
plotDistribution(unknown.scores{1,5},known.scores{1,5},known.scores{2,5},plotTitle);
file=strcat('Pictures/DensityComparison/',plotTitle,'.png');
print('-dpng',file);
close all;