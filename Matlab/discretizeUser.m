function biometricData=discretizeUser(user,userIndex,biometricData)
%discretizeUser discretize the user to 1 and the remaining users in the
%biometricData to 0
%user= user label
%user Index= position of user label in the data
%biometricData=biometric data
if ischar(user)
    user=str2num(user)
end
 %% Changing the label of User to positive
 userLines=find(biometricData(:,userIndex)==user);
 biometricData(userLines,userIndex)='client';

 %% Changing the label of the remaining users to impostor
 userLines=find(biometricData(:,userIndex)~=user);
 biometricData(userLines,userIndex)='impostor';
end