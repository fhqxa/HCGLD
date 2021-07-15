%%只计算预测叶子节点的正确率
%modified by wangyu
%%

function hierAcc = EvaHier_HierarchicalAccuracy_gsx(realLabel, predLabel)
num_examples = max(size(predLabel,1),size(predLabel,2));
num_rights = 0;
for i = 1:num_examples
    % construct extended label vector
    cur_node = realLabel(i);

    [isMem, ind_inters] = ismember(predLabel(i), cur_node);
    if (isMem)
        num_rights = num_rights + 1;
    end
end
hierAcc = num_rights / num_examples;
end