clc;
clear;
close all;

%% Load Data

data=load('data1000');
T=data.T;
clear data;

%% Apriori

N=100;
MST=0.05;
MCT=0.6;
[FinalRules, Rules]=Apriori(T(1:N),MST,MCT);
FinalRules=FinalRules';
Rules=Rules';


