function [FinalRules, Rules]=Apriori(T,MST,MCT)

    % Create Items Set
    Items=[];
    for i=1:numel(T)
        Items=union(Items,T{i});
    end
    Items=Items(:)';
    
    % 1st level Candidates
    C{1}=cell(1,numel(Items));
    count{1}=zeros(size(C{1}));
    for r=1:numel(Items)
        C{1}{r}=Items(r);
        for i=1:numel(T)
            if IsContainedIn(C{1}{r},T{i})
                count{1}(r)=count{1}(r)+1;
            end
        end
    end
    % 1st Level Frequent Patterns
    L{1}=C{1}(count{1}/numel(T)>=MST);

    % Initialize Counter
    k=1;

    % Iterations
    while ~isempty(L{k})

        b=[];
        for i=1:numel(L{k})
            b=union(b,L{k}{i});
        end
        b=b(:)';
        
        % (k+1)-th Level Candidates
        C{k+1}={};
        for i=1:numel(L{k})
            A=L{k}{i};
            for j=1:numel(b);
                if ~ismember(b(j),A)
                    New=[A b(j)];
                    Found=false;
                    for r=1:numel(C{k+1})
                        if IsSame(New,C{k+1}{r})
                            Found=true;
                            break;
                        end
                    end
                    if ~Found
                        C{k+1}=[C{k+1} {New}];
                    end
                end
            end
        end
        
        % Calculate Patterns Counts
        count{k+1}=zeros(size(C{2}));
        for r=1:numel(C{k+1})
            for i=1:numel(T)
                if IsContainedIn(C{k+1}{r},T{i})
                    count{k+1}(r)=count{k+1}(r)+1;
                end
            end
        end
        
        % (k+1)-th Level Frequent Patterns
        L{k+1}=C{k+1}(count{k+1}/numel(T)>=MST);
        
        % Increment Counter
        k=k+1;

    end

    L=L(1:end-1);

    % Extract Rules
    Rules={};
    Supp=[];
    Conf=[];
    Lift=[];
    for k=2:numel(L)
        for i=1:numel(L{k})

            countL=0;
            for j=1:numel(T)
                if IsContainedIn(L{k}{i},T{j})
                    countL=countL+1;
                end
            end
            
            S=GetNonTrivialSubsets(L{k}{i});
            Q=S(end:-1:1);
            for r=1:numel(S)
                Rules=[Rules; {S{r} Q{r}}];
                countS=0;
                countQ=0;
                for j=1:numel(T)
                    if IsContainedIn(S{r},T{j})
                        countS=countS+1;
                    end
                    if IsContainedIn(Q{r},T{j})
                        countQ=countQ+1;
                    end
                end
                Supp=[Supp; countL/numel(T)];
                Conf=[Conf; countL/countS];
                Lift=[Lift; countL/(countS*countQ/numel(T))];
            end
        end
    end
    
    % Sort According to Confidence Rate
    [Conf, SortOrder]=sort(Conf,'descend');
    Supp=Supp(SortOrder);
    Lift=Lift(SortOrder);
    Rules=Rules(SortOrder,:);
    for i=1:size(Rules)
        Rules{i,3}=Supp(i);
        Rules{i,4}=Conf(i);
        Rules{i,5}=Lift(i);
    end

    % Select Final Rules
    FinalRules=Rules(Conf>=MCT & Lift>=1,:);

end

function b=IsContainedIn(A,B)

    b=all(ismember(A,B));

end
