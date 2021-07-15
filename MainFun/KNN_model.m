function [few_model] = KNN_model(train_data, tree, FewClass)
    %% Creat sub table
    [trainDataMod, trainLabelMod] = creatSubTable_gsx(train_data, tree,FewClass);
    
    %% Train classifiers of all internal nodes
    numNodes = length(tree(:,1));%ZH: The total of all nodes.
    for i = 1:numNodes
        if (~ismember(tree(i,1),FewClass))
            [ few_model{tree(i,1)}] = ClassificationKNN.fit(double(sparse(trainDataMod{tree(i,1)})),sparse(trainLabelMod{tree(i,1)}),'NumNeighbors',1); 
%             [model{i}]  = train(double(sparse(trainLabelMod{i})), sparse(sparse(trainDataMod{i})), '-c 2 -s 0 -B 1 -q');
        end
    end
end