b = xlsread('PlotData.xlsx','Sheet2','A1:B111');
[m,x,y] = PrePlot(b);
dist = zeros(m,m);
maxlist = zeros(1,m);
minlist = zeros(1,m);
for i = (1:m)
    for j = (1:m)
        dist(i,j) = norm(y(i,:)-y(j,:));
    end
    distsort = sort(dist(i,:));
    maxlist(1,i) = distsort(end);
    minlist(1,i) = distsort(2);
end
maxdist = max(maxlist)
mindist = min(minlist)

sumdist = sum(dist,2);
find(sumdist == max(sumdist),1)


