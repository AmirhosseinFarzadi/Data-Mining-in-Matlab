function [IDX, C]=kMeansClustering(X,k)

    n=size(X,1);
    p=size(X,2);
    
    Xmin=min(X);
    Xmax=max(X);

    IDX=zeros(n,1);
    
    % Initialize Cluster Centers
    C=zeros(k,p);
    for j=1:k
        C(j,:)=unifrnd(Xmin,Xmax);
    end
    
    while true
        
        old_IDX=IDX;
        
        % Assignment
        for i=1:n
            xi=X(i,:);
            d=zeros(1,k);
            for j=1:k
                d(j)=norm(C(j,:)-xi);
            end
            [~, IDX(i)]=min(d);
        end

        % Update Cluster Centers
        for j=1:k
            C(j,:)=mean(X(IDX==j,:));
        end
        
        % Termination Condition
        if all(IDX==old_IDX)
            break;
        end
        
    end
    
end