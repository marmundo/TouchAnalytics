%% Scrolling

homo_k_scrolling=[0.1340,0.1457,0.1553,0.2104]
hete_k_scrolling=[0.1423,0.1494,0.1460,0.2120]
plot(homo_k_scrolling,hete_k_scrolling,'*r')
xlabel('Homogeneous')
ylabel('Heterogeneous')
title('EER by Key Type Experiments using Scrolling Strokes')
hold on
homo_uk_scrolling=[0.0573,0.0647,0.0686,0.1471]
hete_uk_scrolling=[0.0637,0.0677,0.0707,0.1393]
plot(homo_uk_scrolling,hete_uk_scrolling,'*k')

plot(0.1310,0.1310,'o')
legend('Known Key','Unknow Key','Baseline')
x=[0:.01:0.25]
y=x
plot(x,y)

hold off

%% Horizontal

homo_k_horizontal=[0.1460,0.1480,0.1572,0.1661]
hete_k_horizontal=[0.1248,0.1499,0.1487,0.1814]
plot(homo_k_horizontal,hete_k_horizontal,'*r')
xlabel('Homogeneous')
ylabel('Heterogeneous')
title('EER by Key Type Experiments using Horizontal Strokes')
hold on

homo_uk_horizontal=[0.0391,0.0568,0.0774,0.1207]
hete_uk_horizontal=[0.0435,0.0632,0.0700,0.1154]
plot(homo_uk_horizontal,hete_uk_horizontal,'*k')
plot(0.1345,0.1345,'o')
legend('Known Key','Unknow Key','Baseline')
x=[0:.01:0.25]
y=x
plot(x,y)

hold off

