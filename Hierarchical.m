clear
clf
clc

typenum = 2;
tableind = ["a2:b116" "d2:e51" "g2:h110" "j2:k49" "m2:n106"];

% Initialze parameter
b = xlsread('PlotData.xlsx','Sheet2',tableind(typenum));%input
threshold = [0.05;0.2;0.6]; %input in increase order
maxdist = 2000;%input
% [raw] = xlsread('PlotData.xlsx','Row Data','A3:B117');%input
[m,x,y,delete] = PrePlot(b);
dist = zeros(m,m)+maxdist;
level = size(threshold,1);
cluster = zeros(m,m,level);
% cluster1 = zeros(m,m,level);
% y = yplot;


% Original distance matrix
for i = (1:m)
    for j = (i+1:m)
        dist(i,j) = norm(y(i,:)-y(j,:));
        dist(j,i) = dist(i,j);
    end
end
globmin = min(min(dist));


for k = (1:level)
    
    while globmin < threshold(k)
        % Get the nearest lines' number
        [row,col] = find(dist==globmin,1);
        rowatt = 0;
        colatt = 0;
        % If col or row is already in group 
        l = k;
        while l > 0
            if ismember(row,cluster(:,1,l))
                rowind = find(cluster(:,1,l)==row);
                rowatt = l;
                row = cluster(rowind,:,l);
                row(row==0) = [];
                break
            end
            l = l-1;
        end
        
        l = k;
        while l > 0
            if ismember(col,cluster(:,1,l))
                colind = find(cluster(:,1,l)==col);
                colatt = l;
                col = cluster(colind,:,l);
                col(col==0) = [];
                break
            end
            l = l-1;
        end
        zeroind = find(cluster(:,1,k)==0,1);
        % Assign original base to row
        if rowatt ~= k && colatt ~= k
            % Add a new group
            rowind = zeroind;
        elseif colatt == k && rowatt~=k
            %Switch col and row to make the row base
            row1 = row;
            row = col;
            col = row1;
            rowind = colind;
        end
        new = [row col];
        new(m) = 0;
        cluster(rowind,:,k) = new;
        
        if rowatt == k && colatt == k
            cluster(colind:zeroind-1,:,k) = ...
            cluster(colind+1:zeroind,:,k);
        end
        
        % Assign new average vector to grouphead
        dist(col(1),:) = maxdist;
        dist(:,col(1)) = maxdist;
        y(row(1),:) = (y(row(1),:)*length(row)+y(col(1),:)*length(col)) ...
            /length([row col]);
        
        % Update the distance matrix(Only the ones between lines and grouphead)
        for j = (1:m)
            if dist(j,row(1)) ~= maxdist
                dist(j,row(1)) = norm(y(j,:)-y(row(1),:));
                dist(row(1),j) = dist(j,row(1));
            end
        end 
        globmin = min(min(dist));
    end
end

% Add the previous group in the current pattern
j = level;
while j>1
    p = j-1;
    while p>0
        for i =(1:nnz(cluster(:,1,p)))
            if ~ismember(cluster(i,1,p),cluster(:,:,j))
                tem = cluster(i,:,p);
                tem(m) = 0;
                cluster(find(cluster(:,1,j)==0,1),:,j) = tem;
            end
            
        end
        p = p-1;
    end
    j = j-1;
end
% cluster1 = cluster;
% Handle all of the single lines
for j = (1:level)
    newrow = nnz(cluster(:,1,j))+1;
    for i = (1:m)
        if ~ismember(i,cluster(:,:,j))
%             newrow1 = nnz(cluster1(:,1,j))+1;
%             cluster1(newrow1,1,j) = i;
            newcol = nnz(cluster(newrow,:,j))+1;
            cluster(newrow,newcol,j) = i;
            
        end
    end
end

%Delete zero rows and columns
cluster(cluster(:,1,1)==0,:,:) = [];
% cluster1(cluster1(:,1,1)==0,:,:) = [];
list = zeros(1,level);
list1 = list;
for i = (1:level)
    list(i) = max(sum(cluster(:,:,i)~=0,2));
%     list1(i) = max(sum(cluster1(:,:,i)~=0,2));
end
cluster(:,max(list)+1:end,:) = [];
% cluster1(:,max(list1)+1:end,:) = [];


% treeplot
% treenodes = zeros(level,m);
% treenodes(level,1) = nnz(cluster(nnz(cluster(:,1,level)),:,level)) ...
%            +nnz(cluster(:,1,level))-1;
% i = level-1;
% while i > 0 
%     if i == level
%        treenodes(level,1) = nnz(cluster(nnz(cluster(:,1,level)),:,level)) ...
%            +nnz(cluster(:,1,level))-1;
%     else
%         for j = (1:nnz(treenodes(i+1)))
%             for k = (1:j)
%                 
%             end
%         end
%     end
%     i = i-1;
% end








% Test
% for i = (1:level)
%     nnz(cluster(:,:,i))
% end


% Plot
plotdist = 3;
for i =(1:nnz(cluster(:,1,plotdist))-1)
    hold on
    togroupnum = nnz(cluster(i,:,plotdist));
    plot(x,y(cluster(i,1:togroupnum,plotdist),:)', 'color', rand(3,1), 'linewidth', 2);
end
for i =(1:nnz(cluster(nnz(cluster(:,1,plotdist)),:,plotdist)))
    hold on
    plot(x,y(cluster(nnz(cluster(:,1,plotdist)),i,plotdist),:)', 'color', rand(3,1), 'linewidth', 2);
end
title({'Type 5','Distance Threshold = 0.05'});

    

%Fill in the table file
% for i =(1:level)
%     nnz(cluster(:,:,i))
%     for j =(1:nnz(cluster(:,1,i)))
%         wrow = j;
%         k = i;
%         while k>1
%             wrow = nnz(cluster(:,1,k-1))+wrow+1;
%             k = k-1;
%         end
%         bw = xlswrite('PlotData.xlsx', cluster(j,cluster(j,:,i)~=0,i),7,['C' num2str(wrow)]);
%     end
% end

% treebase = [];
% tree = zeros(m,4);
% for i = (1:nnz(cluster(:,1,level)))
%     treebase = [treebase;cluster(i,cluster(i,:,level)~=0,level)'];
% end
% tree(:,1) = treebase;
% 
% for i = (1:level)
%     label = 1   ;
%     for j = (1:nnz(cluster1(:,1,i)))
%         treeind = find(treebase==cluster1(j,1,i));
%         amount = nnz(cluster1(j,:,i));
%         tree(treeind:treeind+amount-1,i+1) = label;
%         label = label+1;
%     end





%     for j = (1:m)
%         if ismember(treebase(j),cluster1(:,1,i))
%             groupind = find(cluster1(:,1,i)==treebase(j));
%             amount = nnz(cluster1(groupind,:,i));
%             tree(j:j+amount-1,i+1) = label;
%             label = label + 1;
%         end
%     end
% end
% bw = xlswrite('ClusterData.xlsx', tree,7,'B28');
