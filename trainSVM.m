%%collects classifiers and stores them in an array.
function [classifier] = trainSVM(X, y, valX, valY)
radial=templateSVM('KernelFunction','rbf','IterationLimit',50000,'Standardize',true);
linear = templateSVM('KernelFunction','linear','IterationLimit',50000,'Standardize',true);
polynomial = templateSVM('KernelFunction','polynomial','IterationLimit',50000,'Standardize',true);
try 
    rbf.name = 'SVM';
    rbf.model = fitcecoc(X, y, 'learners', radial, 'ClassNames',[unique(y)]);
    
    lin.name = 'SVM';
    lin.model = fitcecoc(X, y, 'learners', linear, 'ClassNames',[unique(y)]);
    
    poly.name = 'SVM';
    poly.model = fitcecoc(X, y, 'learners', polynomial, 'ClassNames',[unique(y)]); 
    
    predictRbf = predict(rbf.model, valX);
    predictLin = predict(lin.model, valX);
    predictPoly = predict(poly.model, valX);
    accRbf = mean(predictRbf == valY);
    accLin = mean(predictLin == valY); 
    accPoly = mean(predictPoly == valY);
    
    temp = [accRbf, accLin, accPoly];
    [~, idxs] = max(temp);
    if idxs == 1
        classifier = rbf;
    elseif idxs == 2
        classifier = lin;
    elseif idxs == 3
        classifier = poly;
    else
        classifier = rbf;
    end    
%     if accRbf > accLin
%         classifier = rbf;
%     elseif accLin > accRbf
%         classifier = lin;
%     else
%         classifier = rbf;
%     end
catch exc
    disp(sprintf('something happened in training %s \n', exc.identifier));
end

end