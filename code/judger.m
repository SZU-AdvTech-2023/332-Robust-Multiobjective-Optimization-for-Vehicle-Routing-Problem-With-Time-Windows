function feas = judger( route,lb,ub,dist,dist0,cost,demand )
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
     feas=1;
     cap=200;
     time=0;de1=0;
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
      end
end

