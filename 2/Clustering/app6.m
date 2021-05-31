clc;
clear;
close all;

% load fisheriris;
% X=meas;

data=load('mydata5');
X=data.X;

k=3;
Z=linkage(X,'centroid','euclidean');
IDX=cluster(Z,'maxclust',k);

figure;
dendrogram(Z);

figure;
Colors=hsv(k);
for i=1:k
    Xi=X(IDX==i,:);
    plot(Xi(:,1),Xi(:,2),'o','MarkerSize',10,'Color',Colors(i,:));
    hold on;
end
