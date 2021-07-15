% return the ancestor of node i
% every entry in tree points to its parent
% e.g. tree(i) = p, means node i's parent is p
% root is node 1, and root points to 0
% 2016/5/3 
function [ A ] = tree_Ancestor_gsx( varargin)
   tree = varargin{1};
   tree_mid = tree(:,2);
   i = varargin{2};
   if(length(varargin)==3)     
        self = varargin{3};
    else
        self = 0;
    end
    
A = [];
if (self)
    A(1) = i;
end

node = tree(find(tree(:,1)==i),2);
A = node;
while (tree((tree(:,1) == node),2)~=0)
    A(end+1) = tree((tree(:,1) == node),2);
     node = tree((tree(:,1) == node),2);
end

end

