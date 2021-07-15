%% Get the direct children nodes of the current node
function children_set = get_children_set_gsx(tree, cur_node)
cur_descendants = tree_Descendant_gsx(tree, cur_node);
if (isempty(cur_descendants))
    children_set = [];
else
    children_set = tree(find(tree(:,2) == cur_node),1);
end