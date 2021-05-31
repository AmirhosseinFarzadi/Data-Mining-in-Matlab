clc;
clear;
close all;

%% Load Data

data=load('data1000');
T=data.T;
clear data;

%% FP-Growth

N=100;
MST=0.05;
MCT=0.6;

out=FPGrowth(T(1:N),MST,MCT);

FinalRules=out.FinalRules;
Tree=out.Node;
PlotTree(Tree);
