function program = mainProgram()

% addpath(genpath('P-DATA'));
% Problem={'adult','australian','balance','banknote',...
%     'breast-cancer-wisconsin','ecoli','haberman','ionosphere','iris'....
%     'liver','page-blocks','pima_diabetec','segment','sonar','statimag',...
%     'teaching','thyroid','vehicle','vowel','wdbc','wine','DNA',...
%     'fertility','heart','letter-recognition','hepatitis','bupa',...
%     'transfusion','zoo','hayes-roth'};
Problem = {'Alizadeh-2000-v1','Alizadeh-2000-v2','Alizadeh-2000-v3','Armstrong-2002-v1','Armstrong-2002-v2','Bhattacharjee-2001','Bittner-2000',...
   'Bredel-2005','Chen-2002','Chowdary-2006','Dyrskjot-2003','Garber-2001','Golub-1999-v1','Golub-1999-v2','Gordon-2002','Khan-2001_database',...
   'Laiho-2007_database','Lapointe-2004-v1','Lapointe-2004-v2','Liang-2005','Nutt-2003-v1','Nutt-2003-v2','Nutt-2003-v3','Pomeroy-2002-v1'...
   ,'Pomeroy-2002-v2','Ramaswamy-2001_database','Risinger-2003','Shipp-2002-v1','Singh-2002','Su-2001','Tomlins-2006-v1','Tomlins-2006-v2',...
   'West-2001','Yeoh-2002-v1','Yeoh-2002-v2'};
% Problem = {'wine'};
%
%% Model SETTINGS
params.numOfRuns = 10;
params.numOfFolds = 10;                   % Create CROSS VALIDATION FOLDS
params.classifiers = {'ANN', 'KNN', 'DT', 'DISCR','NB','SVM'};
params.trainFunctionANN={'trainlm','trainbfg','trainrp','trainscg','traincgb','traincgf','traincgp','trainoss','traingdx'};
params.trainFunctionDiscriminant = {'pseudoLinear','pseudoQuadratic'};
params.kernelFunctionSVM={'gaussian','polynomial','linear'};

%% MAIN LOOP
parfor i = 1:length(Problem)
    results = {};
    nonOptimized_Accuracy = [];
    optimized_Accuracy = [];
	p_name = [];
    for runs = 1:10
        p_name = Problem{i};
        results = runTraining(p_name, params);
        nonOptimized_Accuracy(runs) = results.nonOptimized_Accuracy;
		optimized_Accuracy(runs) = results.optimized_Accuracy
    end
    results.p_name = p_name;
    results.nonOptimized_Accuracy = mean(nonOptimized_Accuracy);
    results.optimized_Accuracy = mean(optimized_Accuracy);
    results.nonOptimized_stdDEV = std(nonOptimized_Accuracy);
    results.optimized_stdDEV = std(optimized_Accuracy);
    saveResults(results);
end
end

