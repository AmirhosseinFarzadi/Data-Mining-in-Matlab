clc;
clear;
close all;

n=100;

x=unifrnd(-1,1,[n 1]);

a=2;
b=10;
sigma=0.5;
y=a*x.^2+b+sigma*randn(size(x));

X=[x.^2 x ones(n,1)];
Y=y;

theta=pinv(X)*Y;

xmin=min(x);
xmax=max(x);
xx=linspace(xmin,xmax,1000);
yy=theta(1)*xx.^2+theta(2)*xx+theta(3);

figure;
plot(x,y,'o');
hold on;
plot(xx,yy,'r','LineWidth',2);
legend('Data','Linear Model (LS)');
xlabel('x');
ylabel('y');



