clear
clf
clc

typenum = 5;
tableind = ["a2:b116" "d2:e51" "g2:h110" "j2:k49" "m2:n106"];
b = xlsread('PlotData.xlsx','Sheet2',tableind(typenum));%input
[m,x,y,delete] = PrePlot(b);
groupnum = 12;

% [bdelsf,bsf] = FeatureScaling(b,delete);
b(:,1) = log(b(:,1));
outliers = b(delete,:);
b(delete,:) = [];

c = zeros(size(b));
c(:,1) = b(:,2);
c(:,2) = b(:,1);


T = clusterdata(c,'Maxclust',groupnum);

bdryx = linspace(0,7,70);
bdryy = size(bdryx);
for i =(1:70)
    bdryy(i) = log(900/(-log(0.995)^(1/bdryx(i))));
end
plot(bdryx,bdryy')
hold on
scatter(outliers(:,2),outliers(:,1),50,'black','*')
hold on
scatter(b(:,2),b(:,1),40,T,'filled')
legend('Boundary of accepatble data','Unacceptable','Acceptable(grouped by color)');
xlim([0,7]);
ylim([6,17]);
ylabel('Scale Parameter (ln)')
xlabel('Shape-Parameter')
set(gca,'fontsize',20)
title({'Clustering based on parameter sets';['Type ' num2str(typenum) ' Group Num = ' num2str(groupnum)]},'fontsize',20)



% dis = pdist(yplot);
% size(dis)
% Z = linkage(dis)

% [H,T] = dendrogram(Z,200);
% set(gca,'FontName','Times New Roman','FontSize',13)
% ylim([0,0.01])
% title('Type1-ylim=0.01')
% print('-dpng','Type1-ylim=0.01.png')

% title('Type1')
% print('-dpng','Type1.png')
