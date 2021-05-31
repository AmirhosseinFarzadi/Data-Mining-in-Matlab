clc;
clear;
close all;

%% Load Data
data=load('bodyfat.mat');
Inputs=data.bodyfatInputs;
Targets=data.bodyfatTargets;

nData=size(Inputs,2);

%%

% Create a Fitting Network
hiddenLayerSize = 5;
net = fitnet(hiddenLayerSize);

%net = cascadeforwardnet(hiddenLayerSize);

% Choose Input and Output Pre/Post-Processing Functions
% For a list of all processing functions type: help nnprocess
net.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};
net.outputs{2}.processFcns = {'removeconstantrows','mapminmax'};


% Setup Division of Data for Training, Validation, Testing
% For a list of all data division functions type: help nndivide
net.divideFcn = 'dividerand';  % Divide data randomly
net.divideMode = 'sample';  % Divide up every sample
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

% For help on training function 'trainlm' type: help trainlm
% For a list of all training functions type: help nntrain
net.trainFcn = 'trainlm';  % Levenberg-Marquardt

% Choose a Performance Function
% For a list of all performance functions type: help nnperformance
net.performFcn = 'mse';  % Mean squared error

% Choose Plot Functions
% For a list of all plot functions type: help nnplot
net.plotFcns = {'plotperform','plotregression','plotfit'};


% Train the Network
[net,tr] = train(net,Inputs,Targets);

% Test the Network
outputs = net(Inputs);
errors = gsubtract(Targets,outputs);
performance = perform(net,Targets,outputs)

% Recalculate Training, Validation and Test Performance
trainTargets = Targets .* tr.trainMask{1};
valTargets = Targets  .* tr.valMask{1};
testTargets = Targets  .* tr.testMask{1};
trainPerformance = perform(net,trainTargets,outputs)
valPerformance = perform(net,valTargets,outputs)
testPerformance = perform(net,testTargets,outputs)

% View the Network
% view(net)

% Plots
% Uncomment these lines to enable various plots.
%figure, plotperform(tr)
%figure, plottrainstate(tr)
%figure, plotfit(net,inputs,targets)
%figure, plotregression(targets,outputs)
%figure, ploterrhist(errors)
