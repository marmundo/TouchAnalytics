clear all;
close all;

orientation={'Horizontal','Scrolling'};
method='doublesum';
scenario={'hete','homo'};
%i controls scenario
i=2;
% j controls orientation
j=2;

%plotTitle=strcat('DoubleSum-Heterogeneous Key-',orientation{j});
plotTitle=strcat('DoubleSum-Homogeneous Key-',orientation{j});

unknown=load(strcat('main_norman_',method,'_',scenario{i},'_Unknown-',orientation{j},'-kSize-25.mat'));
known=load(strcat('main_norman_',method,'_',scenario{i},'_known-',orientation{j},'-kSize-25.mat'));
plotDistribution(unknown.scores{1,5},known.scores{1,5},known.scores{2,5},plotTitle);
file=strcat('Pictures/DensityComparison/',plotTitle,'.png');
print('-dpng',file);