numRun = 1;
for i=1:numRun
    addpath(genpath('data'));
%     Problem = {'PanCancer'};%
%     Problem = {'Alizadeh-2000-v1'};
    Problem = {'Alizadeh-2000-v1','Alizadeh-2000-v2','Alizadeh-2000-v3','Armstrong-2002-v1','Armstrong-2002-v2','Bhattacharjee-2001','Bittner-2000',...
       'Bredel-2005','Chen-2002','Chowdary-2006','Dyrskjot-2003','Garber-2001','Golub-1999-v1','Golub-1999-v2','Gordon-2002','Khan-2001_database',...
       'Laiho-2007_database','Lapointe-2004-v1','Lapointe-2004-v2','Liang-2005','Nutt-2003-v1','Nutt-2003-v2','Nutt-2003-v3','Pomeroy-2002-v1'...
       ,'Pomeroy-2002-v2','Ramaswamy-2001_database','Risinger-2003','Shipp-2002-v1','Singh-2002','Su-2001','Tomlins-2006-v1','Tomlins-2006-v2',...
       'West-2001','Yeoh-2002-v1','Yeoh-2002-v2'};

    % Model SETTINGS
    params.numOfFolds = 5;                  % Create CROSS VALIDATION FOLDS,'DT','ANN'};%};%;};%,'NB','RF''DISCR','SVM','NB'
    params.classifiers = {'DISCR','DT','KNN','ANN','SVM','NB'};
    
    %% MAIN LOOP
    parfor j = 1:length(Problem)
        for eachClass = 1:1
            p_name = Problem{j};
            results = Training(p_name, params);
            results.p_name = p_name;                           
            saveResults(results);
        end 
    end 
end

function results = Training(p_name , params)
    warning('off','all');
    params.p_name = p_name;
    traindata = load(['C:\Users\qywxb\Desktop\EODE\TrainData\',p_name]);
    traindata = traindata.TrainData;
%     traindata = traindata.traindata;
%     traindata = traindata.train;
    testdata = load(['C:\Users\qywxb\Desktop\EODE\TestData\',p_name]);
    testdata = testdata.TestData;
%    testdata = testdata.testdata;
%     testdata = testdata.test;
    data = traindata;
    X = data(:,1:end-1);
    y = data(:, end);
    feat = data(:,1:end-1); 
    label = data(:,end);
 
    %% select the best classifier for feature selection
    indx = cvpartition(label,'KFold',5);
    for f = 1 : 5
        test = data(indx.test(f),:);
        train = data(~indx.test(f),:);
        xtrain = train(:,1:end-1);
        ytrain = train(:,end);
        xtest = test(:,1:end-1);
        ytest = test(:,end);
        My_Model1 = fitcdiscr(xtrain,ytrain, 'discrimtype','diaglinear'); % DISCR
        pred1 = predict(My_Model1,xtest);
        acc1(f) = mean(pred1 == ytest);
        My_Model2 = fitctree(xtrain,ytrain); % DT
        pred2 = predict(My_Model2,xtest);
        acc2(f) = mean(pred2 == ytest);        
        My_Model3 = fitcknn(xtrain,ytrain,'NumNeighbors',3); % KNN
        pred3 = predict(My_Model3,xtest);
        acc3(f) = mean(pred3 == ytest);
        My_Model4 = trainNN(xtrain,ytrain); % ANN
        pred4 = getNNPredict(My_Model4,xtest);
        acc4(f) = mean(pred4 == ytest);       
        radial=templateSVM('KernelFunction','rbf','IterationLimit',50000,'Standardize',true); % SVM   
        My_Model5 = fitcecoc(xtrain,ytrain, 'learners', radial, 'ClassNames',[unique(ytrain)]);
        pred5 = predict(My_Model5,xtest);
        acc5(f) = mean(pred5 == ytest);
        My_Model6 = fitcnb(xtrain,ytrain, 'distribution', 'kernel'); % NB
        pred6 = predict(My_Model6,xtest);
        acc6(f) = mean(pred6 == ytest);

    end 
    disp([mean(acc1),mean(acc2),mean(acc3),mean(acc4),mean(acc5),mean(acc6)]);
    [Acc1, num] = max([mean(acc1),mean(acc2),mean(acc3),mean(acc4),mean(acc5),mean(acc6)]);
    fprintf('\n The %d th classifier is selected',num);

   %% basic settings of GWO algorithm
    % Number of k in K-nearest neighbor
    opts.k = 3; 
    % Common parameter settings 
    opts.N  = 100;     % number of solutions
    opts.T  = 50;    % maximum number of iterations
    opts.num = num;

   %% feature selection using GWO algorithm
    GWO = jGreyWolfOptimizer(feat,label,opts);
    sf = GWO.sf;
    GWOdata = [feat(:,sf),label];
    traindata = GWOdata;
    numSF = size(traindata, 2) - 1 ;
    feature = testdata(:,sf);
%     save('sf.mat','sf');
    testdata = [feature, testdata(:,end)];
    finalClassifiers = [];
    
    cvs = cvpartition(traindata(:,end),'KFold',5);
    for  f = 1 : 5
      idxs = cvs.test(f);
      testData = traindata(idxs,:);
      trainData = traindata(~idxs,:);
   %% Ensemble classifier for classification
        train = trainData;
        test = testData;
        allClusters = generateClusters(train);
        for i = 1 : length(allClusters)
            balancedClusters{i} = allClusters{i};
        end
        classifierIndex = 1;
        for c=balancedClusters
            X = c{1,1}(:, 1:end-1);
            y = c{1,1}(:, end);
            all = trainClassifiers(X, y, params);
            if size(all,1) < 1 
                continue
            end
            for temp = 1:length(all)
                allclassifiers{classifierIndex} = all{1,temp};
                classifierIndex = classifierIndex + 1;
            end 
        end     
        [~, pred] = fusion(allclassifiers,test);
        SC = [];
        acc = zeros(1,size(pred,2));
        for i = 1 : size(pred,2)
            acc(i) = mean(pred(:,i) == test(:,end));
        end    
        for i = 1 : size(pred,2)
            if acc(i) >= mean(acc)
               SC = [SC, i];
            end
        end
        allclassifiers = allclassifiers(:,SC);
        GWO = classifierSelectionGWO(allclassifiers, test, opts); 
        optimized_Accuracy(f) = fusion(allclassifiers(:,GWO.sc), testData);
        nonoptimized_Accuracy(f) = fusion(allclassifiers, testData);
        finalClassifiers = [finalClassifiers, allclassifiers(:,GWO.sc)];
    end
%     save('finalClassifiers.mat','finalClassifiers');
    [testAcc, ~] = fusion(finalClassifiers, testdata);
    results.testAcc = testAcc;
    results.optimized_Accuracy = mean(optimized_Accuracy);
    results.nonoptimized_Accuracy = mean(nonoptimized_Accuracy);
    results.selected_Features = numSF;
    disp(results.optimized_Accuracy);
    disp(results.nonoptimized_Accuracy);
    disp(numSF);
    disp(results.testAcc);
 end
