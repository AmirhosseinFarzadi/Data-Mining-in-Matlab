clc;
clear;
close all;

data=load('mydata1');
X=data.X;

inputs = X';

% Create a Self-Organizing Map
dimension1 = 1;
dimension2 = 3;
net = selforgmap([dimension1 dimension2]);

% Train the Network
[net,tr] = train(net,inputs);

% Test the Network
outputs = net(inputs);

IDX=vec2ind(outputs);

C=net.IW{1};

% View the Network
% view(net)

% Plots
% Uncomment these lines to enable various plots.
%figure, plotsomtop(net)
%figure, plotsomnc(net)
%figure, plotsomnd(net)
%figure, plotsomplanes(net)
%figure, plotsomhits(net,inputs)
%figure, plotsompos(net,inputs)
