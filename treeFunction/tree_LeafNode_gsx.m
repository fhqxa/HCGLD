%% Return the index of the leaf node.
%% Author: Hong Zhao
%% Date: 2016-5-14
%% Example: 
% load tree;
% leafNode = LeafNode( tree )
% Modified by Shunxin Guo
% 2020-09-17
function [ leafNode ] = tree_LeafNode_gsx( tree )
    treeParent = tree(:,2)';
    lengthTree = length(treeParent);
    middleNode = [];
    while length(treeParent)~=0 
        middleNode=[middleNode; treeParent(1)];
        label=find(treeParent==treeParent(1));     
        treeParent(label)=[];   
    end
    leafNode = tree(:,1);
    leafNode = leafNode(ismember(leafNode,middleNode)==0);
end

