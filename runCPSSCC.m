clear
%
%% ATTN: This package is free for academic usage. The code was developed by Mr. S. Huang (huangshudong@my.swjtu.edu.cn). You can run
% it at your own risk. For other purposes, please contact Prof. Hongjun Wang (wanghongjun@swjtu.edu.cn)
%
% where
%   X
% Notation:
% X ... (mSmp x nFea) data matrix 
%       nFea  ... number of features
%       mSmp  ... number of samples
% Row_label     - the index, or order, of the row clusters
% Row_label     - the index, or order, of the column clusters
% Rc    - percentage of the objects_label that are randomly picked to construct row constraints
% Rc    - percentage of the features_label that are randomly picked to construct column constraints
%   k = number of row clusters
%   l = number of column clusters
%%
% References:
% [1] Shudong Huang, Hongjun Wang, Tao Li, Yan Yang, and Tianrui Li. "Constraint Co-projections for 
% Semi-supervised Co-clustering", Submitted to IEEE Transactions on Cybernetics. 
%
%
%   Written by Mr. Huang (huangshuddong@my.swjtu.edu.cn)
%
% ATTN2: This package was developed by Mr. S. Huang (huangshuddong@my.swjtu.edu.cn). For any problem concerning the code, please feel
% free to contact Mr. Huang.
%
%%
disp(['beginning...'])

load exampleData.mat;

%dataset
X=data;

%r_label
Row_label=rlabels;

%c_labels
Column_label=clabels;

%percentage of the objects_label
Rc=0.1;

%percentage of the features_label
Cc=0.1;

%co-clustering result
[row_index column_index] = CPSSCC(X,Row_label,Column_label,Rc,Cc);

%%
% show result
disp([row_index])
disp(['End...'])



