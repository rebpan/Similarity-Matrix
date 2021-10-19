% Compute the sum of weights of points, i.e. Sigma(s')/max(Sigma(s')),
% 
% Input:    W: the adjacency matrix of NCUT; 
%           numOfNeighbours: the number of neighbourhood
% Output:   M: the array of normalized neighbour sum
%           
% 2007/12/18  
% zhongcaiming

function M = sumOfNeighbors(W, numOfNeighbours)

numOfPatterns = size(W, 1);
maxWeight = 0;

M = zeros(1, numOfPatterns); % to store numOfPatterns of Sigma(weight)

for i = 1 : numOfPatterns   
    % find and store neighbours
    R = sort(W(i,:), 'descend');
    
    % compute the sum of neighbours
    M(i) = sum(R(2:numOfNeighbours+1));
    if maxWeight < M(i)
        maxWeight = M(i);
    end;    
end;

% Normalize the weights
M = M / maxWeight;
