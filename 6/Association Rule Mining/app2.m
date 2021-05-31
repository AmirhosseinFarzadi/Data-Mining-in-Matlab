clc;
clear;
close all;

%% Load Data

data=load('mydata1');
T=data.T;

%% FP-Growth

MST=2/9;
MCT=0.6;

out=FPGrowth(T,MST,MCT);

FinalRules=out.FinalRules;
Tree=out.Node;
PlotTree(Tree);
