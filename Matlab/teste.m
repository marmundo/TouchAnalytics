%% I use this file to create prototypes of scriopt or to call some functionalities of my
%% matlab code


%% This script loads the all the cancelable biometric data for all users using all the keys types in
%% scrolling and horizontal stroke directions.


 cancelableFunctions={'Original','Interpolation','DoubleSum','BioHashing','BioConvolving'};
 strokeOrientation={'Scrolling','Horizontal'};
 classifiers={'knn','libsvm','svm','discriminant','regression'};
 keySize=[0.25,0.5,0.75,1];
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

%   for i=17:17
%      main(i,'','','','','',1)
%   end



%% Show a Norman's plot for a specific user using a specific orientation, keytype and biometric data

% for i=2:2%length(classifiers)
%     for j=2:length(cancelableFunctions)
%         main(24,classifiers{i},'',cancelableFunctions{j},'Homo_Key','Scrolling',1)
%         main(24,classifiers{i},'',cancelableFunctions{j},'Homo_Un_Key','Scrolling',1)
%         main(24,classifiers{i},'',cancelableFunctions{j},'Hete_Key','Scrolling',1)
%         main(24,classifiers{i},'',cancelableFunctions{j},'Hete_Un_Key','Scrolling',1)
%         
%         main(24,classifiers{i},'',cancelableFunctions{j},'Homo_Key','Horizontal',1)
%         main(24,classifiers{i},'',cancelableFunctions{j},'Homo_Un_Key','Horizontal',1)
%         main(24,classifiers{i},'',cancelableFunctions{j},'Hete_Key','Horizontal',1)
%         main(24,classifiers{i},'',cancelableFunctions{j},'Hete_Un_Key','Horizontal',1)
%     end
% end
% 
% 
% for i=1:1%length(classifiers)
%     for j=4:length(cancelableFunctions)
%        main(19,classifiers{i},'',cancelableFunctions{j},'Homo_Key','Scrolling',1)
%        main(19,classifiers{i},'',cancelableFunctions{j},'Homo_Un_Key','Scrolling',1)
%         main(19,classifiers{i},'',cancelableFunctions{j},'Hete_Key','Scrolling',1)
%         main(19,classifiers{i},'',cancelableFunctions{j},'Hete_Un_Key','Scrolling',1)
%         
%         main(19,classifiers{i},'',cancelableFunctions{j},'Homo_Key','Horizontal',1)
%         main(19,classifiers{i},'',cancelableFunctions{j},'Homo_Un_Key','Horizontal',1)
%         main(19,classifiers{i},'',cancelableFunctions{j},'Hete_Key','Horizontal',1)
%         main(19,classifiers{i},'',cancelableFunctions{j},'Hete_Un_Key','Horizontal',1)
%     end
% end
%main(11,'knn','','DoubleSum','Different_Key','Horizontal')
%main(11,'knn','','BioHashing','Same_Key','Horizontal');
%main(11,'knn','','BioHashing','Same_Key','Scrolling');
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

%main(2)

%main(10,'svm',1,'Interpolation','Same_Key','Scrolling')

% Show a Norman's plot for all users using a all orientation, keytype and biometric data
% for i=5:5%length(classifiers)
%     for j=1:length(cancelableFunctions)        
%         main(11,classifiers{i},'',cancelableFunctions{j},'Same_Key','Scrolling',1)
%         main(11,classifiers{i},'',cancelableFunctions{j},'Same_Key','Horizontal',1)
%         
%         main(11,classifiers{i},'',cancelableFunctions{j},'Different_Key','Scrolling',1)
%         main(11,classifiers{i},'',cancelableFunctions{j},'Different_Key','Horizontal',1)
%     end
% end
% for i=3:3%length(classifiers)
%      for j=2:length(cancelableFunctions) 
%         main(16,classifiers{i},'',cancelableFunctions{j},'','Scrolling',keySize(4))
%         main(16,classifiers{i},'',cancelableFunctions{j},'','Horizontal',keySize(4))
%      end
% end
% for k=1:length(keySize)
% for i=1:1
%     for j=1:length(cancelableFunctions)        
%         main(11,classifiers{i},'',cancelableFunctions{j},'Same_Key','Scrolling',keySize(k));
%         main(11,classifiers{i},'',cancelableFunctions{j},'Same_Key','Horizontal',keySize(k));
%         
%         main(11,classifiers{i},'',cancelableFunctions{j},'Different_Key','Scrolling',keySize(k));
%         main(11,classifiers{i},'',cancelableFunctions{j},'Different_Key','Horizontal',keySize(k));
%     end
% end
% end

% for i=2:length(cancelableFunctions)  
% main(24,'libsvm','',cancelableFunctions{i},'','Scrolling',1)
% main(24,'libsvm','',cancelableFunctions{i},'','Horizontal',1)
% end

% for i=2:length(cancelableFunctions)  
% main(25,'libsvm','',cancelableFunctions{i},'','Scrolling',1)
% main(25,'libsvm','',cancelableFunctions{i},'','Horizontal',1)
% end

keyType={'Hete_Key','Hete_Un_Key','Homo_Key','Homo_Un_Key'};
for i=1:length(keyType)  
main(26,'libsvm','','',keyType{i},'Scrolling',1)
main(26,'libsvm','','',keyType{i},'Horizontal',1)
end