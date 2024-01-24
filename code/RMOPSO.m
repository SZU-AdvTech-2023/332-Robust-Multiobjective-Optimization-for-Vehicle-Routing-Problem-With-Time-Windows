load('r1_type.mat');
data=r10425;
customersize=25;
popsize=50;
capacity=200;
vnum=25;
rep={};
distb=1;
particle=rand(popsize,customersize);
vel=rand(popsize,customersize)*2-1;
dex=35;dey=35;
locx=data(:,2);locy=data(:,3);demand=data(:,4);lb=data(:,5);ub=data(:,6);cost=data(:,7);
dist=zeros(customersize,customersize);
dist0=sqrt((locy-dey).^2+(locx-dex).^2);
for i=1:customersize
    for j=i+1:customersize
        dist(i,j)=sqrt((locy(i)-locy(j))^2+(locx(i)-locx(j))^2);
        dist(j,i)=dist(i,j);
    end
end
iteration=200;
f2=zeros(0,popsize);
route={};
survive=zeros(0,popsize);
for i=1:popsize
  route{i}=greedydecoder(particle(i,:),lb,ub,demand,cost,dist,capacity,dist0);
  [f1(i),f2(i)]=calobj(route{i},dist0,dist)
  robust(i)=calrob(route{i},lb,ub,dist0,dist,cost);
end
for i=1:popsize
  fitness(i)=(f1(i))/customersize+(f2(i)-min(f2))/(max(f2)-min(f2))+(robust(i)-min(robust))/(max(robust)-min(robust)); 
end
w=1;
c1=2;
c2=2;
fitpb=fitness;
pbest=particle;
prob=robust;pf1=f1;pf2=f2;
[fitg,posi]=min(fitness);
gbest=particle(posi,:);gf1=f1(posi);gf2=f2(posi); 
rep=[];
rf1=[];rf2=[];rrob=[];rsurvt=[];
for t=1:iteration
    for i=1:popsize
        temp=particle(i,:);
        vel(i,:)=w*vel(i,:)+rand(1)*c1*(pbest(i,:)-particle(i,:))+rand(1)*c2*(gbest-particle(i,:));
        particle(i,:)=particle(i,:)+vel(i,:);
        te1=f1(i);te2=f2(i);
        route{i}=greedydecoder(particle(i,:),lb,ub,demand,cost,dist,capacity,dist0);
        survive(i)=montecarlo(route{i},dist,distb,lb,ub,demand,capacity,cost,customersize,dist0);
        [f1(i),f2(i)]=calobj(route{i},dist0,dist);
        if (rand(1)>(survive(i)/50)) 
           particle(i,:)=temp;
           f1(i)=te1;f2(i)=te2;
           continue;
        end
        robust(i)=calrob(route{i},lb,ub,dist0,dist,cost);
        fitness(i)=(f1(i))/customersize+(f2(i)-min(f2))/(max(f2)-min(f2))+(robust(i)-min(robust))/(max(robust)-min(robust)); 
    %   dominate=0;
    %   if (f1(i)<=pf1(i)) && ((f2(i)<=pf2(i)))
    %        if (f1(i)<pf1(i)) || (f2(i)<pf2(i))
     %           dominate=1;
    %        end
     %   end
        if fitness(i)<fitpb(i)
            pbest(i,:)=particle(i,:);
            prob(i)=robust(i);
            fitpb(i)=fitness(i);
            pf1(i)=f1(i);
            pf2(i)=f2(i);
        else
            if (rand(1)<0.7) && (robust(i)<prob(i))
               pbest(i,:)=particle(i,:);
               prob(i)=robust(i);
               fitpb(i)=fitness(i);
               pf1(i)=f1(i);
               pf2(i)=f2(i);
            end
        end
  %      dominate=0;
   %     if (f1(i)<=gf1) && (f2(i)<=gf2)
%            if (f1(i)<gf1) || (f2(i)<gf2)
   %             dominate=1;
 %           end
 %       end
        if fitg>fitness(i)
            gbest=particle(i,:);
            gf2=f2(i);
            fitg=fitness(i);
            gf1=f1(i);
        end
        if rand(1)<0.9
            particle(i,:)=Localsearch1(particle(i,:),customersize,ub);
        end
        if rand(1)<0.9
            route{i}=Localsearch2(route{i},customersize,dist0,dist,lb,ub,cost,demand);
       end
    end
   [rep,rf1,rf2,rrob,rsurvt]=updaterep(rep,rf1,rf2,rrob,rsurvt,route,f1,f2,robust,survive,customersize);
end
disp(length(rep));
index=find(rsurvt==50);
rep=rep(index);rf1=rf1(index);rf2=rf2(index);rsurvt=rsurvt(index);rrob=rrob(index);

fprintf('最终得到完全生存的鲁棒解个数为%d\n',length(rep));
for i=1:length(rep) 
    fprintf('第%d个解共采用了%d辆车,行驶总距离为%.2fkm,鲁棒性为%.2f\n',i,rf1(i),rf2(i),(50-rsurvt(i))/50);
end