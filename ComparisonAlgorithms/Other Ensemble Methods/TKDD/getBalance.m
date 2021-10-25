function stdev = getBalance(Ytrain)
    y = Ytrain;
    classes = unique(y);
    noOfClasses = length(unique(y));
    a = zeros(1,noOfClasses);
    index=1;
    for i=1:length(classes)
        a(1,index) = sum(y==classes(i))/length(y);
        index= index + 1;
    end
    
     %sum(round(abs(a-mean(a))))/length(a)
    
     %%CHECK CLUSTER CLASS DISTRIBUTIONS
%          d=size(a,2); 
%          balance = (norm(a(1,:))*sqrt(d)-1) / (sqrt(d)-1) ; 
    stdev = std(a)     ;
    
    d=size(a,2); 
    l2 = (norm(a(1,:))*sqrt(d)-1) / (sqrt(d)-1) ; 
    
end