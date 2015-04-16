%% I use this file to create prototypes of scriopt or to call some functionalities of my
%% matlab code


%% This script loads the all the cancelable biometric data for all users using all the keys types in
%% scrolling and horizontal stroke directions.

 cancelableFunctions=char('Interpolation','DoubleSum','BioHashing','BioConvolving');
 strokeOrientation=char('Scrolling','Horizontal');
 classifiers={'knn','svm','libsvm','discriminant'};
% key=char('Same_Key','Different_Key');
% 
%  
% for keyIndex=1:length(key)
%     for orienIndex=1:length(strokeOrientation)
%         for cancIndex=1:length(cancelableFunctions)
%             for user=1:41
%                 % Loading training data
%                 load(strcat(pwd(),'/Data/', strokeOrientation(orienIndex,:),'/',cancelableFunctions(cancIndex,:),'/',key(keyIndex,:),'/User_',num2str(user),'/trainingSet.mat'),'trainingSet','trainUserLabels');
%                 
%                 % Loading testData
%                 load(strcat(pwd(),'/Data/', strokeOrientation(orienIndex,:),'/',cancelableFunctions(cancIndex,:),'/',key(keyIndex,:),'/User_',num2str(user),'/testSet.mat'),'testSet','testUserLabels');
%                 
%             end
%         end
%     end
% end

%% Creates all the cancelable data

%for i=2:9
%    main(i)
%end

%% Show a Norman's plot for a specific user using a specific orientation, keytype and biometric data

%main(10,'svm',1,'Interpolation','Same_Key','Scrolling')

%% Show a Norman's plot for all users using a all orientation, keytype and biometric data
% for i=2:length(classifiers)
%     for j=1:length(cancelableFunctions)        
%         %main(11,classifiers{i},'',cancelableFunctions(j,:),'Same_Key','Scrolling')
%        % main(11,classifiers{i},'',cancelableFunctions(j,:),'Same_Key','Horizontal')
%         
%         main(11,classifiers{i},'',cancelableFunctions(j,:),'Different_Key','Scrolling')
%         main(11,classifiers{i},'',cancelableFunctions(j,:),'Different_Key','Horizontal')
%     end
% end
for user=41:41
 main(10,'svm',user,'Interpolation','Different_Key','Scrolling')
end