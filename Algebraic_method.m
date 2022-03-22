clc;
A=[-1 1 1 0; 1 1 0 1];
B=[1;2];
v=[1 2 0 0];
[m,n]=size(A);
if(n>m)
 ncm=nchoosek(n,m);
 pair=nchoosek(1:n,m);
 sol=[];
 for i=1:ncm 
 y=zeros(n,1);
 C=A(:,pair(i,:));
 x=inv(C)*B;
 if all(x>=0 & x~=-inf & x~=inf)
 y(pair(i,:))=x;
 sol=[sol,y];
 end
 end
else
 fprintf('nCm does not exists');
end
sol
sol=sol'
for i=1: size(sol(:,1));
obj(i,:)=sum(sol(i,:).*v);
end
p=max(obj)
m=find(obj==p)
os=sol(m,:)