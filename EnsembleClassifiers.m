function results = EnsembleClassifiers(Data, opts, params)
%     optimized_Accuracy = [];
    %% ITERATE OVER THE NUMBER OF FOLDS  
    cvFolds = cvpartition(Data(:,end),'KFold',params.numOfFolds); 
    classes = unique(Data(:,end));        
    LM = [];
    ESM = [];
    dataM = [];
    for f=1:params.numOfFolds
        claIndex = 1;
        classifierIndex = 1;

        idx = cvFolds.test(f);
        trainData = Data(~idx,:);
        testData = Data(idx,:);    
        
        % TRAIN CLASSIFIERRS ON TRAINING DATA
        all = trainClassifiers(trainData(:,1:end-1), trainData(:,end), params);
        for temp = 1:length(all)
            classifiersPre{claIndex} = all{1,temp};
            claIndex = claIndex + 1;
        end   
        
        % PARTITION THE TRAINDATA
        cv = cvpartition(trainData(:,end),'holdout',0.1);
        idxs = cv.test;
        validationData = trainData(idxs,:);
        trainData = trainData(~idxs, :);

        trainX = trainData(:, 1:end-1);
        trainy = trainData(:, end); 
                
        valX = validationData(:, 1:end-1);
        valy = validationData(:, end);
        
        testX = testData(:, 1:end-1);          
        testy = testData(:, end);
        
        trainX(isnan(trainX)) = -1;
        valX(isnan(valX)) = -1;   
        testX(isnan(testX)) = -1;
        
        % TRAIN THE CLASSIFIERS ON VALIDATION DATA
        all = trainClassifiers(trainX, trainy, params);
        for temp = 1:length(all)
            classifiers{classifierIndex} = all{1,temp};
            classifierIndex = classifierIndex + 1;
        end
%         [L,ES,pre] = prediction(classifiers, [valX, valy], classes, params);
%         LM = [LM; L]; ESM = [ESM; ES]; dataM = [dataM; testData];

        %PREDICT THE L MATRIX & ENTROPY MATRIX ON VALIDATION DATA
        [L,ES,pre] = prediction(classifiers, [valX, valy], classes, params);   

        % RECORD THE MAXIMUM CLASSIFIERS ON VALIDATION STAGE
        acc = zeros(1,size(pre,2));
        for i = 1 : size(pre,2)
            acc(i) = mean(pre(:,i) == valy);
        end
        [~, iidx] = max(acc);

        % USING THE DE ALGORITHM TO SELECT A THRESHOLD VECTOR alpha
        alpha = DEoptimization(L, ES, [valX, valy], opts, classes, params);
 
        % PREDICT THE L MATRIX & ENTROPY MATRIX ON TEST DATA
        [LL, EStest, DMPred] = prediction(classifiersPre, testData, classes, params);

        save('LL.mat','LL','DMPred','EStest');
        save('etestData.mat','testData');
        [acc1(f), acc2(f), optimized_Accuracy(f)] = classification(testData, classes, alpha, LL, EStest, DMPred, iidx);        
    end        
    results.optimized_Accuracy = mean(optimized_Accuracy);
    results.optimized_stdDEV = std(optimized_Accuracy);
    
    disp(mean(acc1));
    disp(mean(acc2));     
    disp(results.optimized_Accuracy);
end

