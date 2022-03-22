clc;
clear all;
n=2;
A = [-1 1; 1 1];  %coefficients
b =[1;2];       %soln
c = [1; 2] ;
[m,n]=size(A);  %m=2 and n=2
s = eye(m);  % s= 2X2 identity matrix
A = [A s b] ;
bv = n+1 : 1:n+m;
cost=zeros(1,n+m+1);
cost(1:n)=c;
zjcj = cost(bv) * A -cost;
zcj = [zjcj ; A];
simptable = array2table(zcj);
simptable.Properties.VariableNames(1:n+m+1) = {'x1', 'x2' , 's1' , 's2' , 'soln'}

flag = true;
while(flag)
    zc = zjcj(1: end-1);
    if any(zjcj<0)
        fprintf('The Current BFS is not optimal. \n');
        
        [Enter_val, pvt_col] = min(zc);
        if all(A(:,pvt_col <=0))
            error('LPP is unbounded. ');
        else
            sol = A(:,end);
            column = A(:,pvt_col);
            for i =1:size(A,1)
                if(column(i) >= 0)
                    ratio(i) = sol(i)/column(i);
                else
                    ratio(i) =inf;
                end
            end
            [leaving_var, pvt_row] = min(ratio);
        end
        bv(pvt_row)=pvt_col;
        pvt_key=A(pvt_row, pvt_col);
        A(pvt_row,:)=A(pvt_row,:)./pvt_key;
        for i=1:m
            if i~=pvt_row
                A(i,:)=A(i,:)-A(i,pvt_col).*A(pvt_row,:);
            end
        end
        zjcj=zjcj-zjcj(pvt_col).*A(pvt_row,:);
        zcj=[zjcj;A];
        table=array2table(zcj);
        table.Properties.VariableNames(1:n+m+1)={'x1', 'x2' , 's1', 's2', 'soln'}
    else
        flag=false;
        fprintf('The current BFS is Optimal.\n');
    end
end