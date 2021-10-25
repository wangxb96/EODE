  
addpath(genpath('data'));
Problem = { 'subtype_molecular_RNA_Seq'};%,'ucec_rna_seq'};
% Problem = {'Alizadeh-2000-v1','Alizadeh-2000-v2','Alizadeh-2000-v3','Armstrong-2002-v1','Armstrong-2002-v2','Bhattacharjee-2001','Bittner-2000',...
%    'Bredel-2005','Chen-2002','Chowdary-2006','Dyrskjot-2003','Garber-2001','Golub-1999-v1','Golub-1999-v2','Gordon-2002','Khan-2001_database',...
%    'Laiho-2007_database','Lapointe-2004-v1','Lapointe-2004-v2','Liang-2005','Nutt-2003-v1','Nutt-2003-v2','Nutt-2003-v3','Pomeroy-2002-v1'...
%    ,'Pomeroy-2002-v2','Ramaswamy-2001_database','Risinger-2003','Shipp-2002-v1','Singh-2002','Su-2001','Tomlins-2006-v1','Tomlins-2006-v2',...
%    'West-2001','Yeoh-2002-v1','Yeoh-2002-v2'};

 %% MAIN LOOP
for j = 1:length(Problem)
p_name = Problem{j};
results = Training(p_name);
results.p_name = p_name;                           
saveResultsTraining(results);
% saveResultsTest(results);
end

function results = Training(p_name)
    traindata = load(['C:\Users\c\Desktop\MultiClassifiers\TrainData\',p_name]);
%     traindata = traindata.TrainData;
    traindata = traindata.train;
    originalData = traindata;
    testdata = load(['C:\Users\c\Desktop\MultiClassifiers\TestData\',p_name]);
%     testdata = testdata.TestData;
    testdata = testdata.test;
%     data = [data.fea, data.gnd];
    filepath = 'C:\Users\c\Desktop\MultiClassifiers\EvolutionFeatureSelection\';
    feat = traindata(:,1:end-1); label = traindata(:,end);
   %% Graph based feature selection
%    [RANKED, WEIGHT, SUBSET] = ILFS(feat, label, 6, 0);
%    traindata = [feat(:,SUBSET),label]; % After Graph Feature Selection
%    filename = 'GAtraindata.mat';
%    save([filepath, filename],'traindata');
%    feat = traindata(:,1:end-1); label = traindata(:,end);
   %% basic settings of Evolution algorithm
    % Number of k in K-nearest neighbor
    opts.k = 3; 
    % Common parameter settings 
    opts.N  = 100;     % number of solutions
    opts.T  = 50;    % maximum number of iterations 
    opts.num = 3;
    % Ant Colony Optimization
%     ACO = jAntColonyOptimization(feat,label,opts);    
%     tracc = ACO.acc;
%     ACOdata = [ACO.ff, label];    
%     numSF = size(ACOdata, 2) - 1 ;
%     filename = 'ACOdata.mat';
%     save([filepath, filename],'ACOdata');
%     traindata = ACOdata;
%     feature = testdata(:,ACO.sf);
%     testdata = [feature, testdata(:,end)];
    
%     % Artificial Bee Colony 
%     ABC = jArtificialBeeColony(feat,label,opts);
%     tracc = ABC.acc;
%     ABCdata = [ABC.ff, label];
%     numSF = size(ABCdata, 2) - 1 ;
%     filename = 'ABCdata.mat';
%     save([filepath, filename],'ABCdata');
%     traindata = ABCdata;
%     feature = testdata(:,ABC.sf);
%     testdata = [feature, testdata(:,end)];  
    
    % Cuckoo Search Algorithm
%     CS = jCuckooSearchAlgorithm(feat,label,opts);  
%     tracc = CS.acc;
%     CSdata = [CS.ff, label];
%     numSF = size(CSdata,2) - 1;
%     filename = 'CSdata.mat';
%     save([filepath, filename],'CSdata');
%     traindata = CSdata;
%     feature = testdata(:,CS.sf);
%     testdata = [feature, testdata(:,end)];      
    
%     % Differential Evolution  
%     DE = jDifferentialEvolution(feat,label,opts);
%     tracc = DE.acc;
%     DEdata = [DE.ff, label];
%     numSF =  size(DEdata,2) - 1;
%     filename = 'DEdata.mat';
%     save([filepath, filename],'DEdata');
%     traindata = DEdata;
%     feature = testdata(:,DE.sf);
%     testdata = [feature, testdata(:,end)];    
    
%     % Genetic Algorithm
%     GA = jGeneticAlgorithm(feat,label,opts);
%     tracc = GA.acc;
%     GAdata = [GA.ff, label];
%     numSF =  size(GAdata,2) - 1;
%     filename = 'GAdata.mat';
%     save([filepath, filename],'GAdata');
%     traindata = GAdata;
%     feature = testdata(:,GA.sf);
%     testdata = [feature, testdata(:,end)]; 
    
%     % Grey Wolf Optimizer
%     GWO = jGreyWolfOptimizer(feat,label,opts);
%     tracc = GWO.acc;
%     GWOdata = [GWO.ff, label];
%     numSF =  size(GWOdata,2) - 1;
%     filename = 'GWOdata.mat';
%     save([filepath, filename],'GWOdata');
%     traindata = GWOdata;
%     feature = testdata(:,GWO.sf);
%     testdata = [feature, testdata(:,end)]; 
%     
%     % Particle Swarm Optimization
%     PSO = jParticleSwarmOptimization(feat,label,opts);
%     tracc = PSO.acc;
%     PSOdata = [PSO.ff, label];
%     numSF =  size(PSOdata,2) - 1;
%     filename = 'PSOdata.mat';
%     save([filepath, filename],'PSOdata');
%     traindata = PSOdata;
%     feature = testdata(:,PSO.sf);
%     testdata = [feature, testdata(:,end)]; 

%      cv = cvpartition(traindata(:,end),'KFold',5);
%      for f = 1 : 5
%         idx = cv.test(f);
%         testData = traindata(idx,:);
%         trainData = traindata(~idx,:);               
%         
%         trainX = trainData(:,1:end-1);
%         trainy = trainData(:,end);
%         testX = testData(:,1:end-1);
%         testy = testData(:,end);  
        
        trainX = traindata(:,1:end-1);
        trainy = traindata(:,end);
        testX = testdata(:,1:end-1);
        testy = testdata(:,end); 
        
        % SVM method
        radial=templateSVM('KernelFunction','rbf','IterationLimit',50000,'Standardize',true);    
        modelSVM = fitcecoc(trainX, trainy, 'learners', radial, 'ClassNames',[unique(trainy)]);
        predSVM = predict(modelSVM,testX);
%         tracc(f) = mean(predSVM == testy);
        acc = mean(predSVM == testy);
        
        % Random Forest Method
%         modelRF = fitcensemble(trainX, trainy, 'Method','Bag');
%         predRF = predict(modelRF,testX);
%         tracc(f) = mean(predRF == testy);
%         acc = mean(predRF == testy);  

%         AdaBoost
%         if length(unique(trainy)) == 2
%             modelAda = fitcensemble(trainX, trainy, 'Method','AdaBoostM1');
%         else % multiclass
%             modelAda = fitcensemble(trainX, trainy, 'Method','AdaBoostM2');
%         end
%         predAda = predict(modelAda,testX);
%         tracc(f) = mean(predAda == testy);
%         acc = mean(predAda == testy);
%         
%         % RUSBoost
%         modelRUS = fitcensemble(trainX, trainy, 'Method','RUSBoost');
%         predRUS = predict(modelRUS,testX);
%         tracc(f) = mean(predRUS == testy);
%         acc = mean(predRUS == testy);
        
        % Subspace
%         modelSub = fitcensemble(trainX, trainy, 'Method','subspace');
%         predSub = predict(modelSub,testX);
%         tracc(f) = mean(predSub == testy);
%         acc = mean(predSub == testy);
        
        % DT
%         modelDT = fitctree(trainX, trainy);
%         predDT = predict(modelDT, testX);
%         tracc(f) = mean(predDT == testy);
%         acc = mean(predDT == testy);
        
        % KNN 
%         modelKNN = fitcknn(trainX, trainy,'NumNeighbors', 3);
%         predKNN = predict(modelKNN, testX);
%         tracc(f) = mean(predKNN == testy);
%         acc = mean(predKNN == testy);

        % ANN
%         modelANN = trainNN(trainX, trainy);
%         predANN = getNNPredict(modelANN, testX);
%         tracc(f) = mean(predANN == testy);
%         acc = mean(predANN == testy);
        
        % DISCR
%          modelDISCR = fitcdiscr(trainX, trainy, 'discrimtype','diaglinear');
%          predDISCTR = predict(modelDISCR, testX);
%          tracc(f) = mean(predDISCTR == testy);
%          acc = mean(predDISCTR == testy);

        % NB
%         modelNB = fitcnb(trainX, trainy, 'distribution', 'kernel');
%         predNB = predict(modelNB, testX);
%         tracc(f) = mean(predNB == testy);
%         acc = mean(predNB == testy);
        
        % Totalboost
%         modelTotal = fitcensemble(trainX, trainy,'Method','totalboost');
%         predTotal = predict(modelTotal, testX);
%         tracc(f) = mean(predTotal == testy);
%         acc = mean(predTotal == testy);
        
        % Lpbboost 
%         modelLpb = fitcensemble(trainX, trainy,'Method', 'Lpboost');
%         predLpb = predict(modelLpb, testX);
%         tracc(f) = mean(predLpb == testy);
%         acc = mean(predLpb == testy);
%       end
%     numSF = 0;
%     results.TrainingAcc = mean(tracc);
    results.TestAcc = mean(acc);
%     results.selectedNumber = numSF;
    disp(results.TestAcc);
end
    