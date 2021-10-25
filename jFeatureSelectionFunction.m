% Fitness Function KNN (9/12/2020)

function cost = jFeatureSelectionFunction(feat,label,X,num)
% Default of [alpha; beta]
ws = [0.9; 0.1];

% Check if any feature exist
if sum(X == 1) == 0
  cost = 1;
else
  % Error rate
  error    = jwrapper_KNN(feat(:,X == 1),label,num);
  % Number of selected features
  num_feat = sum(X == 1);
  % Total number of features
  max_feat = length(X); 
  % Set alpha & beta
  alpha    = ws(1); 
  beta     = ws(2);
  % Cost function 
  cost     = alpha * error + beta * (num_feat / max_feat); 
end
end


%---Call Functions-----------------------------------------------------
function error = jwrapper_KNN(sFeat,label,num)
data = [sFeat,label];
k = 3;
Md = cvpartition(data(:,end),'KFold',5);
for i = 1 : 5
% Define training & validation sets
testIdx = Md.test(i);
xtrain   = sFeat(~testIdx,:); ytrain  = label(~testIdx);
xvalid   = sFeat(testIdx,:);  yvalid  = label(testIdx);
% Training model
if num == 1
   My_Model = fitcdiscr(xtrain,ytrain, 'discrimtype','diaglinear');
%    My_Model = fitcensemble(xtrain,ytrain,'Method', 'RUSBoost');
elseif num == 2
   My_Model = fitctree(xtrain,ytrain);
elseif num == 3
   My_Model = fitcknn(xtrain,ytrain,'NumNeighbors',k);
elseif num == 4
   My_Model = trainNN(xtrain,ytrain);
elseif num == 5
   radial=templateSVM('KernelFunction','rbf','IterationLimit',50000,'Standardize',true);   
   My_Model = fitcecoc(xtrain,ytrain, 'learners', radial, 'ClassNames',[unique(ytrain)]);
%    My_Model = fitcensemble(xtrain,ytrain,'Method','bag');
elseif num == 6
   My_Model = fitcnb(xtrain,ytrain, 'distribution', 'kernel');
end
if num == 4
   pred  = getNNPredict(My_Model,xvalid);
else
   pred     = predict(My_Model,xvalid);
end
% Acc(i) = fusion(classifiers,[xvalid,yvalid]);
% Accuracy
Acc(i)   = sum(pred == yvalid) / length(yvalid);
end

% Error rate
error    = 1 - mean(Acc); 
end












