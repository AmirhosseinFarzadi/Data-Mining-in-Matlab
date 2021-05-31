clc;
clear;
close all;

%% Load Data

load fisheriris;
X=meas;         % Inputs
Y=species;      % Targets

%% Naive Bayesian Classifier

bc=NaiveBayes.fit(X,Y);

Z=bc.predict(X);    % Outputs

cm=confusionmat(Y,Z);

disp('Confusion Matrix:');
disp(cm);

