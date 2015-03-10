%% scrolling extration
clear scrolling;

scrolling = [];

v=[1,2,3,6];
for i=1:length(v)
	scrolling=[scrolling;featMat(find(featMat(:,2) == v(i)),:)];
end

%% horizontal extraction

clear horizontal;

horizontal = [];

v=[4,5,7];
for i=1:length(v)
	horizontal=[horizontal;featMat(find(featMat(:,2) == v(i)),:)];
end

%removing phone id
scrolling(:,13)=[];
horizontal(:,13)=[];

%removing doc id
scrolling(:,2)=[];
horizontal(:,2)=[];

%saving scrooling data in a file
save('scrolling data.mat','scrolling');

%saving horizontal data in a file
save('horizontal data.mat','horizontal');
