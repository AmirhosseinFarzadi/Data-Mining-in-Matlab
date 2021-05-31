clc;
clear;
close all;

X=mvnrnd([0 0],[1 1; 1 5],5000);

[V, Y, s]=pca(X);

V(:,1)=sqrt(s(1))*V(:,1);
V(:,2)=sqrt(s(2))*V(:,2);

figure;
plot(X(:,1),X(:,2),'.');
hold on;
plot([0 V(1,1)],[0 V(2,1)],'r','LineWidth',3);
plot([0 V(1,2)],[0 V(2,2)],'r','LineWidth',3);

axis equal;
grid on;



