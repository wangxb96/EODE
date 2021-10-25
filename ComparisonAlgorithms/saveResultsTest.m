function rs = saveResultsTest(results)
  fid = [];
    if (exist([pwd filesep 'resultsTest.csv'], 'file') == 0)
        fid = fopen([pwd filesep 'resultsTest.csv'], 'w');
        fprintf(fid, '%s, %s, %s\n', ...
            'Data Set','Avg Accuracy', 'Selected Features');
    elseif (exist([pwd filesep 'resultsTest.csv'], 'file') == 2)
        fid = fopen([pwd filesep 'resultsTest.csv'], 'a');
    end
    fprintf(fid, '%s, ', results.p_name);
    fprintf(fid, '%f, %f\n', ...
         results.TestAcc, results.selectedNumber);
    fclose(fid);
end



