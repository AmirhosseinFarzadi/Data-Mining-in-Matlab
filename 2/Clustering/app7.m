clc;
clear;
close all;

data=load('mydata5');
X=data.X;

epsilon=2.3;
MinPts=30;
IDX=DBSCAN(X,epsilon,MinPts);
k=max(IDX);

Colors=hsv(k);
for i=1:k
    Xi=X(IDX==i,:);
    plot(Xi(:,1),Xi(:,2),'o','MarkerSize',10,'Color',Colors(i,:));
    hold on;
end

