function PlotTree(Node)

    [x, y]=treelayout([Node.Parent]);
    for i=1:numel(Node)
        j=Node(i).Parent;
        if j~=0
            plot([x(i) x(j)],[y(i) y(j)]);
        end
        hold on;
    end
    
    for i=1:numel(Node)
        plot(x(i),y(i),'o','MarkerFaceColor','w','MarkerSize',24);
        text(x(i),y(i),...
            [num2str(Node(i).Name) ':' num2str(Node(i).Count)],...
            'HorizontalAlignment','center');
    end

end