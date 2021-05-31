function b=IsSame(A,B)

    b=numel(A)==numel(B) && all(sort(A)==sort(B));

end
