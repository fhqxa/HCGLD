%% Top-down imblance prediction
% Written by Shunxin Guo
%% Inputs:
% input_data: training data without labels
% model: 
% tree: the tree hierarchy
% ���㵥��·��
%% Output

function [predict_label] = TopDownPrediction_imbalance(input_data, model, tree,FewClass)
    
    [m,~]=size(input_data);
    root = tree((tree(:,2)==0),1);     
	for j=1:m%The number of samples
%% �ȴ�������ʼ
        currentNode = predict(model{root}, input_data(j,:));
%         predict_label = predict(mdl, test_data);
    %% �ݹ�����м��ֱ��Ҷ�ӽ��
       while(~ismember(currentNode,FewClass))
          currentNode = predict(model{currentNode}, input_data(j,:));
        end
        predict_label(j)=currentNode;        
    end %%endfor  
    predict_label = full(predict_label);
end
