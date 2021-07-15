function [SCTree] = Spectralclustering_few_class(dataset,FewClass)
[m,n] = size(dataset);
len = length(unique(dataset(:,end)));
for i = 1:len
    fin = find(dataset(:,end) == i);
    data_cell{i} = dataset(fin,1:end-1);
    su(:,i) = sum(data_cell{i})./length(fin);
    if isnan(su(:,i))
        su(:,i) = 0.0001;
    end
    data_cellLable{i} = dataset(fin,end);
end
X = su';

mex dist2aff.cpp  ;
mex evrot.cpp;
% mex scale_dist.cpp ;


%%%%%%%%%%%%%%%% Parameters
neighbor_num = 10;         %% Number of neighbors to consider in local scaling
scale = 0.04;              %% Scale to use for standard spectral clsutering
 
%%%%%%%%%%%%%
AUTO_CHOOSE = 1;
CLUSTER_NUM_CHOICES = [2,3,4,5];

%%%%%%%%%%%%%%% cluster all datasets
%%%%%%%%%%%%%%% cluster all datasets
%     X = X;
%     nGroups = 2;
%      
%     %% centralize and scale the data
%     X = X - repmat(mean(X),size(X,1),1);
%     X = X/max(max(abs(X)));
% 
%     %%%%%%%%%%%%%%%%% Build affinity matrices
%     D = dist2(X,X);              %% Euclidean distance
%     A = exp(-D/(scale^2));       %% Standard affinity matrix (single scale)
    
[n,~]=size(X);
% 全连接欧式距离矩阵dis_all
dis_all = L2_distance_1(X',X'); % 平方距离
dis_all(find(dis_all<0)) = 0;
dis_all = sqrt(dis_all);

% 使用KNN计算欧式距离最近的 '第k个'点sigma，保留n个样本的第k近距离结果sigma(n,1)
[dumb,idx] = sort(dis_all, 2); % sort each row
index=idx(:,floor(neighbor_num/2)+1);

sigma = zeros(n,1);
for i=1:n
    sigma(i) = sqrt(sum((X(i,:)- X(index(i),:)).^2));
     if isnan(sigma(i))
        sigma(i) = 0.0001;
    end
end

%构造selftuning下的affinity矩阵A
A=zeros(n,n);
for i = 1:n                   
    for j=1:n
        if i ~= j
            A(i,j) = exp((-sum((X(i,:)-X(j,:)).^2))/(sigma(i)*sigma(j)));
            if isnan(A(i,j))
                A(i,j) = 0.0001;
            end
        end
    end
        
end

D = diag(sum(A,2));
Dn1 = D^(-0.5);
A_LS = Dn1*A*Dn1; %前c个最大,An是拉普拉斯矩阵
clear Dn;
A_LS = max(A_LS,A_LS');


    
%     [D_LS,A_LS,LS] = scale_dist(D,floor(neighbor_num/2)); %% Locally scaled affinity matrix 局部标度亲和矩阵 
%     clear D_LS; clear LS;
    
    %% Zero out diagonal
    ZERO_DIAG = ~eye(size(X,1));
    A = A.*ZERO_DIAG;
    A_LS = A_LS.*ZERO_DIAG;

    %%%%%%%%%%%%%%%%% Clustering
    %%%%%%%%%%%%%%% Standard spectral clustering (STD)标准谱聚类
%     clusts_STD = gcut(A,nGroups);
%  
% 
%     %%%%%%%%%%%%%%% ZelnikPerona Locally Scaled clustering (LS)ZelnikPerona局部尺度聚类
%     clusts_LS = gcut(A_LS,nGroups);

    %%%%%%%%%%%%%%% ZelnikPerona Rotation clustering with local scaling
    %%%%%%%%%%%%%%% (RLS) 具有局部尺度的ZelnikPerona旋转聚类
    if(AUTO_CHOOSE == 0)
        clusts_RLS = cluster_rotate(A_LS,nGroups);
        rlsBestGroupIndex = 1;
    else
        [clusts_RLS, rlsBestGroupIndex, qualityRLS] = cluster_rotate(A_LS,CLUSTER_NUM_CHOICES,0,1);
        fprintf('column %d\n', j);
        fprintf('RLS qualities: \n');
        qualityRLS
        fprintf('RLS automatically chose best group index as %d (%d clusters)\n', rlsBestGroupIndex, length(clusts_RLS{rlsBestGroupIndex}));
    end

    %%%%%%%%%%%%%%% ZelnikPerona Rotation clustering without local scaling (R)
%     if(AUTO_CHOOSE == 0)
%         clusts_R = cluster_rotate(A,nGroups);
%         rBestGroupIndex = 1;
%     else
%         [clusts_R, rBestGroupIndex, qualityR] = cluster_rotate(A, CLUSTER_NUM_CHOICES);
%         fprintf('R qualities: \n');
%         fprintf('R automatically chose best group index as %d (%d clusters)\n', rBestGroupIndex, length(clusts_R{rBestGroupIndex}));
%     end
  data = clusts_RLS{rlsBestGroupIndex} ;
%   for i = 1:length(data)
%        point_id = data{i};
%         for v = 1:length(point_id)
%             point = FewClass(point_id);
%             SCTree(point,1) = len+i;
%             SCTree(point,2) = 2;
%         end
%    end
%    for u = 1:length(data)
%         SCTree = [SCTree;len+length(data)+1,1];
%    end
%         SCTree = [SCTree;0,0];
  mid = max(FewClass);
  SCTree = [];
   for i = 1:length(data)
       point = data{i};
       tree = [];
        for v = 1:length(point)
            tree(v,1) = FewClass(point(v));
            tree(v,2) = mid+i;
            tree(v,3) = 2;
        end
        [SCTree] = [SCTree;tree];
   end
   for u = 1:length(data)
        SCTree = [SCTree;mid+u,mid+1+length(data),1];
   end
        SCTree = [SCTree;mid+1+length(data),0,0];
end

function d = L2_distance_1(a,b)
% compute squared Euclidean distance
% ||A-B||^2 = ||A||^2 + ||B||^2 - 2*A'*B
% a,b: two matrices. each column is a data
% d:   distance matrix of a and b

if (size(a,1) == 1)
  a = [a; zeros(1,size(a,2))]; 
  b = [b; zeros(1,size(b,2))]; 
end

aa=sum(a.*a); bb=sum(b.*b); ab=a'*b; 
d = repmat(aa',[1 size(bb,2)]) + repmat(bb,[size(aa,2) 1]) - 2*ab;

d = real(d);
d = max(d,0);
end