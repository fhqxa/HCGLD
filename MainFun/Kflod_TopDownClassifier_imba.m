%% 10-fold
%% Written by Hong Zhao
% 2017-4-11
%% Modefied by Shunxin Guo
% 2020-09-22
%% Input
%  data
%  numFolds
%  indices = varargin{4};
%% Output
function [accuracyMean,accuracyStd,FHMean,TIEMean,PredLabel,RealLabel] = Kflod_TopDownClassifier_imba(data,numFolds,tree,flag,few_model, SCTree, FewClass,sita)
[M,N]=size(data);
accuracy_k = zeros(1,numFolds);
rand('seed',1);
indices = crossvalind('Kfold',data(1:M,N),numFolds);


for k = 1:numFolds
    testID = (indices == k);
    trainID = ~testID;
    test_data = data(testID,1:end-1);
    test_label = data(testID,end);
    train_data = data(trainID,:);
    RealLabel{k} = test_label;
    %% Creat subtable
    [trainDataMod, trainLabelMod] = creatSubTable(train_data, tree);
    
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Train classifiers of all internal nodes
    numNodes = length(tree(:,1));%ZH: The total of all nodes.
    for i = 1:numNodes
        if (~ismember(i, tree_LeafNode(tree)))
            [model{i}]  = train(double(sparse(trainLabelMod{i})), sparse(sparse(trainDataMod{i})), '-c 2 -s 0 -B 1 -q');
        end
    end
    
    %%           Prediction       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if (flag == 1)
    [predict_label] = TopDownPrediction_all(test_data, model, tree,few_model, SCTree, FewClass,sita);
    predict_label = predict_label';
    PredLabel{k} = predict_label;
    else
   [predict_label] = topDownPredictionComputeAll(test_data,test_label, model, tree);
    end
    %%          Envaluation       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   [PH(k), RH(k), FH(k)] = EvaHier_HierarchicalPrecisionAndRecall(test_label,predict_label,tree);
   %[P_LCA(k),R_LCA(k),F_LCA(k)] = EvaHier_HierarchicalLCAPrecisionAndRecall(test_label,predict_label,tree);
      TIE(k) = EvaHier_TreeInducedError_gsx(M,test_label,predict_label,tree);
   accuracy_k(k) = EvaHier_HierarchicalAccuracy_gsx(test_label,predict_label);
end
 accuracyMean = mean(accuracy_k);
 accuracyStd = std(accuracy_k);
%F_LCAMean=mean(F_LCA);
FHMean=mean(FH);
TIEMean = mean(TIE);
end