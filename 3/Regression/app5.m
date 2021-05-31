clc;
clear;
close all;

sigma=0.05;
x=linspace(0,360,500);
y=sin(pi*x/180)+sigma*randn(size(x));

inputs = x;
targets = y;

Goal=0;
Spread=90;
MaxNeurons=100;
DisplayAt=1;

net=newrb(inputs,targets,Goal,Spread,MaxNeurons,DisplayAt);

outputs = net(inputs);

errors=targets-outputs;

figure;

subplot(2,2,[1 2]);
plot(targets,'r');
hold on;
plot(outputs,'b');
legend('Targets','Outputs');
xlabel('Sample');

subplot(2,2,3);
plot(errors);
xlabel('Sample');
ylabel('Error');

subplot(2,2,4);
hist(errors,50);
title(['Mean = ' num2str(mean(errors)) ', StD = ' num2str(std(errors))]);

