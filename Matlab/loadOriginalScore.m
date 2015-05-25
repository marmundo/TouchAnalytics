function [ allClientScore,allImpostorScore]=loadOriginalScore(keySize,classifierName,orientation)
allClientScore=[];
allImpostorScore=[];
scoreMatrixPath=[pwd(),'/ScoreMatrix/',num2str(keySize),'/',classifierName,'/',orientation,'/Original/Homo_Key'];
for user=1:41
    % Loading score matrix
    saveFilePath=scoreMatrixPath;
    load(strcat(saveFilePath,'/Score_User_',num2str(user),'.mat'),'clientScore','impostorScore');
    
    %storing the score to plot
    allClientScore=[allClientScore;clientScore];
    allImpostorScore=[allImpostorScore;impostorScore];
end
end