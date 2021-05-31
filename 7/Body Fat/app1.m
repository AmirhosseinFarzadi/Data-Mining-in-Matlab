clc;
clear;
close all;

%% Load Data
data=load('bodyfat.mat');
Inputs=data.bodyfatInputs;
Targets=data.bodyfatTargets;

nData=size(Inputs,2);

%% Least Square

X=[ones(1,nData)
   Inputs];

% X=[ones(1,nData)
%    Inputs
%    Inputs.^2
%    Inputs.^3
%    tanh(Inputs)];

Y=Targets;

theta=Y*pinv(X);

Yhat=theta*X;

E=Y-Yhat;

MeanError=mean(E);
ErrorStd=std(E);
MSE=mean(E.^2);
RMSE=sqrt(MSE);

%% Plot Results

figure;

subplot(2,2,[1 2]);
plot(Y,'b');
hold on;
plot(Yhat,'r');
legend('Targets','Outputs');

subplot(2,2,3);
plot(E);
title(['MSE = ' num2str(MSE) ', RMSE = ' num2str(RMSE)]);

subplot(2,2,4);
hist(E,20);
title(['Mean Error = ' num2str(MeanError) ', Error Std = ' num2str(ErrorStd)]);

