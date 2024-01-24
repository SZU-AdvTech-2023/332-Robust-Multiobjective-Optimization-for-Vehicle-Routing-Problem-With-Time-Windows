function r = greedydecoder(par,lb,ub,demand,cost,dist,cap,dist0)
%UNTITLED5 此处显示有关此函数的摘要
%   此处显示详细说明
  [~,toinsert]=sort(par);
  r=[0];
  k=5;
  time=0;
  load=0;
  while (length(toinsert)~=0)
    flag=false;
    if length(toinsert)<k
        k=length(toinsert);
    end
    for i=1:k
        if r(length(r))==0
           if (dist0(toinsert(i))<ub(toinsert(i)))
               time=max(dist0(toinsert(i)),lb(toinsert(i)))+cost(toinsert(i));
               load=load+demand(toinsert(i));
                r=[r,toinsert(i)];
                toinsert(i)=[];
                flag=true;
                break;
           end
        else 
          if (time+dist(r(length(r)),toinsert(i))<ub(toinsert(i))) && (load+demand(toinsert(i))<cap)
              time=max(lb(toinsert(i)),time+dist(r(length(r)),toinsert(i)))+cost(toinsert(i));
              load=load+demand(toinsert(i));
              r=[r,toinsert(i)];
              toinsert(i)=[];
              flag=true;
              break;
          end
        end
    end
    if flag==false
        r=[r,0];
        time=0;
        load=0;
    end
  end
end

