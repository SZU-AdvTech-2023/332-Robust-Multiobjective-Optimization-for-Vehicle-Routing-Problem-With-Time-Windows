function survt = montecarlo(route,dist,distb,lb,ub,demand,cap,cost,n,dist0)
%UNTITLED6 此处显示有关此函数的摘要
  maxsim=50;
  survt=0;
  for t=1:maxsim
      feas=1;
      time=0;
      de1=0;
      ran=floor(rand(1)*n*0.2);
      temp=dist;
      for i=1:ran
          l1=floor(rand(1)*n);
          l1=max(l1,1);
          l2=floor(rand(1)*n);
          l2=max(l2,1);
          dist(l1,l2)=dist(l1,l2)+rand(1)*2*distb-distb;
      end
      for i = 2:length(route)
          if route(i)==0
              time=0;
              de1=0;
          else
              if (route(i-1)==0)
                  if (de1+demand(route(i))<=cap) && (time+dist0(route(i))<=ub(route(i)))
                      time=max(time+dist0(route(i)),lb(route(i)))+cost(route(i));
                      de1=de1+demand(route(i));
                  else
                      feas=0;
                      break;
                  end
              else
                if (de1+demand(route(i))<=cap) && (time+dist(route(i),route(i-1))<=ub(route(i)))
                    time=max(time+dist(route(i),route(i-1)),lb(route(i)))+cost(route(i));
                    de1=de1+demand(route(i));
                else
                    feas=0;
                    break;
                end
            end
      end
      dist=temp;
      end
        if feas==0
          break;
      else
          survt=survt+1;
      end
  end
end

