function offspring = Localsearch1(pop,n,ub)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
  m=floor(rand(1)*n)
  a=rand(1,m);
  list=floor(a.*n);
  list=max(list,1);
  maxi=max(ub);
  avg=mean(ub);
  mini=min(ub);
  for i=1:m
      delta=((ub(list(i))-mini)/(maxi-mini))-((avg-mini)/(maxi-mini));
      pop(list(i))=pop(list(i))+delta;
      pop(list(i))=max(pop(list(i)),0);
      pop(list(i))=min(pop(list(i)),1);
  end
  offspring=pop;
end

