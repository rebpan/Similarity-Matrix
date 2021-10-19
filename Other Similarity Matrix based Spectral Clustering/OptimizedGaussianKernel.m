function result = OptimizedGaussianKernel(filename)
X = load(['Datasets\',strtrim(filename),'.txt']);
C_Label = load(['Datasets\',strtrim(filename),'_label.txt']);
K = length(unique(C_Label)); % Number of clusters

N = size(X,1);
      
distances = squareform(pdist(X));
a = max(distances,[],2).^2;

tmp = sort(distances,2);
b = tmp(:,2).^2;
sigma_test= (a-b)./(2*log(a./b));

sigma = mean(sigma_test(1:end-2));

tmp = distances.^2/(2*sigma);

W = exp(-tmp);

C = NcutClustering(W,K);
result = Evaluation(C,C_Label);
end
