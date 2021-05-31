clc;
clear;
close all;

%% Load Data

data=load('mydata1');
T=data.T;

%% Apriori

MST=0.22;
MCT=0.6;
[FinalRules, Rules]=Apriori(T,MST,MCT);



