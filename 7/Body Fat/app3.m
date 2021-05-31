clc;
clear;
close all;

%% Load Data
data=load('bodyfat.mat');
Inputs=data.bodyfatInputs;
Targets=data.bodyfatTargets;

nData=size(Inputs,2);

%% MLP

nRun=10;
N=1:20;
TrainMSE=zeros(nRun,numel(N));
ValMSE=zeros(nRun,numel(N));
TestMSE=zeros(nRun,numel(N));

for n=N
    for r=1:nRun
        % Create a Fitting Network
        hiddenLayerSize = n;
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

        % Display Settings
        net.trainParam.showWindow=false;
        net.trainParam.showCommandLine=true;
        
        % Train the Network
        [net,tr] = train(net,Inputs,Targets);

        % Test the Network
        outputs = net(Inputs);
        errors = gsubtract(Targets,outputs);
        performance = perform(net,Targets,outputs);

        % Recalculate Training, Validation and Test Performance
        trainTargets = Targets .* tr.trainMask{1};
        valTargets = Targets  .* tr.valMask{1};
        testTargets = Targets  .* tr.testMask{1};
        TrainMSE(r,n) = perform(net,trainTargets,outputs);
        ValMSE(r,n) = perform(net,valTargets,outputs);
        TestMSE(r,n) = perform(net,testTargets,outputs);
    end
end

%% Plot Results

plot(mean(TrainMSE,1),'b','LineWidth',2);
hold on;
plot(mean(ValMSE,1),'Color',[0 0.5 0],'LineWidth',2);
plot(mean(TestMSE,1),'r','LineWidth',2);
legend('Train','Validation','Test');



