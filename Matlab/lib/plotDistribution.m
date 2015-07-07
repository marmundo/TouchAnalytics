function plotDistribution(unknownScores, knowScores, genuineScores,plotTitle)
[fU,xU] = ksdensity(unknownScores);
[fK,xK] = ksdensity(knowScores);
[fC,xC] = ksdensity(genuineScores);
plot(xU, fU,'b-');
hold on;
plot(xK, fK,'r--');
plot(xC, fC,'g-.');
ylabel('Density');
xlabel('Scores');
title(['Density -',plotTitle]);
legend('Impostor Unknown Key','Impostor Know Key','Genuine');
end