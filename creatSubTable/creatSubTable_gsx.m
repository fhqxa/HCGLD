%% Top-down prediction
% Written by Yu Wang 
% Modified by Hong Zhao
% 2017-4-11
% Modified by Shunxin Guo
% 2020-09-17
%% ����ӱ�
function [DataMod,LabelMod]=creatSubTable_gsx(dataset, tree,FewClass)
  Data = dataset(:,1:end-1);
  Label =  dataset(:,end);
 [numTrain,~] = size(dataset);
 numNodes = length(tree(:,2));%ZH: The total of all nodes.
   for i = 1:numNodes %���ΪʲôҪ�������н���أ�Ҷ�ӽ��û������ģ�����������
            if (~ismember(tree(i,1), FewClass)) %% �������Ҷ�ӽ��
            cur_descendants = tree_Descendant_gsx(tree, tree(i,1));%%��һ���������
        %     if (~isempty(cur_descendants))  
                 % Select data of descendant nodes
            ind_d = 1;  % index for id subscript increment
            id = [];        % data whose labels belong to the descendants of the current nodes
            for n = 1:numTrain%%ѡ�ӱ�
                if (ismember(Label(n), cur_descendants) ~= 0)
                    id(ind_d) =  n;
                    ind_d = ind_d +1;
                end
            end
            Label_Uni_Sel = Label(id,:);
            DataSel = Data(id,:);     %��:������������% select relative training data for the current classifier
            numTrainSel = size(Label_Uni_Sel,1);
              % classifiers are not at the leaf nodes
                % Transform the labels of descendants to children labels of the
                % current node
                LabelUniSelMod = label_modify_MLNP_gsx(Label_Uni_Sel, tree(i,1), tree);%% �����
                % Get the sub-training set containing only relative nodes
                ind_tdm = 1;
                index = [];     % data whose labels belong to the children of the current nodes
                children_set = get_children_set_gsx(tree, tree(i,1));
                for ns = 1:numTrainSel
                    if (ismember(LabelUniSelMod(ns), children_set) ~= 0)
                        index(ind_tdm) =  ns;
                        ind_tdm = ind_tdm +1;
                    end
                end
                DataMod{tree(i,1)} = DataSel(index, :);   % Find the sub training set of relative to-be-classified nodes
                LabelMod{tree(i,1)} = LabelUniSelMod(index, :);
                
%                 X{i}=[DataMod,LabelMod];
     %           model{i} = multiclassMLNP_learningzh(sparse(trainDataMod), sparse(trainLabelMod), i);%children_set, tree, i);
            end%%%wang yu
   end
        
end