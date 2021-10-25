function net = trainNN(X, y)
    x = X';
    t = prepareTarget(y)';
    net = patternnet(10);
    net.trainParam.showWindow=0;
    [net, tr] = train(net,x,t);
end
