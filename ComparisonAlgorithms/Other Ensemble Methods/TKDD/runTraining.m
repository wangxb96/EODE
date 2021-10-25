function results = runTraining(p_name , params)
warning('off','all');

nonOptimized_Accuracy = [];
optimized_Accuracy = [];
test_Accuracy = [];
traindata = load(['C:\Users\c\Desktop\MultiClassifiers\TrainData\',p_name]);
traindata = traindata.TrainData;
testdata = load(['C:\Users\c\Desktop\MultiClassifiers\TestData\',p_name]);
testdata = testdata.TestData;
% data = load(p_name);
% data = [data.X, data.y];
data = traindata;
X = data(:,1:end-1);
y = data(:,end);
cvFolds = cvpartition(y, 'KFold', params.numOfFolds);

for f=1:params.numOfFolds
    classifierIndex = 1;
    classifiers = {};
    
    idx = cvFolds.test(f);
    trainData = data(~idx,:);
    testData = data(idx,:);   
       
    %% SEPARATE VALIDATION DATA
    cv = cvpartition(trainData(:,end), 'holdout', 0.1);
    idxs = cv.test;
    validationData = trainData(idxs,:);
    trainData = trainData(~idxs, :);

    trainX = trainData(:, 1:end-1);
    trainy = trainData(:, end);

    testX = testData(:, 1:end-1);
    testy = testData(:, end);

    valX = validationData(:, 1:end-1);
    valy = validationData(:, end);

    trainX(isnan(trainX)) = -1;
    testX(isnan(testX)) = -1;
    valX(isnan(valX)) = -1;
    
    allClusters = generateClustersv2([trainX, trainy], params);
    bestClusters = clusteringPSO(allClusters, [valX,valy], params);
    bestClusters = find(bestClusters.chromosome);
    
    
    selectedClusters = {};
    for i=1:length(bestClusters)
        selectedClusters{1,i} = allClusters{1, bestClusters(i)};
%         X = selectedClusters{1,i}(:,1:end-1);
%         y = selectedClusters{1,i}(:,end);
%         all = trainClassifiers(X, y, valX, valy, params);
%              save('fff.mat','all');
    end
    for c=selectedClusters
        X = c{1,1}(:, 1:end-1);
        y = c{1,1}(:, end);
        all = trainClassifiers(X, y, valX, valy, params);
        for temp = 1:length(all)
            classifiers{classifierIndex} = all{1,temp};
            classifierIndex = classifierIndex + 1;
        end
    end

       
    
%     save('classsifier.mat','classifiers');
    psoEnsemble = classifierSelectionPSO(classifiers, [valX, valy]);
    psoEnsemble = find(psoEnsemble.chromosome);
    selectedClassifiers = {};
    
    for i=1:length(psoEnsemble)
        selectedClassifiers{1,i} = classifiers{1, psoEnsemble(i)};
    end
    
    nonOptimized_Accuracy(f) = fusion(classifiers, [testX, testy]);
    optimized_Accuracy(f) = fusion(selectedClassifiers, [testX, testy]);
    test_Accuracy(f) = fusion(selectedClassifiers, testdata);
end
results.nonOptimized_Accuracy = mean(nonOptimized_Accuracy);
results.nonOptimized_stdDEV = std(nonOptimized_Accuracy);
results.optimized_Accuracy = mean(optimized_Accuracy);
results.optimized_stdDEV = std(optimized_Accuracy);
results.test_Accuracy = mean(test_Accuracy);
end

