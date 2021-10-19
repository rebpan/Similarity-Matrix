function result = DensityAdaptive(filename)
X = load([strtrim(filename),'.txt']);
C_Label = load([strtrim(filename),'_label.txt']);

K = length(unique(C_Label)); % Number of clusters
N = size(X,1);
Dist = squareform(pdist(X)); % Distance matrix

T = minspantree(graph(Dist));
epsilon = max(T.Edges.Weight);
CNNMatrix = CNN(Dist,N,epsilon);
sigma = max(Dist(:));
order = 2;
tmp = Dist.^order./(sigma*(CNNMatrix+1));
W = exp(-tmp);
C = NcutClustering(W,K);
result = Evaluation(C,C_Label);
end

function CNNMatrix = CNN(Dist,N,epsilon)
[~,sortIndex] = sort(Dist,2);
sortIndex = (Dist<=epsilon).*sortIndex;
CNNMatrix = zeros(N,N);
for i = 1:N-1
  for j = i+1:N
    CNNMatrix(i,j) = length(intersect(sortIndex(i,:),sortIndex(j,:)));
    CNNMatrix(j,i) = CNNMatrix(i,j);
  end
end
end
