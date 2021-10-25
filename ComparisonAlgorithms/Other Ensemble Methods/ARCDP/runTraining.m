function results = runTraining(p_name , params)
warning('off','all');

nonOptimized_Accuracy = [];
optimized_Accuracy = [];
test_Accuracy = [];
traindata = load(['C:\Users\c\Desktop\MultiClassifiers\TrainData\',p_name]);
traindata = traindata.TrainData;
data = traindata;
X = data(:,1:end-1);
y = data(:,end);

testdata = load(['C:\Users\c\Desktop\MultiClassifiers\TestData\',p_name]);
testdata = testdata.TestData;
%% ITERATE OVER THE NUMBER OF FOLDS
% cvFolds = cvpartition(y, 'KFold', params.numOfFolds);
for fold=1:10
%     data=load([pwd,filesep,'Data',filesep,p_name,filesep,p_name,'-CV-tr-', num2str(fold)]);
%     X=data.dtrX; Y=data.dtrY;
%     data = [X Y];

    classifierIndex = 1;
    classifiers = {};
    
    
    %% SEPARATE TRAIN / TEST DATA PER FOLD
    cv = cvpartition(data(:,end), 'holdout', 0.2);
    idxs = cv.test;
    testData = data(idxs,:);
    trainData = data(~idxs, :);
    
    %% SEPARATE VALIDATION DATA
    cvv = cvpartition(trainData(:,end), 'holdout', 0.1);
    idxs = cvv.test;
    valData = trainData(idxs,:);
    trainData = trainData(~idxs, :);
    
    trainX = trainData(:, 1:end-1);
    trainy = trainData(:, end);
    
    testX = testData(:, 1:end-1);
    testy = testData(:, end);
    
    valX = valData(:, 1:end-1);
    valy = valData(:, end);
    
    allClusters = generateClustersv2([trainX, trainy], params);
    
    %     allClusters = generateClusters([trainX, trainy], params);
    %     allClusters = balanceClusters(allClusters, [trainX trainy]);
    
    bestClusters = clusteringPSO(allClusters, [valX  valy], params);
    bestClusters = find(bestClusters.chromosome);
    selectedClusters = {};
    
    for i=1:length(bestClusters)
        selectedClusters{1,i} = allClusters{1, bestClusters(i)};
    end
    
    for c=selectedClusters
        X = c{1,1}(:, 1:end-1);
        y = c{1,1}(:, end);
        %         classifiers{classifierIndex} =b getCNN(X, y);
        all = trainClassifiers(X, y, params);
        for temp = 1:length(all)
            classifiers{classifierIndex} = all{1,temp};
            classifierIndex = classifierIndex + 1;
        end
    end
    
    psoEnsemble = classifierSelectionPSO(classifiers, [valX, valy]);
    psoEnsemble = find(psoEnsemble.chromosome);
    selectedClassifiers = {};
    
    for i=1:length(psoEnsemble)
        selectedClassifiers{1,i} = classifiers{1, psoEnsemble(i)};
    end
    
    nonOptimized_Accuracy(fold) = fusion(classifiers, [testX, testy]);
    optimized_Accuracy(fold) = fusion(selectedClassifiers, [testX, testy]);
    test_Accuracy(fold) = fusion(selectedClassifiers, testdata);
end
results.nonOptimized_Accuracy = mean(nonOptimized_Accuracy);
results.nonOptimized_stdDEV = std(nonOptimized_Accuracy);
results.optimized_Accuracy = mean(optimized_Accuracy);
results.optimized_stdDEV = std(optimized_Accuracy);
results.test_Accuracy = mean(test_Accuracy);
end

