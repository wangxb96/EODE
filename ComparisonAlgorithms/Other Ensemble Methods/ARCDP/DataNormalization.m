function [X]=DataNormalization(D,type)
if type==1
max_x=max(D);
min_x=min(D);
if any(max_x==0)
    X=D;
    return
end
X=(D-repmat(min_x,size(D,1),1))./(repmat(max_x,size(D,1),1)-repmat(min_x,size(D,1),1));
else
X=mapminmax(D);
end

return