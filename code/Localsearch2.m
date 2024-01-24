function [ route ] = Localsearch2( route,n,dist0,dist,lb,ub,cost,demand)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
  path={};
  r=0;  robu=[];  plen=[];  len=0;  temp=0;  time=0;
  for i=2:n
      if route(i)~=0
          r=[r,route(i)];
          len=len+1;
          if route(i-1)==0
              temp=temp+abs(mean(lb+ub)-time+dist0(route(i)));
              time=max(time+dist0(route(i)),lb(route(i)))+cost(route(i));
          else
            temp=temp+abs(mean(lb+ub)-time+dist(route(i),route(i-1)));
            time=max(time+dist(route(i),route(i-1)),lb(route(i)))+cost(route(i));
          end
      else
          r=[r,0];
          path=[path;r];
          robu=[robu,temp];
          plen=[plen,len];
          temp=0;
          time=0;
          r=0;
          len=0;
      end
  end
  m=length(plen);
  k=min(plen);
  index=find(plen==k);
  [~,toin]=sort(robu);
  setdiff(toin,index);
  posi=[];
  ins=0;
  lasting=[1 2 3];
  toremove=index;
   for i=1:length(toremove)
       change=0;
       ins=0;
       test=path{toremove(i)};
       for j=1:length(test)
         record=[0 0 0];
         if test(j)==0
             continue;
         end
         for l=1:min(length(toin),3)
           tempr={};
           temp=path{toin(l)};
           posi(l)=toin(l);
           for u=1:length(temp)-1
             if judger([temp(u),test(j),temp(u+1:length(temp))],lb,ub,dist,dist0,cost,demand)==1
                 ins=ins+1;
                 temp=[temp(u),test(j),temp(u+1:length(temp))]
                 tempr=[tempr,temp];
                 change=1;
                 record(l)=1;
                 break;
             end
           end
            if change==1
                break;
            end
         end
       end
         if ins==length(test)
             feasi=1;
             for j=1:3
                 if record(j)==1
                     if calrob(path{toin(j)},lb,ub,dist0,dist,cost)>robu(toin(j))
                       feasi=0;
                       break;
                     end
                 end
             end
             if feasi==1
                 for j=1:3
                     if record(j)==1
                       path(toin(j))=tempr(j);
                     end
                 end
               path{toremove(i)}=lasting;
             end
   end
   end
  for i=1:length(toremove)
      if path{toremove(i)}(1)==1
          path(toremove(i))=[];
      end
  end
  r=[];
  for i=1:length(path)
      t=path{i};
      for j=1:length(t)
        r=[r,t(j)];
      end
  end
  route=r;
end

