function [c,g]=grid(trainUserLabels, trainingDataSet)
bestcv = 0;
for log2c = -1:3,
  for log2g = -4:1,
    cmd = ['-v 3 -c ', num2str(2^log2c), ' -g ', num2str(2^log2g)];
    cv = svmtrain(trainUserLabels,trainingDataSet,cmd);
    if (cv >= bestcv),
      bestcv = cv; bestc = 2^log2c; bestg = 2^log2g;
    end
    fprintf('%g %g %g (best c=%g, g=%g, rate=%g)\n', log2c, log2g, cv, bestc, bestg, bestcv);
  end
end
c=bestc;
g=bestg;