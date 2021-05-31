clc;
clear;
close all;

N=1000;

C1=[0 0];
SIGMA1=[1 0
        0 2];
X1=mvnrnd(C1,SIGMA1,N);

C2=[4 5];
SIGMA2=[3 1
        1 1];
X2=mvnrnd(C2,SIGMA2,N);

X=[X1; X2];

[V, Y, s]=pca(X);

Y1=Y(1:N,:);
Y2=Y(N+1:end,:);

V(:,1)=sqrt(s(1))*V(:,1);
V(:,2)=sqrt(s(2))*V(:,2);

figure;

subplot(1,2,1);
plot(X1(:,1),X1(:,2),'b.');
hold on;
plot(X2(:,1),X2(:,2),'k.');
plot([0 V(1,1)],[0 V(2,1)],'r','LineWidth',3);
plot([0 V(1,2)],[0 V(2,2)],'r','LineWidth',3);
axis equal;
title('Input Space');
xlabel('x_1');
ylabel('x_2');
grid on;

subplot(1,2,2);
plot(Y1(:,1),Y1(:,2),'b.');
hold on;
plot(Y2(:,1),Y2(:,2),'k.');
title('Feature Space');
xlabel('y_1');
ylabel('y_2');
grid on;

figure;
subplot(4,1,1);
plot(X(:,1),'b');
subplot(4,1,2);
plot(X(:,2),'k');
subplot(4,1,3);
plot(Y(:,1),'r');
subplot(4,1,4);
plot(Y(:,2),'Color',[0 0.5 0]);
