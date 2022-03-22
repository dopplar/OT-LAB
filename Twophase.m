clc
clear all;
originalC=[-7.5 3 0 0 0 -1 -1 0];
info=[3 -1 -1 -1 0 1 0 3; 1 -1 1 0 -1 0 1 2];
bv=[6 7];

%PHASE-1
cost=[0 0 0 0 0 -1 -1 0];
A=info;
[m,n]=size(A);
startBV=find(cost<0)
zjcj=cost(bv)*A-cost;
zcj=[zjcj;A];
simptable=array2table(zcj);
simptable.Properties.VariableNames(1:n)={'x1','x2','x3','s1','s2','a1','a2','sol'}

flag=true;
while(flag)
    zc=zjcj(1:end-1);
    if any (zjcj<0);
     fprintf('The current BFS is not optimal');

[Enter_var,pvt_col]=min(zc);
if all (A(:,pvt_col<=0))
    error('The lpp is unbounded')
else
    sol=A(:,end);
    column=A(:,pvt_col);
    for i=1:size(A,1)
     if (column(i)>=0)
         ratio(i)=sol(i)./column(i);
     else
         ratio(i)=inf;
     end
    end
    [leaving_var,pvt_row]=min(ratio);
    end
    bv(pvt_row)=pvt_col;
    pvt_key=A(pvt_row,pvt_col);
    A(pvt_row,:)=A(pvt_row,:)./pvt_key;
for i = 1:m
    if i~=pvt_row
    A(i,:)=A(i,:) - A(i,pvt_col).*A(pvt_row,:);
    end
end
    zjcj=zjcj-zjcj(pvt_col).*A(pvt_row,:)
    zcj=[zjcj;A];
    table=array2table(zcj);
    table.Properties.VariableNames(1:n)={'x1','x2','x3','s1','s2','a1','a2','sol'}
else

    flag=false;
    fprintf('The BFS is bounded');
end
end