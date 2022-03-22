%input parameters
%plot the region
%corner points
%intersection points
%find feasible region
%optimal soln

%max z=2x1+x2
%st. x1+2x2<=10 ;x1+x2<=6; x1-2x2<=1;x1,x2>=0
clear all;
clc
format rat

%input parameter
c=[2,1]
a=[1 2;1 1;1 -2]
b=[10;6;1]

%plotting
p=max(b)
x1=0:1:max(b)
x12=(b(1)-a(1,1).*x1)/(a(1,2));
x22=(b(2)-a(2,1).*x1)/(a(2,2));
x32=(b(3)-a(3,1).*x1)./(a(3,2));
x12=max(0,x12);
x22=max(0,x22);
x32=max(0,x32);
plot(x1,x12,'r',x1,x22,'b',x1,x32,'g');
title('x1 vs x2')
xlabel('Value of x1')
ylabel('Value of x2')

%corner points
cx1=find(x1==0)
c1=find(x12==0)
line1=[x1(:,[cx1,c1]);x12(:,[cx1,c1])]'
c2=find(x22==0)
line2=[x1(:,[cx1,c2]);x22(:,[cx1,c2])]'
c3=find(x32==0)
line3=[x1(:,[cx1,c3]);x32(:,[cx1,c3])]'
corpt=unique([line1;line2;line3],'rows')

%intersection
pt=[0;0]
for i=1:size(a,1)
a1=a(i,:)
b1=b(i,:)
for j=i+1:size(a,1)
a2=a(j,:);
b2=b(j,:);
a4=[a1;a2];
b4=[b1;b2];
x=a4\b4
pt=[pt x]
end
end
ptt=pt'
allpoint=[ptt;corpt]
points=unique(allpoint,'rows')
%feasible region
PT=constraint(points)