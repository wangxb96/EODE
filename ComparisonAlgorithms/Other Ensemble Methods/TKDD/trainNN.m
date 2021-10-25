function net = trainNN(X, y)
x = X';
t = prepareTarget(y)';
net = patternnet(100);
net.trainParam.showWindow=0;
net = train(net,x,t);
end
