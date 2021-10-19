%% Draw the result 
% Input: X -- data; C -- labels

function Draw(X, C)
    figure('position',[300,300,250,250]);
    C_uq = unique(C);
    cm = colormap(jet(length(C_uq))); 
    for j = 1: length(C_uq)
            IDX = find(C==C_uq(j));
            plot(X(IDX,1),X(IDX,2),'.','color',cm(j,:)); axis equal; hold on;
            %text(X(IDX(1),1), X( IDX(1),2), num2str(j),'FontSize',5);axis equal; hold on;  
    end 
end