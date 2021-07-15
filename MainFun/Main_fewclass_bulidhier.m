%% 少样本的类别建立树结构
clear
clc
% load data2_bridges2.mat;
dataSetCand = {'DD'};
% dataSetCand = {'ilsvrc_finetune','stanford_car_finetune',  'cifar100_finetune'};
ds = 1;
    dataSet = dataSetCand{ds};
    dataSetTest = [dataSet '.mat'];
    dataTest = importdata(dataSetTest);
    data_array = dataTest.data_array;
[FewClass,acc,acc_few] = account_class(data_array);
Y = data_array(:,end);
dataset = data_array(find((ismember(Y,FewClass,'rows'))'),1:end); 
% [A,An] = selftuning2(dataset,5)
[SCTree] = Spectralclustering_few_class(dataset,FewClass);
topDown = 1;
numFolds = 10;
% load ZHProtein27TrainFeature32;
[M,N]=size(dataset);
[accuracyMean,accuracyStd,FHMean,okTIEMean,PredLabel,RealLabel] = Kflod_TopDownClassifier_imbalance(dataset,SCTree,numFolds,topDown,FewClass);
t=toc;
FilePathFull = ['F:\All Code\Third_imbalance\' dataSet];
    if (~exist(FilePathFull))
        mkdir(FilePathFull);
    end
        filename = [ dataset '_FewClass_knn_tree.mat'];
        fullFileName = fullfile(FilePathFull, filename);
        save(fullFileName, 't','accuracyMean','accuracyStd','F_LCAMean','FHMean','okTIEMean','PredLabel','RealLabel'); 
