function data=discretizeUser(user,userIndex,data)
if ischar(user)
    user=str2num(user)
end
 %% Changing the label of User to positive
        userLines=find(data(:,userIndex)==user);
        data(userLines,userIndex)=1;

        %% Changing the label of the remaining users to impostor
        userLines=find(data(:,userIndex)~=user);
        data(userLines,userIndex)=0;
end