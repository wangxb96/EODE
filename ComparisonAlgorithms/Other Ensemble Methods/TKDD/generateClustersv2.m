function genClusters = generateClustersv2(train , params)
totalClusters = 1;
genClusters = {};
noOfClusters = round(nthroot(length(train(:,end)),5));
for clusters=1:noOfClusters
    [clusterIds, C, sum, D] = kmeans(dataNormalize(train(:,1:end-1),1),clusters,'MaxIter',24000);   
    for j=1:clusters
        genClusters{1,totalClusters} = train(find(clusterIds == j), :);
        totalClusters = totalClusters + 1;
    end
end
end


