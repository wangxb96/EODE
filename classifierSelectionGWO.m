function GWO =classifierSelectionGWO(classifierList, testData, opts)
warning('off','all');
try
    warning('off','all')
    allPredictions = GWOPredict(classifierList, testData);
    lengthclassifiers = length(classifierList);
    fun = @GWOSelection;
    GWO = GreyWolfOptimizer(fun, classifierList, opts);
catch exc
    disp(sprintf('problem with %s', exc.identifier));
end


%% OBJECTIVE FUNCTION
    function error=GWOSelection(c, thres)
        % BINARIZE THE CLASSIFIER SELECTION
        d = find(c > thres);
        %% CALCULATE THE ACCURACY
        decisionMatrix = ones(length(testData(:,end)), length(d));
        for i=1:length(d)
            decisionMatrix(:,i) = allPredictions(:, d(i)) ;
        end
        decisionMatrix = mode(decisionMatrix, 2);
        error = 0.9 * mean(decisionMatrix ~= testData(:,end)) + 0.1 * ( length(d)/lengthclassifiers);
    end
end