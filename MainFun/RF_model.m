function [few_model] = RF_model(train_data, tree, FewClass)
    %% Creat sub table
    [trainDataMod, trainLabelMod] = creatSubTable_gsx(train_data, tree,FewClass);
    %% Train classifiers of all internal nodes
    numNodes = length(tree(:,1));%ZH: The total of all nodes.
    for i = 1:numNodes
        if (~ismember(tree(i,1),FewClass))
            few_model{tree(i,1)} = TreeBagger(10,trainDataMod{tree(i,1)},trainLabelMod{tree(i,1)}); 
        end
    end
end