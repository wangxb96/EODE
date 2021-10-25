function rs = saveResultsTraining(results)
  fid = [];
    if (exist([pwd filesep 'resultsTraining.csv'], 'file') == 0)
        fid = fopen([pwd filesep 'resultsTraining.csv'], 'w');
        fprintf(fid, '%s, %s\n', ...
            'Data Set','Avg Accuracy');
    elseif (exist([pwd filesep 'resultsTraining.csv'], 'file') == 2)
        fid = fopen([pwd filesep 'resultsTraining.csv'], 'a');
    end
    fprintf(fid, '%s, ', results.p_name);
    fprintf(fid, '%f\n', ...
         results.TrainingAcc);
    fclose(fid);
end



