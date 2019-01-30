function [m,x,y,delete] = PrePlot(b)
% b(isnan(b(:,1)),:)=[];
m = size(b,1);
x = linspace(0,900,50);
y = zeros(m,50);
for i =(1:m)
    y(i,:) = 1-exp(-((x./b(i,1)).^b(i,2)));
end
delete = y(:,end)>0.005;
y(delete,:) =[];
m = size(y,1);





% delrow = find(delete==1);