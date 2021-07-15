
function [FewClass,acc,acc_few] = account_class(data_array)
[M,~] = size(data_array);
classNum = max(data_array(:,end));
for i = 1:classNum
    acc(i) = length(find(data_array(:,end) == i ));
end
for i = 1:classNum
    acc_few(i) = length(find(acc(i) < (M/classNum) ));
end
% ÕÒµ½
FewClass = find(acc_few(:) == 1);
end