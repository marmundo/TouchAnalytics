function [FAR,FRR] = polar2DET(radius,deg_list,min_res)
if (nargin<2 | length(deg_list)==0)
  deg_list = [0:90];
end;
if (nargin<3 | length(min_res)==0)
  min_res = [0.00001 0.00001];
end;

dat_ = [ (radius .* (cos(deg_list/360*2*pi)))', (radius .* (sin(deg_list/360*2*pi)))'];
mydat = [dat_(:,1)+norminv(min_res(1)),dat_(:,2)+norminv(min_res(2))];

FAR=mydat(:,1);
FRR=mydat(:,2);