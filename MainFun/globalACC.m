%% Find the global accuracy
%% Written by Shunxin GUO

clear
clc
dataSetCand = {'VOC20'}
n_datasets = length(dataSetCand);
for r = 1:n_datasets
ds = 1;
dataSet = dataSetCand{ds};
dataSetTest_data = [dataSet '.mat'];
dataSetTest = [dataSet '_TopDown_imbalance_ave_KNN1_new.mat'];
%  dataSetTest = [dataSet '_Pred_set_wang.mat'];
dataTest = importdata(dataSetTest);
dataTest_data = importdata(dataSetTest_data);
class = dataTest_data.data_array(:,end);
account = tabulate(class(:));
%% imbalance
% [~,index] = max(dataTest.accuracyMean);
real_cell =  dataTest.RealLabel{1,6};
predict_cell =  dataTest.PredLabel{1,6};
%% TDLR
% real_cell =  dataTest.RealLabel{1,1};
% predict_cell =  dataTest.PredLabel{1,1};
%% Find the best cell among all thresholds
predict = [];
real = [];
for i =1:length(real_cell)
    real = [real;real_cell{1,i}];
    predict = [predict;predict_cell{1,i}];
end
%% Find the correct rate for each category
for j = 1:max(account(:,1))
   [cow,~]=  find(real == j);
   c = predict(cow);
   classTrue(j)= sum( c(:) == j) / length(cow);% accuracy
end
%% global accuracy
errorAll = sum((real - predict)~=0) / length(real);
trueAll = 1 - errorAll;
%%
FilePathFull = ['F:\All Code\Third_imbalance\code_result\' dataSet];
    if (~exist(FilePathFull))
        mkdir(FilePathFull);
    end
        filename = [dataSet '_all_classAccuracy.mat' ];
        fullFileName = fullfile(FilePathFull, filename);
        save(fullFileName, 'classTrue','errorAll','trueAll'); 
        classTrue = [];
end
