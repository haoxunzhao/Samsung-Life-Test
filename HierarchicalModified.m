clear
clf
clc

tableind = ["a2:b116" "d2:e51" "g2:h110" "j2:k49" "m2:n106"];
typenum =5;
b = xlsread('PlotData.xlsx','Sheet2',tableind(typenum));%input
groupnum = 12;

[m,x,y,delete] = PrePlot(b);
m
% [bdelsf,bsf] = FeatureScaling(b,delete);
stat = b;
b(:,1) = log(b(:,1));
outliers = b(delete,:);
b(delete,:) = [];
stat(delete,:) = [];






% dendrogram
dis = pdist(y);
z = linkage(dis);
h = dendrogram(z,70);
set(h,'linewidth',1,'color','black')
set(gca,'fontsize',13)
xlabel('Sale week','fontsize',20)
ylabel('Discrepancy','fontsize',20)
title(['Type' num2str(typenum)],'fontsize',20);


% T = clusterdata(y,'Maxclust',groupnum);







% % scatter of the parameter sets
% bdryx = linspace(0,7,70);
% bdryy = size(bdryx);
% for i =(1:70)
%     bdryy(i) = log(900/(-log(0.995)^(1/bdryx(i))));
% end
% plot(bdryx,bdryy')
% hold on
% scatter(outliers(:,2),outliers(:,1),50,'black','*')
% hold on
% scatter(b(:,2),b(:,1),30,T,'filled')
% xlim([0,7]);
% ylim([6,17]);
% legend('Boundary of accepatble data','Unacceptable','Acceptable(grouped by color)');
% ylabel('Scale Parameter (ln)')
% xlabel('Shape-Parameter')
% set(gca,'fontsize',20)
% title({'Clustering based on curves';['Type ' num2str(typenum) ' Group Num = ' num2str(groupnum)]},'fontsize',20)




% % plot of HCA with thresholds
% for i = (1:groupnum)
%    hold on
%    plot(x,y(T==i,:)*100, 'color', rand(3,1), 'linewidth', 2)
% end
% ylabel('Falure Rate(%)')
% xlabel('Using Time (days)')
% set(gca,'fontsize',18)
% title({['Type' num2str(typenum)];'Distance Threshold = 0.6'},'fontsize',20)




% plot(x,y'*100,'color','black','linewidth',2)
% ylabel('Falure Rate(%)')
% xlabel('Using Time (days)')
% set(gca,'fontsize',18)
% title({['Type' num2str(typenum)]},'fontsize',20)







% bw = xlswrite('ParaResult.xlsx', stat,5,'A2');
% bw1 = xlswrite('ParaResult.xlsx', T,5,'C2'); 
