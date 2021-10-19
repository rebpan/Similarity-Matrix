function result = SharedNearestNeighbors(filename)
% if both zeroth neighbors (the points being tested) are found in both
% neighborhood rows and at least k_t neighbor matches exist between the two
% rows (k_t is referred to as the similarity threshold).
X = load([strtrim(filename),'.txt']);
C_Label = load([strtrim(filename),'_label.txt']);

K = length(unique(C_Label)); % Number of clusters
N = size(X,1);
Dist = squareform(pdist(X));

M = 0; ACC = 0; C = zeros(N,1);
for tmpM = 1:100
  k = tmpM;
  [idx,d] = knnsearch(X,X,'k',k+1);

  SNNSimilarity = zeros(N,N);
  for i = 1:N
    for j = 1:N
      if isempty(find(idx(i,:)==j)) && isempty(find(idx(j,:)==i))
        continue;
      else
        SNNSimilarity(i,j) = length(intersect(idx(i,:),idx(j,:)));
      end
    end
  end
          
  sigma = max(Dist(:));
  order = 2;
  tmp = Dist.^order./(sigma*(SNNSimilarity+1));
  W = exp(-tmp);
  
  tmpC = NcutClustering(W,K);
  tmpACC = CA(tmpC,C_Label);
  if ACC < tmpACC
    ACC = tmpACC;
    M = tmpM;
    C = tmpC;
  end
end
result = Evaluation(C,C_Label);
end
