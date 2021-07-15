%% Top-down imblance prediction
% Written by Shunxin Guo
%% Inputs:
% input_data: training data without labels
% model: 
% tree: the tree hierarchy
% 计算单条路线
%% Output

function [predict_label] = TopDownPrediction_imbalance(input_data, model, tree,FewClass)
    
    [m,~]=size(input_data);
    root = tree((tree(:,2)==0),1);     
	for j=1:m%The number of samples
%% 先从树根开始
        currentNode = predict(model{root}, input_data(j,:));
%         predict_label = predict(mdl, test_data);
    %% 递归调用中间层直到叶子结点
       while(~ismember(currentNode,FewClass))
          currentNode = predict(model{currentNode}, input_data(j,:));
        end
        predict_label(j)=currentNode;        
    end %%endfor  
    predict_label = full(predict_label);
end
