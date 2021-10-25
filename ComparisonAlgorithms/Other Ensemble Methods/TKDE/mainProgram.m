function program = mainProgram()

Problem = {'Alizadeh-2000-v1','Alizadeh-2000-v2','Alizadeh-2000-v3','Armstrong-2002-v1','Armstrong-2002-v2','Bhattacharjee-2001','Bittner-2000',...
   'Bredel-2005','Chen-2002','Chowdary-2006','Dyrskjot-2003','Garber-2001','Golub-1999-v1','Golub-1999-v2','Gordon-2002','Khan-2001_database',...
   'Laiho-2007_database','Lapointe-2004-v1','Lapointe-2004-v2','Liang-2005','Nutt-2003-v1','Nutt-2003-v2','Nutt-2003-v3','Pomeroy-2002-v1'...
   ,'Pomeroy-2002-v2','Ramaswamy-2001_database','Risinger-2003','Shipp-2002-v1','Singh-2002','Su-2001','Tomlins-2006-v1','Tomlins-2006-v2',...
   'West-2001','Yeoh-2002-v1','Yeoh-2002-v2'};


%% Model SETTINGS
params.numOfFolds = 10;                   % Create CROSS VALIDATION FOLDS
params.classifiers = {'KNN' 'DISCR', 'SVM','ANN','DT','NB'};
params.trainFunctionANN={'trainlm','trainbfg','trainrp','trainscg','traincgb','traincgf','traincgp','trainoss','traingdx'};
params.trainFunctionDiscriminant = {'pseudoLinear','pseudoQuadratic'};
params.kernelFunctionSVM={'gaussian','polynomial','linear'};

%% MAIN LOOP
parfor i = 1:length(Problem)
    for eachClass = 2:10
        p_name = Problem{i};
        results = runTraining(p_name, params, eachClass);
        results.p_name = p_name;        
        results.eachClass = eachClass;
        saveResults(results);
    end
end
end

