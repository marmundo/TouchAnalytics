function printDETCurve(wolves, sheep, quantLines)
addpath('lib')
for hold=1:quantLines
    wer(wolves(:,hold),sheep(:,hold), [],2,[],hold);
end
legend('Original','Same Key','Different Key');
end