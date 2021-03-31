function [row_index column_index]= CPSSCC(X,Row_label,Column_label,Rc,Cc)
%
% Constraint Co-projections for Semi-supervised Co-clustering (CPSSCC)
% 
% ATTN: This package is free for academic usage. The code was developed by Mr. S. Huang (huangshudong@my.swjtu.edu.cn). You can run
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
[m,n]=size(X);
Lambda=zeros(n+m,n+m);
   %parameter: gamma_o in (0,1],can be set by Eq(20) or according to the specific
   %needs
   gamma_o=1;
   %parameter: gamma_f in (0,1],can be set by Eq(21) or according to the specific
   %needs
   gamma_f=1; 
    % Generate object constraints
    [C_o M_o]=gencons_bag(Row_label,Rc); 
    n_Co=sum(sum(C_o~=0));
    n_Mo=sum(sum(M_o~=0));
    OS=C_o/n_Co-(M_o/n_Mo)*gamma_o;    
    OD=diag(sum(OS));    
    OL=OD-OS;
    %
    [C_f M_f]=gencons_bag(Column_label,Cc);
    n_Cf=sum(sum(C_f~=0));
    n_Mf=sum(sum(M_f~=0));
    FS=C_f/n_Cf-(M_f/n_Mf)*gamma_f;    
    FD=diag(sum(FS));    
    FL=FD-FS;
    % \Lambda_oo
    Lambda_oo=X'*OL*X;   
    Lambda_oo=(Lambda_oo+Lambda_oo')/2;
    % \Lambda_ff
    Lambda_ff=X*FL*X';   
    Lambda_ff=(Lambda_ff+Lambda_ff')/2;
    % \Lambda
    Lambda(1:n,1:n)=Lambda_oo;
    Lambda(1+n:end,1+n:end)=Lambda_ff;
    [eigvector,eigvalue] = eig(Lambda);
    [junk, index] = sort(-diag(eigvalue));
    dim=max(2,sum(diag(eigvalue)>0));
    %dimensions of new space can be set in next steps 
    W=eigvector(:,index(1:min(n/2,dim)));
    U=W(1:n,:);
    V=W(n+1:end,:);
    Z_r=X*U;
    Z_c=X'*V;
    %the number of row clusters
    k=length(unique(Row_label));
    row_index = kmeans(Z_r,k);
    %the number of column clusters
    l=length(unique(Column_label));
    column_index = kmeans(Z_c,l);
   

   