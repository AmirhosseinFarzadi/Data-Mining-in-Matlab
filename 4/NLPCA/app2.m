clc;
clear;
close all;

%% Load Data

theta=linspace(-pi/2,+pi/2,100);
r=unifrnd(1,1.5,size(theta));

X=[r.*cos(theta)
   r.*sin(theta)];

%% NLPCA (from: nlpca.org)

a=1;
[pc, net]=nlpca(X,a);


%% Feature Extraction
% pc = nlpca_get_components(net,X);

%% Recostruction (Generation)
Xhat=nlpca_get_data(net,pc);

E=X-Xhat;

MSE=mean(E.^2,2);
RMSE=sqrt(MSE);

%% Plot Results

theta1=(theta-min(theta))/(max(theta)-min(theta));
pc1=(pc(1,:)-min(pc(1,:)))/(max(pc(1,:))-min(pc(1,:)));

figure;
plot(theta1,'b','LineWidth',2);
hold on;
plot(pc1,'r','LineWidth',2);
legend('\theta','Score #1');




