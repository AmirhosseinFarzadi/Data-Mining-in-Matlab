clc;
clear;
close all;

data=load('data1000.csv');

data=data(:,2:end);

N=size(data,1);

T=cell(N,1);
for i=1:N
    T{i}=find(data(i,:));
end

