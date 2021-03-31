function [C M]=gencons_bag(trainlabel,p)
%function [C M]=gencons_bag(ncons,trainlabel)
% Generate constraints using Bagging similar ways
% For Copen
% c=histc(trainlabel(:),unique(trainlabel(:)));
% c=ceil(c*p);
% c=c.^2;
% cont=sum(c);
n=length(trainlabel);
C=zeros(n);
M=zeros(n);
ncons=fix(n*p);
for k=1:ncons,
    rp=randperm(n);
    rp2=randperm(n);
    count=0;
    while 1 & count<5
        if trainlabel(rp(1))==trainlabel(rp2(1))
            rp2=randsample(1:n,1);
            count=count+1;
        else
            break;
        end        
    end
    if count<5
        C(rp(1),rp2(1))=1;
        C(rp2(1),rp(1))=1;
    end
end

%generate random M
for k=1:ncons,
%while numel(find(M~=0))<cont;
    rp=randperm(n);
    rp2=randperm(n);
    count=0;
    while 1 & count<5
        if trainlabel(rp(1))~=trainlabel(rp2(1))
            rp2=randsample(1:n,1);
            count=count+1;
        else
            break;
        end        
    end
    if count<5
        M(rp(1),rp2(1))=1;
        M(rp2(1),rp(1))=1;
    end
end
