clc;
clear;
close all;

%% Load Data

theta=linspace(-pi/2,+pi/2,100);
r=unifrnd(1,1.5,size(theta));

X=[r.*cos(theta)
   r.*sin(theta)];

%% SOM

inputs = X;

% Create a Self-Organizing Map
dimension1 = 1;
dimension2 = 10;
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
