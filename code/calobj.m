function [ f1,f2 ] = calobj(route,dist0,dist)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
  f2=0;
   f1=length(find(route==0))-1;
   for j=2:length(route)
       if route(j)==0
           f2=f2+dist0(route(j-1));
       else
           if route(j-1)==0
               f2=f2+dist0(route(j));
           else
               f2=f2+dist(route(j),route(j-1));
           end
       end
   end

end

