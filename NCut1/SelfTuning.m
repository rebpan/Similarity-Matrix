function result = SelfTuning(filename)
X = load([strtrim(filename),'.txt']);
C_Label = load([strtrim(filename),'_label.txt']);
K = length(unique(C_Label)); % Number of clusters

m = 7; % Set sigma by number of neighbors
Dist = squareform(pdist(X));
sortDist = sort(Dist,2);
mDist = sortDist(:,m+1);
sigma = mDist*mDist';
order = 2;
tmp = Dist.^order./sigma;
W = exp(-tmp);

C = NcutClustering(W,K);
result = Evaluation(C,C_Label);
end
