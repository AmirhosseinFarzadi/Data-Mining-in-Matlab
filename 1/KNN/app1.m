clc;
clear;
close all;

%% Load Data

load fisheriris;
X=meas;         % Inputs
Y=species;      % Targets

%% KNN Classifier

c=ClassificationKNN.fit(X,Y,'NumNeighbors',5);

disp('Resub. Loss =');
disp(resubLoss(c));

%% Cross-validation

cvmodel=crossval(c);

disp('k-Fold Loss =');
disp(kfoldLoss(cvmodel));

