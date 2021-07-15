%% Top-down imblance prediction
% Written by Shunxin Guo
%%
function [predict_label] = TopDownPrediction_RF(input_data, model, tree, FewClass)
     root = tree((tree(:,2)==0),1);     
    %% �ȴ�������ʼ
     currentNode = predict(model{root}, input_data);
     currentNode = str2num(currentNode{1,1});
     %% �ݹ�����м��ֱ��Ҷ�ӽ��
       while(~ismember(currentNode,FewClass))
          currentNode = predict(model{currentNode}, input_data);
          currentNode = str2num(currentNode{1,1});
        end
        predict_label = full(currentNode);        
end