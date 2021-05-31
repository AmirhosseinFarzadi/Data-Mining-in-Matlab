clc;
clear;
close all;

%% Load Data

data=load('iris_dataset');

X=data.irisInputs';
L=data.irisTargets';
L=1*L(:,1)+2*L(:,2)+3*L(:,3);

%% NLPCA (from: nlpca.org)

a=2;
[pc, net]=nlpca(X',a);
pc=pc';

%% Decision Tree

tree=ClassificationTree.fit(pc(:,1),L);
tree.view('mode','graph');

%% Plot Results

figure;
subplot(2,1,1);
plot(pc(:,1));
subplot(2,1,2);
plot(pc(:,2));



