function result = RobustPathbased(filename)
X = load([strtrim(filename),'.txt']);
C_Label = load([strtrim(filename),'_label.txt']);

numOfNeighbors = 2;

K = length(unique(C_Label)); % Number of clusters
N = size(X,1);
W = squareform(pdist(X));
scale_sig = max(W(:));
tmp = W.^2/scale_sig;
W = exp(-tmp);

weight = sumOfNeighbors(W, numOfNeighbors);
for m = 1: N
    for n = 1: N
        if m ~= n 
          W(m, n) = W(m, n) * weight(m) * weight(n);
        end
    end
end
W = PathbasedDist(W.^(-1));
for j = 1:N 
    W(j,j) = 1; 
end 
W = W.^(-1);

C = NcutClustering(W,K);
result = Evaluation(C,C_Label);
end
