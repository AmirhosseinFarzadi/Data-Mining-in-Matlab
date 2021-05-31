clc;
clear;
close all;

data=load('mydata3');
X=data.X;

k=3;

[IDX, C]=kmeans(X,k);


figure;
subplot(1,2,1);
Colors=hsv(k);
for i=1:k
    Xi=X(IDX==i,:);
    plot(Xi(:,1),Xi(:,2),'o','MarkerSize',10,'Color',Colors(i,:));
    hold on;
    plot(C(i,1),C(i,2),'ks','MarkerSize',12,'MarkerFaceColor',Colors(i,:));
end

subplot(1,2,2);
[C2, U]=fcm(X,k);
for i=1:size(X,1)
    ci=U(:,i)';
    ci=ci/max(ci);
    plot(X(i,1),X(i,2),'.','MarkerSize',18,'Color',ci);
    hold on;
end
plot(C2(1,1),C2(1,2),'ks','MarkerSize',12,'MarkerFaceColor',[1 0 0]);
plot(C2(2,1),C2(2,2),'ks','MarkerSize',12,'MarkerFaceColor',[0 1 0]);
plot(C2(3,1),C2(3,2),'ks','MarkerSize',12,'MarkerFaceColor',[0 0 1]);





