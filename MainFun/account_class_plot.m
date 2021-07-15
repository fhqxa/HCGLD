%% Sort the number of samples in each category of the dataset
%% Written by Shunxin GUO
%%

clear
clc
dataSetCand = {'Cifar4096d_LongTail_3_7','Cifar4096d_LongTail_2_8','ILSVRC57Train_LongTail','cifar4096D_langtail','DD','CLEF63','protein194','VOC20','Car196Test','Sun324Test','ILSVRC57'};
%dataSetCand = {'VOC20'}
n_datasets = length(dataSetCand);
% for r = 1:n_datasets
ds = 8;
dataSet = dataSetCand{ds};
dataSetTest = [dataSet '.mat'];
dataTest = importdata(dataSetTest);
class = dataTest.data_array(:,end);
account = tabulate(class(:));
x = account(:,2);
size = 12;
y = sort(x,'descend');

pic = bar(y);
set(pic,'edgecolor','none');
axis([0 length(x)+1,0,max(x)+20])
% set(pic,'FaceColor',[0.5 0.54 0.53]);%%dd
 set(pic,'FaceColor',[0.2 0.63 0.79]);%%f194
%  set(pic, 'edgecolor', [0.8,0.8,0.8]);

% set(pic,'FaceColor',[1 0.5 0]);
set(gca,'FontName','Times New Roman','FontSize',15);
xlabel('Sorted class index','Fontname', 'Times New Roman','FontSize',18);
ylabel('Number of class samples','Fontname', 'Times New Roman','FontSize',18);
