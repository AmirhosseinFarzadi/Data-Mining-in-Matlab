clc;
clear;
close all;

%% Load Data

data=load('iris_dataset');

X=data.irisInputs';
L=data.irisTargets';
L=1*L(:,1)+2*L(:,2)+3*L(:,3);

Classes=unique(L)';
k=numel(Classes);

%% FDA

n=zeros(k,1);
C=cell(k,1);
M=mean(X);
S=cell(k,1);
Sw=0;
Sb=0;
for j=1:k
    Xj=X(L==Classes(j),:);
    n(j)=size(Xj,1);
    C{j}=mean(Xj);
    S{j}=0;
    for i=1:n(j)
        S{j}=S{j}+(Xj(i,:)-C{j})'*(Xj(i,:)-C{j});
    end
    Sw=Sw+S{j};
    Sb=Sb+n(j)*(C{j}-M)'*(C{j}-M);
end

[W, LAMBDA]=eig(Sb,Sw);

lambda=diag(LAMBDA);

[lambda, SortOrder]=sort(lambda,'descend');

W=W(:,SortOrder);

Y=X*W;

%% Apply Decision Tree

tree=ClassificationTree.fit(X(:,[3 4]),L);
tree.view('mode','graph');

%% Plot Results

figure;

subplot(4,2,1);
plot(X(:,1));
xlabel('x_1');

subplot(4,2,3);
plot(X(:,2));
xlabel('x_2');

subplot(4,2,5);
plot(X(:,3));
xlabel('x_3');

subplot(4,2,7);
plot(X(:,4));
xlabel('x_4');

subplot(4,2,2);
plot(Y(:,1));
xlabel('y_1');

subplot(4,2,4);
plot(Y(:,2));
xlabel('y_2');

subplot(4,2,6);
plot(Y(:,3));
xlabel('y_3');

subplot(4,2,8);
plot(Y(:,4));
xlabel('y_4');

