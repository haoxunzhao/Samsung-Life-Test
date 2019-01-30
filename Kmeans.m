clc
clf
clear

tableind = ["a2:b116" "d2:e51" "g2:h110" "j2:k49" "m2:n106"];
typenum = 1;


b = xlsread('PlotData.xlsx','Sheet2',tableind(typenum));
[m,x,y,delete] = PrePlot(b);
iter =30;
% knum = 15;
imptime = 30;
% plot(x,y', 'color','b');
costlist = zeros(1,26);
% for knum = (5:30)
    knum = 15;
    randnum = zeros(imptime,knum);
    costfun = zeros(imptime,iter);
    centroidlist = zeros(knum,50,imptime);
    ylabel = zeros(knum,imptime);
    for l = (1:imptime)
        randlist = randperm(50);
        randnum(l,:) = randlist(1:knum);
        centroid = y(randnum(l,:),:);
        for k = (1:iter)
            for i = (1:m)
                temmatrx = y(i,:)-centroid;
                rownorm = zeros(knum,1);
                for j = (1:knum)
                    rownorm(j) = norm(temmatrx(j,:));
                end
                [maxnum, ylabel(i,l)] = min(rownorm);
            end
            for i = (1:knum)
                dataind = find(ylabel(:,l) == i);
                centroid(i,:) = mean(y(dataind,:),1);
            end
            costfun(l,k) = CostFun(y, ylabel(:,l), centroid);
        end
        centroidlist(:,:,l) = centroid;
    end
    [finalcost,costind] = min(costfun(:,end));
    finallabel = ylabel(:,costind);
    centroid = centroidlist(:,:,costind);
    costlist(knum-4) = finalcost;
    
%     for i = (1:imptime)
%         hold on
%         plot(costfun(i,:),'color','b');
%         
%         xlim([1,30]);
%         ylabel('Objective cost')
%         xlabel('Iteration')
%         set(gca,'fontsize',20)
%         
%         title('Type1 Converge Test','fontsize',20);
%     end
        
        
    
% end

% xx = linspace(5,30,26);
% plot(xx,costlist)
% xlabel('Number of Group')
% ylabel('Total Cost')
% % title('Cost Sensitivity')






plot(x,centroid,'color','black','LineWidth',3);
hold on 
plot(x,y','color','red','linewidth',1);

color = "yellow";
for i = (1:knum)
    hold on
    plotind = find(finallabel == i);
    plot(x,y(plotind,:)*100,'color',rand(3,1),'LineWidth',2);
    xlabel("Using time (days)");
    ylabel("Failure-
    set(gca,'fontsize',20)
    title('Part1 K-means','fontsize',20)
end
% bw = xlswrite('PlotData.xlsx',finallabel,'Sheet3','A2');
    


    
    


    
    
        
        
    
    

