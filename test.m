clear
clc
clf

% x = linspace(5,30,26)
% % y  = linspace(0.0565,0.0075,26)
% 
% y = [0.0565    0.0472    0.0415    0.038    0.033    0.032    0.0295    0.027    0.0258    0.0238    0.0219    0.02    0.019    0.018    0.016    0.0124   0.01256    0.01252    0.0125   0.0122    0.012    0.01   0.008   0.0084    0.0077    0.0075]
% plot(x,y')
% ylabel('Objective cost')
% xlabel('Group number')
% set(gca,'fontsize',20)
% title({'Cost sensitive';'Type 1'},'fontsize',20)



b = [0.3 1 3];
x = linspace(0,2,500);
size(x)
y = zeros(3,500);
r = zeros(3,500);
for i = (1:3)
    y(i,:) = 1-exp(-(x.^b(i)));
    r(i,:) = b(i)*x.^(b(i)-1);
end
% plot(x,y(1,:)',x,y(2,:)',x,y(3,:)','linewidth',2)
% ylim([0,1.5]);
% xlabel('Time');
% ylabel('F(t)');
% set(gca,'fontsize',30)
% title('Cdf of Weibull distribution','fontsize',30);
% legend('Beta = 0.3', 'Beta = 1', 'Beta = 3')

plot(x,r(1,:)',x,r(2,:)',x,r(3,:)','linewidth',2)
xlabel('Time');
ylim([0,4]);
ylabel('Failure rate');
set(gca,'fontsize',30)
title('Failure rate of Weibull distribution','fontsize',30);   
legend('Beta = 0.3', 'Beta = 1', 'Beta = 3')