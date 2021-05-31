clc;
clear;
close all;

%% Load Data

data=load('elections100.mat');
Inputs=data.Inputs;
Targets=data.Targets;

%% Decision Tree

tree=ClassificationTree.fit(Inputs,Targets,'MinParent',1);
tree.view();
tree.view('mode','graph');

