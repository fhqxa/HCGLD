%% Main function
%% Top-down classification with tree hierarchy in Madantory Leaf Node Prediction.
%% Train a multi-class logistic regression classifier for each node.
%% Usage: change the input dataSat on the top,
%%               and you can change the proportion of data for training and testing at parameter 'numTrain'.
%% For performance of the classifier, change the cmd parameter in multiclassMLNP_learning.m
%% For evaluation metrics, res_acc is accuracy,
%% Hieararchical precision and recall, Hieararchical TIE-Mean, information gain and hierarchical accuracy is at the bottom of the code

clear;
clc;

%% Load information of the dataset
dataSetCand = {'DD','Cifar4096d_LongTail_2_8','Cifar4096d_LongTail_3_7','ILSVRC57Train_LongTail','cifar4096D_langtail'};
n_datasets = length(dataSetCand);
% for r = 1:n_datasets
ds = 1;
    dataSet = dataSetCand{ds};
    dataSetTest = [dataSet '.mat'];
    dataTest = importdata(dataSetTest);
    
%% Build a tree structure for categories with few samples and get a classification model
[FewClass,acc,acc_few] = account_class(dataTest.data_array);
Y = dataTest.data_array(:,end);
dataset = dataTest.data_array(find((ismember(Y,FewClass,'rows'))'),1:end); 
[SCTree] = Spectralclustering_few_class(dataset,FewClass);
%KNN MODEL
[few_model] = KNN_model(dataset, SCTree, FewClass);
%RF MODEL
% [few_model] = RF_model(dataset, SCTree, FewClass);
%%
tic
topDown = 1;
numFolds = 10;
[M,N]=size(dataTest.data_array);
for sita = 0.1:0.1:0.9
    ind = floor(sita * 10);
[accuracyMean(ind),accuracyStd(ind),FHMean(ind),okTIEMean(ind),PredLabel{ind},RealLabel{ind}] = Kflod_TopDownClassifier_imba(dataTest.data_array,numFolds,dataTest.tree,topDown,few_model, SCTree, FewClass,sita);
t(ind)=toc;
end 
FilePathFull = ['F:\All Code\Third_imbalance\code_result\' dataSet];
    if (~exist(FilePathFull))
        mkdir(FilePathFull);
    end
        filename = [dataSet '_TopDown_imbalance_ave_KNN1_new.mat' ];
        fullFileName = fullfile(FilePathFull, filename);
        save(fullFileName,'FewClass','t', 'sita','accuracyMean','accuracyStd','FHMean','okTIEMean','PredLabel','RealLabel'); 
% end
