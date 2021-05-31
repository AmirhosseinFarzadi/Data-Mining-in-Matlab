function S=GetPowerSet(A)

    n=numel(A);
    
    S=cell(2^n,1);
    for i=1:numel(S)
        f=dec2binvec(i-1);
        f=[f zeros(1,n-numel(f))];
        S{i}=A(logical(f));
    end

end