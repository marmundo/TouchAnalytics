function printDETCurve(wolves, sheep, quantLines)
% wolves= impostor scores
% sheep= client scores
% quantLines = quantity of DET Curves. 'This input must have the same number
% of columns of wolves and sheep

if quantLines~=length(wolves(1,:)) && quantLines~=length(sheep(1,:))
    warning('quantLines must have the same number of columns of wolves and sheep');
    return;
end
addpath('lib')
for hold=1:quantLines
    wer(wolves(:,hold),sheep(:,hold), [],2,[],hold);
end
end