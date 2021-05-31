clc;
clear;
close all;

data=load('mydata4');
X=data.X;

k=3;
[IDX, C]=kMedoids(X,k);

Colors=hsv(k);
for i=1:k
    Xi=X(IDX==i,:);
    plot(Xi(:,1),Xi(:,2),'o','MarkerSize',10,'Color',Colors(i,:));
    hold on;
    plot(C(i,1),C(i,2),'ks','MarkerSize',12,'MarkerFaceColor',Colors(i,:));
end
