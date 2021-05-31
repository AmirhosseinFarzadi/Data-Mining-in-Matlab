function [IDX, C]=kMedoids(X,k,UseMedian)

    if ~exist('UseMedian','var')
        UseMedian=true;
    end

    n=size(X,1);
    p=size(X,2);
    
    Xmin=min(X);
    Xmax=max(X);

    IDX=zeros(n,1);
    
    % Initialize Cluster Centers
    CenterIndex=randsample(n,k);
    C=X(CenterIndex,:);
    
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
            A=find(IDX==j);
            C(j,:)=mean(X(A,:));
            if UseMedian
                dcc=zeros(numel(A),1);
                for l=1:numel(A)
                    i=A(l);
                    dcc(l)=norm(C(j,:)-X(i,:));
                end
                [~, l]=min(dcc);
                C(j,:)=X(A(l),:);
            end
        end
        
        % Termination Condition
        if all(IDX==old_IDX)
            break;
        end
        
    end
    
end