function rs = saveResults(results)
  fid = [];
    if (exist([pwd filesep 'resultsARCDP.csv'], 'file') == 0)
        fid = fopen([pwd filesep 'resultsARCDP.csv'], 'w');
        fprintf(fid, '%s, %s, %s, %s, %s, %s\n', ...
            'Data Set','Avg Accuracy', 'Std. Dev', 'Optimized Acc', 'Std. Dev', 'test Accuracy');
    elseif (exist([pwd filesep 'resultsARCDP.csv'], 'file') == 2)
        fid = fopen([pwd filesep 'resultsARCDP.csv'], 'a');
    end
    fprintf(fid, '%s, ', results.p_name);
    fprintf(fid, '%f, %f, %f, %f, %f\n', ...
         results.nonOptimized_Accuracy, results.nonOptimized_stdDEV,...
         results.optimized_Accuracy, results.optimized_stdDEV, results.test_Accuracy);
    fclose(fid);
end



