function result = DensitySensitive(filename)
X = load([strtrim(filename),'.txt']);
C_Label = load([strtrim(filename),'_label.txt']);

K = length(unique(C_Label)); % Number of clusters
N = size(X,1);
Dist = squareform(pdist(X)); % Distance matrix

rho = 16; %Density factor
Dist_L = (exp(rho*Dist)-1).^(1/rho);
Dist_G = global_distance(Dist_L,[1:N])+1;
W = 1./Dist_G;

C = NcutClustering(W,K);
result = Evaluation(C,C_Label);
end
