clc;
clear;
close all;

%% Load Data
data=load('bodyfat.mat');
Inputs=data.bodyfatInputs;
Targets=data.bodyfatTargets;

nData=size(Inputs,2);

for i=1:size(Inputs,1)
%     % Linear Normalization
%     Min=min(Inputs(i,:));
%     Max=max(Inputs(i,:));
%     Inputs(i,:)=(Inputs(i,:)-Min)/(Max-Min);
    
    % Statistical Normalization
    Inputs(i,:)=(Inputs(i,:)-mean(Inputs(i,:)))/std(Inputs(i,:));
end

%% RBF

Goal=0;
Spread=3;
MaxNeurons=50;
DisplayAt=1;
net=newrb(Inputs,Targets,Goal,Spread,MaxNeurons,DisplayAt);

outputs = net(Inputs);

errors=Targets-outputs;

figure;

subplot(2,2,[1 2]);
plot(Targets,'r');
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

