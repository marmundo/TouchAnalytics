function [deg_list,nradius] = DET2polar(FAR,FRR,deg_list,min_res,toplot)
if (nargin<3 | length(deg_list)==0)
  deg_list = [0:90];
end;
if (nargin<4 | length(min_res)==0)
  min_res = [0.00001 0.00001];
end;
if (nargin<5 | length(toplot)==0)
  toplot=0;
end;

mydat = [FAR FRR];

if min(sum([FAR FRR]'))==0,
  nradius = zeros(1,length(deg_list));
  valid_deg = [];
  return;
end;

%ensure that we consider the range within minimum resolutions
%and not outside it!
%index1 = find(mydat(:,1) < min_res(1)+eps | mydat(:,1) > 1-min_res(1)-eps);
%index2 = find(mydat(:,2) < min_res(2)+eps | mydat(:,2) > 1-min_res(2)-eps);
%mydat(union(index1, index2),:)=[];
%replace FAR=0 and FRR=0 with the minimal resolution (min_res)

%mydat= [1-min_res(1) min_res(2); mydat; min_res(1) 1-min_res(2)];

%if 1==0,
  last = min(find(mydat(:,1)==0));
  first = max(find(mydat(:,2)==0));
  if length(first) ==0,
    first = max(find(mydat(:,1)==1));
    mydat(first,1)=1-min_res(1);
  else
    mydat(first,2)=min_res(2);
  end;
  if last ==length(mydat),
    last = min(find(mydat(:,2)==1));
    mydat(last,2)=1-min_res(2);
    if mydat(last,1)==0,
      mydat(last,1)=min_res(1);
    end;
  else
    mydat(last,1)=min_res(1);
  end
  
  if (length(first)==0),
    first=1;
  end;
  if (length(last)==0),
    last=length(mydat);
  end;

  selected=first:last;
  nFAR = mydat(selected,1);
  nFRR = mydat(selected,2);
%end;

nFAR = mydat(:,1);
nFRR = mydat(:,2);
%take norminv
mydat=[norminv(nFAR),norminv(nFRR)];

%interpolate the first and last two elements -- where data is scarce
selected=1:2;
for i=1:2,
  list_FAR(:,i)= linspace(mydat(selected(1),i),mydat(selected(2),i),20);
end;
selected=[size(mydat,1)-1 size(mydat,1)];
for i=1:2,
  list_FRR(:,i)= linspace(mydat(selected(1),i),mydat(selected(2),i),20);
end;

if length(mydat)==3
  mydat_ = [list_FAR; list_FRR(2:end,:)];
  label=[ones(length(mydat_),1)]; %all are interpolated data except
                                  %three points
  label(1)=0;
  label(length(list_FAR))=0;
  label(end)=0;
elseif (length(mydat)==2),
  mydat_ = [list_FAR];
  label=[ones(length(mydat_),1)]; %all are interpolated data except
                                  %the first and last points
  label(1)=0;
  label(end)=0;
else
  tmp=mydat(3:end-2,:);
  mydat_ = [list_FAR; tmp; list_FRR];
  label=[0; ones(length(list_FAR)-2,1);0;
	 zeros(length(tmp),1);
	 0;ones(length(list_FRR)-2,1);0];
end;

%debugging...
if 1==0,
  cla;
  plot(mydat_(:,1),mydat_(:,2),'+')
  hold on;
  plot(mydat_(find(label==1),1),mydat_(find(label==1),2),'ro')
end;

%convert to angle
%first move to the origin
ndat = [mydat_(:,1) - norminv(min_res(1)), mydat_(:,2) - norminv(min_res(2))];

%compute angle by avoiding division with zero
angle = zeros(length(ndat),1);
selected = find(ndat(:,1)==0);
angle(selected) = Inf;
selected = setdiff(1:length(ndat),selected);
angle(selected) = atan(ndat(selected,2)./ ndat(selected,1));

%in terms of radius and degree
radius = sqrt(ndat(:,1).^2 + ndat(:,2) .^ 2);
deg = angle / (2*pi) * 360;

%filter away bad data
chosen_ = find(isnan(deg) | isinf(deg) |isinf(radius) | deg<0);
deg(chosen_) = [];
radius(chosen_) = [];

%avoid duplicates:
dup_= find(diff(deg)==0);
deg(dup_) = [];
radius(dup_) = [];

nradius = interp1(deg,radius,deg_list, 'linear');

%find radius whose data is interpolated, i.e., not exist in real data
% if length(mydat)==3,
%   valid_deg = round(deg(find(label==0)));
% elseif length(mydat)==2,  
%   valid_deg = round(deg([1,end]));
% else
%   tmp=diff(label); %gives 1,0...-1,0...,1,0...,-1
%   tmp_= find(tmp==-1);
%   marker(1) = tmp_(1);
%   tmp_= find(tmp==1);
%   marker(2) = tmp_(2);
%   valid_deg = [1 floor(deg(marker(1))):round(deg(marker(2))) length(deg)];
% end;

if (toplot),
  cla; hold on;
  plot(deg,radius,'o-');
  plot(deg_list,nradius,'r*-');
end;
