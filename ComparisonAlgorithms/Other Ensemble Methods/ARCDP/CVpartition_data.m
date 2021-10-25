function CVpartition_data(numOfFolds)
cd 'Datasets' 
Problem = dir('*.mat')';
cd ..
path=[pwd, filesep, 'Data'];
mkdir(path);
def.MaxLayer=numOfFolds;
for p=1: length(Problem)
    try
    temp = split(Problem(p).name,'.');
    p_name = temp{1};
    path1=[path, filesep, p_name];
    mkdir(path1);
    data = load(['Datasets', filesep, p_name]); 
    D=data.X;
    X=DataNormalization(D,1);
    Y=data.y;
    def.label=unique(Y);
    if(def.label(1)==0), Y=Y+1; end
    def.label=unique(Y);
    
    %k-fold validation
    k=10;
    cvFolds = crossvalind('Kfold', Y, k);        
    cd(path1);
    save('Param','def');
    for i=1:k
        testIdx = (cvFolds == i);                
        trainIdx = ~testIdx;
        dtrX=X(trainIdx,:);
        dtrY=Y(trainIdx,:);
        dtsX=X(testIdx,:);
        dtsY=Y(testIdx,:);
        save([p_name,'-CV-tr-',num2str(i)],'dtrX','dtrY');
        save([p_name,'-CV-ts-',num2str(i)],'dtsX','dtsY');
    end
    catch e
        disp(sprintf('Check the format of dataset %s', p_name))
        continue
    end
    cd ..;
    cd ..;
end
end