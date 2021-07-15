%% Top-down prediction
% Written by Yu Wang 
% Modified by Hong Zhao
% 2017-4-11
%% Inputs:
% input_data: training data without labels
% model: 
% tree: the tree hierarchy
%% Output

function [predict_label] = TopDownPrediction_all(input_data, model, tree, few_model,  SCTree, FewClass,sita)
    
    [m,~]=size(input_data);
    root = find(tree(:,1)==0);     
	for j=1:m%The number of samples
%% Start with the root of the tree
        [~,~,d_v] = predict(1,sparse(input_data(j,:)), model{root}, '-b 1 -q');
        [~,currentNodeID] = max(d_v);
        currentNode=model{root}.Label(currentNodeID) ;
    %% Recursively call the middle layer until the leaf node
       while(~ismember(currentNode,tree_LeafNode(tree)))
          [~,~,d_v] = predict(1,sparse(input_data(j,:)),  model{currentNode}, '-b 1 -q');
          [~,currentNodeID] = max(d_v);
          currentNode = model{currentNode}.Label(currentNodeID);
        end
        predict_label(j)=currentNode;   
        if(max(d_v)< sita)
              predict_label(j) = TopDownPrediction_KNN(sparse(input_data(j,:)), few_model, SCTree, FewClass)
%             predict_label(j) = TopDownPrediction_RF(input_data(j,:), few_model, SCTree, FewClass)
        
        end
    end %%endfor    
end
