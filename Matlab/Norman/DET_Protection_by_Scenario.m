%% Intro
addpath ..
addpath ../lib

%method=2; %logistic per user
 method=4; %knn
if method==4
    classifier='Knn'
elseif method==2
    classifier='Logistic'
end

scenarios={'Original','Homo_UK','Homo_K','Hete_UK','Hete_K'};

load('scrolling data.mat');
load('horizontal data.mat');

%scenarioScore{protectionMethod}{Scenario}{orientation}
%scenarioScore{1,1,1}=main_norman(scrolling);
%scenarioScore{1,1,2}=main_norman(horizontal);

%% Interpolation
% 
% for i=2:length(scenarios)
%     scenarioScore{1}{i}{1}=main_norman_interpolation(scrolling,scenarios{i});
% end
% 
% for i=1:5,
%      eer_system(i) = wer(scenarioScore{i}{1,method}, scenarioScore{i}{2,method}, [],2,[],i);
% end;
% title({['DET - Classifier: ',classifier,' using Interpolation-Scrolling']});
% legend('Original','Homo_UK','Homo_K','Hete_UK','Hete_K','location', 'Southwest');
% print('-dpng',['Pictures/interpolation_scrolling_DET_',classifier,'.png']);
% 
% for i=2:length(scenarios)
%     scenarioScore{1}{i}{2}=main_norman_interpolation(horizontal,scenarios{i});
% end
% 
% for i=1:5,
%      eer_system(i) = wer(scenarioScore{i}{1,method}, scenarioScore{i}{2,method}, [],2,[],i);
% end;
% title({['DET - Classifier:',classifier,' using Interpolation-horizontal']});
% legend('Original','Homo_UK','Homo_K','Hete_UK','Hete_K','location', 'Southwest');
% print('-dpng',['Pictures/interpolation_horizontal_DET_',classifier,'.png']);
% 
%% BioHashing
for i=2:2%length(scenarios)
    scenarioScore{2,i,1}=main_norman_biohashing(scrolling,scenarios{i});
end

eer_system(1) = wer(scenarioScore{1,1,1}{1,method}, scenarioScore{1,1,1}{2,method}, [],2,[],1);

for i=2:2,
     eer_system(i) = wer(scenarioScore{2,i,1}{1,method}, scenarioScore{2,i,1}{2,method}, [],2,[],i);
end;
title({['DET - Classifier: ',classifier,' using BioHashing-Scrolling']});
legend('Original','Homo_UK','Homo_K','Hete_UK','Hete_K','location', 'Southwest');
print('-dpng',['Pictures/biohashing_scrolling_DET_',classifier,'.png']);

% for i=2:length(scenarios)
%     scenarioScore{2}{i}{2}=main_norman_biohashing(horizontal,scenarios{i});
% end
% 
% for i=1:5,
%      eer_system(i) = wer(scenarioScore{i}{1,method}, scenarioScore{i}{2,method}, [],2,[],i);
% end;
% title({['DET - Classifier: ',classifier,' using BioHashing-horizontal']});
% legend('Original','Homo_UK','Homo_K','Hete_UK','Hete_K','location', 'Southwest');
% print('-dpng',['Pictures/biohashing_horizontal_DET_',classifier,'.png']);

% %% BioConvolving
% for i=2:length(scenarios)
%     scenarioScore{3}{i}{1}=main_norman_bioconvolving(scrolling,scenarios{i});
% end
% 
% for i=1:5,
%      eer_system(i) = wer(scenarioScore{i}{1,method}, scenarioScore{i}{2,method}, [],2,[],i);
% end;
% title({['DET - Classifier: ', classifier,' using BioConvolving-Scrolling']});
% legend('Original','Homo_UK','Homo_K','Hete_UK','Hete_K','location', 'Southwest');
% print('-dpng',['Pictures/bioconvolving_scrolling_DET_',classifier,'.png']);

% for i=2:length(scenarios)
%     scenarioScore{3}{i}{2}=main_norman_bioconvolving(horizontal,scenarios{i});
% end
% 
% for i=1:5,
%      eer_system(i) = wer(scenarioScore{i}{1,method}, scenarioScore{i}{2,method}, [],2,[],i);
% end;
% title({['DET - Classifier: ',classifier,' using BioConvolving-horizontal']});
% legend('Original','Homo_UK','Homo_K','Hete_UK','Hete_K','location', 'Southwest');
% print('-dpng',['Pictures/bioconvolving_horizontal_DET_',classifier,'.png']);

%% DoubleSum
for i=2:length(scenarios)
    scenarioScore{4}{i}{1}=main_norman_doublesum(scrolling,scenarios{i});
end

for i=1:5,
     eer_system(i) = wer(scenarioScore{i}{1,method}, scenarioScore{i}{2,method}, [],2,[],i);
end;
title({['DET - Classifier: ',classifier,' using DoubleSum-Scrolling']});
legend('Original','Homo_UK','Homo_K','Hete_UK','Hete_K','location', 'Southwest');
print('-dpng',['Pictures/doublesum_scrolling_DET_',classifier,'.png']);

for i=2:length(scenarios)
    scenarioScore{4}{i}{2}=main_norman_doublesum(horizontal,scenarios{i});
end

for i=1:5,
     eer_system(i) = wer(scenarioScore{i}{1,method}, scenarioScore{i}{2,method}, [],2,[],i);
end;
title({['DET - Classifier: ',classifier,' using DoubleSum-Horizontal']});
legend('Original','Homo_UK','Homo_K','Hete_UK','Hete_K','location', 'Southwest');
print('-dpng',['Pictures/doublesum_horizontal_DET_',classifier,'.png']);