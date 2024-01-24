function robust = calrob(route,lb,ub,dist0,dist,cost)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
  time=0;
  robust=0;
  for i=2:length(route)
      if route(i)==0
          time=0
          continue;
      end
      if route(i-1)==0
          robust=robust+abs(time+dist0(route(i))-(lb(route(i))+ub(route(i)))/2);
          time=max(time+dist0(route(i)),lb(route(i)))+cost(route(i));
      else
          robust=robust+abs(time+dist(route(i),route(i-1))-(lb(route(i))+ub(route(i)))/2);
          time=max(time+dist(route(i-1),route(i)),lb(route(i)))+cost(route(i));
      end
  end
end

