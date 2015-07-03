function plotDistribution(unknownScores, knowScores, genuineScores,plotTitle)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% construct the styles for ploting purpose
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
style = {'-','--','-.'};%,':'};
color = {'b', 'g', 'r', 'k'};%, 'm', 'y', 'k'};
i=0;
for c=1:length(color),
  for j=1:2, %repeat twice
    for s =1:length(style),
      i=i+1;
      signs{i}=sprintf('%s%s',color{c},style{s});
      lwidth(i) = j;
    end;
  end;
end;

[fU,xU] = ksdensity(unknownScores);
[fK,xK] = ksdensity(knowScores);
[fC,xC] = ksdensity(genuineScores);
plot(xU, fU,signs{1});
hold on;
plot(xK, fK,signs{2});
plot(xC, fC,signs{3});
ylabel('Density');
xlabel('Scores');
title(['Density -',plotTitle]);
legend('Unknown','Know','Genuine');
end