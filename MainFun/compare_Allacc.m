clear
clc
%  dataSetCand = {'VOC20','protein194','Car196Test','Sun324Test','ILSVRC57'};
% dataSetCand = {'VOC20'}
n_datasets = length(dataSetCand);
for r = 1:n_datasets
ds = r;
dataSet = dataSetCand{ds};
dataSetTest_data = [dataSet '.mat'];
% dataSetTest = [dataSet '_TopDown_imbalance_ave_KNN1_new.mat'];
dataSetTest = [dataSet '_HRelief_20%.mat'];
% dataSetTest = [dataSet '_Zhou_num_path1.mat'];
dataTest = importdata(dataSetTest);
dataTest_data = importdata(dataSetTest_data);
class = dataTest_data.data_array(:,end);
account = tabulate(class(:));

%[~,index] = max(dataTest.accuracyMean);
% real_cell =  dataTest.RealLabel{1,1};
% predict_cell =  dataTest.PredLabel{1,1};
%% 找到所有阈值中效果最好的cell
predict = [];
real = [];
for i =1:10
    real = [real;(dataTest.RealLabel{1,i})];
    t = (dataTest.OutLabel{1,i});
    predict = [predict;t];
end
%% 对每个类别求正确率
for j = 1:max(account(:,1))
   [cow,~]=  find(real == j);
   c = predict(cow);
   classTrue(j)= sum( c(:) == j) / length(cow);% 正确率
end
%% 整体的精度
errorAll = sum((real - predict)~=0) / length(real);
trueAll = 1 - errorAll;
%%
FilePathFull = ['F:\All Code\Third_imbalance\code_result\' dataSet];
    if (~exist(FilePathFull))
        mkdir(FilePathFull);
    end
        filename = [dataSet '_all_classAccuracy_HRelief_20%.mat' ];
        fullFileName = fullfile(FilePathFull, filename);
        save(fullFileName, 'classTrue','errorAll','trueAll'); 
        classTrue = [];
end