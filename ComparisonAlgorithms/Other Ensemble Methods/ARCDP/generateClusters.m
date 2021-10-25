function genClusters = generateClusters(train , params)
totalClusters = 1;
genClusters = {};
dataClasses = unique(train(:,end))';
for i=1:length(dataClasses)
    [clusterIds, C, sum, D] = kmeans(zscore(train(:,1:end-1)), params.eachClass);   
    for j=1:params.eachClass
        genClusters{totalClusters}.train = train(find(clusterIds == j), :);
        genClusters{totalClusters}.centroid = C(j,:);
        totalClusters = totalClusters + 1;
    end
end
end


