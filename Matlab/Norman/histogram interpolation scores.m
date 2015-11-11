histogram(unprotected.scores{1,5})
hold on
histogram(unprotected.scores{2,5})
title('Unprotected')

figure(2)
histogram(inter_baseline.scores{1,5})
hold on
histogram(inter_baseline.scores{2,5})
title('Interpolation standard length')

figure(3)
histogram(inter_small.scores{1,5})
hold on
histogram(inter_small.scores{2,5})
title('Interpolation small length')

figure(4)
histogram(inter_medium.scores{1,5})
hold on
histogram(inter_medium.scores{2,5})
title('Interpolation medium length')

figure(5)
histogram(inter_big.scores{1,5})
hold on
histogram(inter_big.scores{2,5})
title('Interpolation big length')