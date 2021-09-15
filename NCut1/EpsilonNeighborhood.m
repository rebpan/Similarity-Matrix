function result = EpsilonNeighborhood(filename)
X = load([strtrim(filename),'.txt']);
C_Label = load([strtrim(filename),'_label.txt']);

K = length(unique(C_Label)); % Number of clusters
N = size(X,1);
Dist = squareform(pdist(X)); % Distance matrix
scale_sig = max(Dist(:));
tmp = Dist.^2/scale_sig;
W = exp(-tmp);

% epsilon = clusterDBSCAN.estimateEpsilon(X,10,100);
% The length of longest edge in a min span tree of the full connected graph on the data points
T = minspantree(graph(Dist));
epsilon = max(T.Edges.Weight);
W = (Dist<=epsilon).*W; 

C = NcutClustering(W,K);
result = Evaluation(C,C_Label);
end
