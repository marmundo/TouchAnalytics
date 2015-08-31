xlabel={'Interpolation','BioHashing','BioConvolving','DoubleSum'}
ylabel={'Homogeneous','Heterogeneous'}

%% Known_Key_Attack Statistical Test
%y_horizontal_label={'Heterogeneous','Heterogeneous','Homogeneous','Homogeneous'}
%y_scrolling_label={'Homogeneous','Heterogeneous','Homogeneous','Homogeneous'}
plot(1:4,[2,2,1,1;],'-.ob');
title('Known Key Attack Statistical Test')
hold on
plot(1:4,[1,2,1,1],':sr');
hold off
set(gca, 'XTick', 1:4, 'XTickLabel', xlabel);
set(gca, 'YTick', 1:2, 'YTickLabel', ylabel);
legend('Horizontal','Scrolling')
file=['Pictures/StatisticalTest/Known_Key_Attack_Statistical_Test.png'];
print('-dpng',file);
%close

%% UnKnown_Key_Attack Statistical Test
plot(1:4,[1,2,2,1;],'-.ob');
title('UnKnown Key Attack Statistical Test')
hold on
plot(1:4,[1,1,2,1],':sr');
hold off
set(gca, 'XTick', 1:4, 'XTickLabel', xlabel);
set(gca, 'YTick', 1:2, 'YTickLabel', ylabel);
legend('Horizontal','Scrolling')
file=['Pictures/StatisticalTest/UnKnown_Key_Attack_Statistical_Test.png'];
print('-dpng',file);

%%
%%Pie Chart
ylabel={'Homogeneous: ','Heterogeneous: '}
pieChart=pie([5/8,3/8])%,categories(Known_key))
title('Known Key Attack Statistical Test')
%Changing label text
hText = findobj(pieChart,'Type','text'); % text object handles
percentValues = get(hText,'String'); % strings
combinedstrings = strcat(ylabel',percentValues); % strings and percent values
oldExtents_cell = get(hText,'Extent');  % cell array
oldExtents = cell2mat(oldExtents_cell); % numeric array
set(hText,{'String'},combinedstrings);

%Changing label position
newExtents_cell = get(hText,'Extent'); % cell array
newExtents = cell2mat(newExtents_cell); % numeric array
width_change = newExtents(:,3)-oldExtents(:,3);
signValues = sign(oldExtents(:,1));
offset = signValues.*(width_change/2);
textPositions_cell = get(hText,{'Position'}); % cell array
textPositions = cell2mat(textPositions_cell); % numeric array
textPositions(:,1) = textPositions(:,1) + offset; % add offset

set(hText,{'Position'},num2cell(textPositions,[3,2])) % set new position
file=['Pictures/StatisticalTest/Known_Key_Attack_Statistical_Test_Pie.png'];
print('-dpng',file);

%%Pie Chart Unknown
ylabel={'Homogeneous: ','Heterogeneous: '}
pieChart=pie([5/8,3/8])%,categories(Known_key))
title('UnKnown Key Attack Statistical Test')
%Changing label text
hText = findobj(pieChart,'Type','text'); % text object handles
percentValues = get(hText,'String'); % strings
combinedstrings = strcat(ylabel',percentValues); % strings and percent values
oldExtents_cell = get(hText,'Extent');  % cell array
oldExtents = cell2mat(oldExtents_cell); % numeric array
set(hText,{'String'},combinedstrings);

%Changing label position
newExtents_cell = get(hText,'Extent'); % cell array
newExtents = cell2mat(newExtents_cell); % numeric array
width_change = newExtents(:,3)-oldExtents(:,3);
signValues = sign(oldExtents(:,1));
offset = signValues.*(width_change/2);
textPositions_cell = get(hText,{'Position'}); % cell array
textPositions = cell2mat(textPositions_cell); % numeric array
textPositions(:,1) = textPositions(:,1) + offset; % add offset

set(hText,{'Position'},num2cell(textPositions,[3,2])) % set new position
file=['Pictures/StatisticalTest/UnKnown_Key_Attack_Statistical_Test_Pie.png'];
print('-dpng',file);

%%Pie Chart Unknown
ylabel={'Homogeneous: ','Heterogeneous: '}
pieChart=pie([10/16,6/16])%,categories(Known_key))
title('Proportion to Both Key Attack - Statistical Test')
%Changing label text
hText = findobj(pieChart,'Type','text'); % text object handles
percentValues = get(hText,'String'); % strings
combinedstrings = strcat(ylabel',percentValues); % strings and percent values
oldExtents_cell = get(hText,'Extent');  % cell array
oldExtents = cell2mat(oldExtents_cell); % numeric array
set(hText,{'String'},combinedstrings);

%Changing label position
newExtents_cell = get(hText,'Extent'); % cell array
newExtents = cell2mat(newExtents_cell); % numeric array
width_change = newExtents(:,3)-oldExtents(:,3);
signValues = sign(oldExtents(:,1));
offset = signValues.*(width_change/2);
textPositions_cell = get(hText,{'Position'}); % cell array
textPositions = cell2mat(textPositions_cell); % numeric array
textPositions(:,1) = textPositions(:,1) + offset; % add offset

set(hText,{'Position'},num2cell(textPositions,[3,2])) % set new position
file=['Pictures/StatisticalTest/Key_Attack_Statistical_Test_Pie.png'];
print('-dpng',file);