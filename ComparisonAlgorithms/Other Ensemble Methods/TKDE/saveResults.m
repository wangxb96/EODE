function rs = saveResults(results)
  fid = [];
    if (exist([pwd filesep 'resultsTKDE.csv'], 'file') == 0)
        fid = fopen([pwd filesep 'resultsTKDE.csv'], 'w');
        fprintf(fid, '%s, %s, %s, %s, %s, %s, %s\n', ...
            'Data Set','Avg Accuracy', 'Std. Dev', 'Optimized Acc', 'Std. Dev', 'test Accuracy', 'Class Number');
    elseif (exist([pwd filesep 'resultsTKDE.csv'], 'file') == 2)
        fid = fopen([pwd filesep 'resultsTKDE.csv'], 'a');
    end
    fprintf(fid, '%s, ', results.p_name);
    fprintf(fid, '%f, %f, %f, %f, %f, %f\n', ...
         results.nonOptimized_Accuracy, results.nonOptimized_stdDEV,...
         results.optimized_Accuracy, results.optimized_stdDEV, results.test_Accuracy ,results.eachClass);
    fclose(fid);
end



