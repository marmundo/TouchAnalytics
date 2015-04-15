%% I use this file to create prototypes of scriopt or to call some functionalities of my
%% matlab code


%% This script loads the all the cancelable biometric data for all users using all the keys types in
%% scrolling and horizontal stroke directions.

cancelableFunctions=char('Interpolation','DoubleSum','BioHashing','BioConvolving');

classifiers={'knn','svm','discriminant'};

% strokeOrientation=char('Scrolling','Horizontal');
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

%main(10,'knn',1,'Interpolation','Same_Key','Scrolling')

%% Show a Norman's plot for all user using a specific orientation, keytype and biometric data


% for i=1:4
%     for j=2:3
%         main(11,classifiers(j),'',cancelableFunctions(i,:),'Different_Key','Scrolling')
%         main(11,classifiers(j),'',cancelableFunctions(i,:),'Different_Key','Horizontal')
%         main(11,classifiers(j),'',cancelableFunctions(i,:),'Same_Key','Scrolling')
%         main(11,classifiers(j),'',cancelableFunctions(i,:),'Same_Key','Horizontal')
%     end
% end

%main(11,'knn','','DoubleSum','Different_Key','Horizontal')
%%main(11,'knn','','DoubleSum','Same_Key','Horizontal')

%Ploting the scores of a user using a specific cancelable function,
%orientation, key type and user
%main(12,'knn',1,'BioHashing','Same_Key','Scrolling')

%Ploting the scores of a user using a specific cancelable function,
%orientation, key type and user
%main(13,'knn','','BioHashing','Different_Key','Horizontal')
%main(13,'knn','','BioHashing','Same_Key','Horizontal')


%main(13,'knn','','BioHashing','Different_Key','Scrolling')
%main(13,'knn','','BioHashing','Same_Key','Scrolling')

%main(10,'svm',1,'BioConvolving','Different_Key','Horizontal')

main(14,'knn',1,cancelableFunctions(i,:),'Different_Key','Scrolling')
