function [biometricData, userLabels]=discretizeUser(user,userIndex,biometricData)
%discretizeUser discretize the user to 1 and the remaining users in the
%biometricData to 0
%user= user label
%user Index= position of user label in the data
%biometricData=biometric data
if ischar(user)
    user=str2double(user);
end
 %% Changing the label of User to positive
 userLabels=cell(length(biometricData(:,userIndex)),1);
 userLabels(biometricData(:,userIndex)==user)={'client'};



 %% Changing the label of the remaining users to impostor
 userLabels(biometricData(:,userIndex)~=user)={'impostor'};
 
 % Deleting the userLabels
 biometricData=biometricData(:,2:end);
end