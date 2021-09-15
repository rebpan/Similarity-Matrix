%% Incremental TSP
function [dist, Tour] = IncrementalTSPImproved(xy)

    %clc;  
    N = size(xy, 1); 
    Tour = zeros(N, 1);

    % K-means
    K = floor(sqrt(N));
    C = kmeans(X, K, 'emptyaction', 'drop');
    while length(unique(C)) ~= K
        C = kmeans(X, K, 'emptyaction', 'drop');
    end   
    
    % 1. Initial solutions: randomly select three cities
    C = randsample(1:N, 3);
    Tour(C(1)) = C(2);
    Tour(C(2)) = C(3);
    Tour(C(3)) = C(1);
    
    %2. Repeatedly add cities
    newC = find(Tour == 0);
    while ~isempty(newC)
        newC = newC(randsample(1:length(newC),1));
        subTour = find(Tour > 0);
        for i = 1: length(subTour)
            delta = Dist(xy, newC, subTour(i)) + ...
                    Dist(xy, newC, Tour(subTour(i))) - ...
                    Dist(xy, subTour(i),Tour(subTour(i)));            
            if i == 1
                minDist = delta;
                index = i;
            elseif minDist > delta
                minDist = delta;
                index = i;
            end            
        end
        endpoint = Tour(subTour(index));
        Tour(subTour(index)) = newC;
        Tour(newC) = endpoint;

        newC = find(Tour == 0);  
    end    
    dist = DistanceTour(Tour, xy);     
end



