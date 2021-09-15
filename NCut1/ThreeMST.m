function result = ThreeMST(filename)
X = load([strtrim(filename),'.txt']);
C_Label = load([strtrim(filename),'_label.txt']);

K = length(unique(C_Label)); % Number of clusters
N = size(X,1);
Dist = squareform(pdist(X)); % Distance matrix
scale_sig = max(Dist(:));
tmp = Dist.^2/scale_sig;
W = exp(-tmp);

G = graph(Dist);
T1=minspantree(G);
G = rmedge(G,T1.Edges.EndNodes(:,1),T1.Edges.EndNodes(:,2));
T2=minspantree(G);
G = rmedge(G,T2.Edges.EndNodes(:,1),T2.Edges.EndNodes(:,2));
T3=minspantree(G);

T = T1;
T = addedge(T,T2.Edges.EndNodes(:,1),T2.Edges.EndNodes(:,2),T2.Edges.Weight);
T = addedge(T,T3.Edges.EndNodes(:,1),T3.Edges.EndNodes(:,2),T3.Edges.Weight);
sparseThreeMST = adjacency(T);
ThreeMST = full(sparseThreeMST);

W = W.*ThreeMST;

C = NcutClustering(W,K);
result = Evaluation(C,C_Label);
end
