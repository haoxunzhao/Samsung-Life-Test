function [bdelsf,bsf] = FeatureScaling(b,delete)
% b(isnan(b(:,1)),:)=[];
bsf = zeros(size(b));
bdel = b;
bdel(delete,:) = [];

bdelsf = zeros(size(bdel));
bdelsf(:,1) = bdel(:,1)/max(bdel(:,1));
bdelsf(:,2) = bdel(:,2)/max(bdel(:,2));

bsf(:,1) = b(:,1)/max(bdel(:,1));
bsf(:,2) = b(:,2)/max(bdel(:,2));

