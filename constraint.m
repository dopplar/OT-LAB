function output=constraint(x)
format rat
x
x1=x(:,1)
x2=x(:,2)
cons1=round(x1+(2.*x2)-10)
s1=find (cons1>0)
x(s1,:)=[]
%write 2nd Constraint % all constraints are of <= sign
x1=x(:,1);
x2=x(:,2);
cons2=round ((x1+x2)-6)
s2=find(cons2>0)
x(s2,:) =[]
%write 3rd Constraint % all are of <= sign
x1=x(: , 1) ;
x2=x(: , 2) ;
cons3=round ((x1 - (2 .*x2))-1)
s3=find(cons3>0)
x(s3,:) =[]
output=x
end