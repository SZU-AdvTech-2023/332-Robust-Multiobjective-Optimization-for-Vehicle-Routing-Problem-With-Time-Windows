function [ rep,rf1,rf2,rrob,rs] = updaterep(r,f11,f22,rob1,rsurvt,route,f1,f2,robust,survt,n)
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
  bedo=zeros(1,n);
  for i=1:n
     for j=1:n
        if i==j
            continue
        end
        if (f1(i)<=f1(j)) && (f2(i)<=f2(j)) 
            if (f1(i)<f1(j)) || (f2(i)<f2(j))
                bedo(j)=bedo(j)+1;
            end
        end
     end
  end
  index=find(bedo==0);
  route=route(index);
  f1=f1(index);
  f2=f2(index);
  robust=robust(index);
  survt=survt(index);
  bedo=zeros(1,length(r));
  be1=zeros(1,length(f1));
  for i=1:length(r)
      for j=1:length(f1)
          if (f1(j)<=f11(i)) && (f2(j)<=f22(i))
              if (f1(j)<f11(i)) || (f2(j)<f22(i))
                  bedo(i)=1;
              end
          end
          if (f11(i)<=f1(j)) && (f22(i)<=f2(j))
              if (f11(i)<f1(j)) || (f22(i)<f2(j))
                  be1(j)=1;
              end
          end
      end
  end
  index=find(bedo==0);
  r=r(index);
  f11=f11(index);
  f22=f22(index);
  rob1=rob1(index);
  rsurvt=rsurvt(index);
  index=find(be1==0);
  route=route(index);
  f1=f1(index);
  f2=f2(index);
  robust=robust(index);
  survt=survt(index);
  r=[r,route];
  f11=[f11,f1];
  f22=[f22,f2];
  rob1=[rob1,robust];
  rsurvt=[rsurvt,survt];
  if length(r)>n
      [~,index]=sort(rob1);
      rob1=rob1(index(1:n));
      f11=f11(index(1:n));
      f22=f22(index(1:n));
      r=r(index(1:n));
      rsurvt=rsurvt(index(1:n));
  end
  rep=r;rf1=f11;rf2=f22;rrob=rob1;rs=rsurvt;
end

