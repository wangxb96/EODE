clear all
clc
tic;% start the timer
Problem = {'Alizadeh-2000-v1','Alizadeh-2000-v2','Alizadeh-2000-v3','Armstrong-2002-v1','Armstrong-2002-v2','Bhattacharjee-2001','Bittner-2000',...
   'Bredel-2005','Chen-2002','Chowdary-2006','Dyrskjot-2003','Garber-2001','Golub-1999-v1','Golub-1999-v2','Gordon-2002','Khan-2001_database',...
   'Laiho-2007_database','Lapointe-2004-v1','Lapointe-2004-v2','Liang-2005','Nutt-2003-v1','Nutt-2003-v2','Nutt-2003-v3','Pomeroy-2002-v1'...
   ,'Pomeroy-2002-v2','Ramaswamy-2001_database','Risinger-2003','Shipp-2002-v1','Singh-2002','Su-2001','Tomlins-2006-v1','Tomlins-2006-v2',...
   'West-2001','Yeoh-2002-v1','Yeoh-2002-v2'};
for j = 1:length(Problem)
p_name = Problem{j};
traindata = load(['C:\Users\c\Desktop\MultiClassifiers\TrainData\',p_name]);
traindata = traindata.TrainData;
testdata = load(['C:\Users\c\Desktop\MultiClassifiers\TestData\',p_name]); 
testdata = testdata.TestData;
%% Data preprocessing
shuju=traindata;
shuju=shuju(1:end,:);
shu=zscore(shuju);%±ê×¼»¯
label=[ones(1224,1);ones(1319,1)*(-1)];
data=[zscore(traindata(:,1:end-1)),traindata(:,end)];
test = [zscore(testdata(:,1:end-1)),testdata(:,end)];
train_shu = zscore(traindata(:,1:end-1));
train_label = traindata(:,end);
test_shu = zscore(testdata(:,1:end-1));
test_label = testdata(:,end);
testlabel=[];yucelabel=[];yuzhi=[];
% train_shu = data
%% Setting parameters
% num=5;
% indices=crossvalind('Kfold',M,num);
% %% main
%  for k=1:num                     
%         indice1 = (indices == k);
%         indice2= ~indice1;       
%         train_shu=data(indice2,1:(N-1));
%         train_label=data(indice2,N);
%         test_shu=data(indice1,1:(N-1));
%         test_label=data(indice1,N);
        
%%Bagging_SVM
% Input:
%   T:Learning rounds
%   num1:the number of training sets.
%   num2:the number of random resamples of the algorithm.num2<=num1.
%   train_shu:the training set data matrix of size N*C.N is the number of
%   the training set.C is the number of sample attributes.
%   train_label:the training set data matrix of size N*1.N is the number of
%   the training set.
%   test_shu:the test set data matrix of size N*C.N is the number of
%   the test set.C is the number of sample attributes.
%   test_label:the test set data matrix of size N*1.N is the number of
%   the test set.
% Output:
%   predict_label:the prediction label obtained by the algorithm.
%   dec:the score matrix.
T=5;
[num1,NNN]=size(train_shu);
num2=fix(num1/2);
[predict_label,dec]=Bagging(T,num1,num2,train_shu,train_label,test_shu,test_label)
yucelabel=[yucelabel;predict_label'];
testlabel=[testlabel;test_label];
%yuzhi=[yuzhi;dec];
%  end
acc = mean(yucelabel == testlabel);
results.p_name = p_name;  
results.acc = acc;
saveResults(results);
end
toc;