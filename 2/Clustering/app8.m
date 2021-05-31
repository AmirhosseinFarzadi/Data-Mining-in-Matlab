clc;
clear;
close all;

n=500;

r1=0.8;
X1=r1*randn(n,2);

r2=3;
r3=4;
R=unifrnd(r2,r3,[n 1]);
theta=unifrnd(-pi/2,+pi/2,[n 1]);
X2=[R.*cos(theta) R.*sin(theta)];

X=[X1; X2];

plot(X(:,1),X(:,2),'.');

save('mydata5','X');
