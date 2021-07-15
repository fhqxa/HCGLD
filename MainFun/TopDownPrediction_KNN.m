%% Top-down imblance prediction
% Written by Shunxin Guo
%%
function [predict_label] = TopDownPrediction_KNN(input_data, model, tree, FewClass)
     root = tree((tree(:,2)==0),1);     
    %% Start with the root of the tree
     currentNode = predict(model{root}, input_data);
     %% Recursively call the middle layer until the leaf node
       while(~ismember(currentNode,FewClass))
          currentNode = predict(model{currentNode}, input_data);
        end
        predict_label = full(currentNode);        
end
