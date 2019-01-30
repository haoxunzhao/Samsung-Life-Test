function costfun = CostFun(y,ylabel,centroid)
costfun = 0;
m = size(y,1);
for i =(1:m)
    costfun = costfun + norm(y(i,:)-centroid(ylabel(i),:));
end
end


    
    



