function printDETCurve(wolves, sheep, quantLines,legenda)
% wolves= impostor scores
% sheep= client scores
% quantLines = quantity of DET Curves. 'This input must have the same number
% of columns of wolves and sheep
% legenda= legend used to represent the curves

if quantLines~=length(wolves(1,:)) && quantLines~=length(sheep(1,:)) && length(legenda)~=length(wolves(1,:)) && length(legenda)~=length(sheep(1,:))
    warning('quantLines and legend must have the same number of columns of wolves and sheep');
    return;
end
addpath('lib')
for hold=1:quantLines
    wer(wolves(:,hold),sheep(:,hold), [],2,[],hold);
end
legend(legenda,'Location','southwest');
end