function result = Standard(filename)
X = load([strtrim(filename),'.txt']);
C_Label = load([strtrim(filename),'_label.txt']);

K = length(unique(C_Label)); % Number of clusters

distances = squareform(pdist(X));  
sigma = max(distances(:));
order = 2;
tmp = distances.^order/sigma;
W = exp(-tmp);

C = NcutClustering(W,K);
result = Evaluation(C,C_Label);
end
