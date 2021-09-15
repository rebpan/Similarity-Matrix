function result = KNNSpectralClustering(filename)
X = load([strtrim(filename),'.txt']);
C_Label = load([strtrim(filename),'_label.txt']);

K = length(unique(C_Label)); % Number of clusters
N = size(X,1);
Dist = squareform(pdist(X));
sigma = max(Dist(:));
order = 2;
tmp = Dist.^order/sigma;
W = exp(-tmp);

% [~,sortIndex] = sort(Dist,2);

M = 0; ACC = 0; C = zeros(N,1);
for tmpM = 2:sqrt(N) % Number of neighbors
%   tmpW = KNN(sortIndex,W,N,tmpM);
  % KNN
  tmpW = zeros(N,N);
  [idx,~]=knnsearch(X,X,'k',tmpM+1);
  for i = 1:N
    tmpW(i,idx(i,2:tmpM+1)) = W(i,idx(i,2:tmpM+1));
    tmpW(idx(i,2:tmpM+1),i) = W(idx(i,2:tmpM+1),i);
  end
  
  tmpC = NcutClustering(tmpW,K);
  tmpACC = CA(tmpC,C_Label);
  if ACC < tmpACC
    ACC = tmpACC;
    M = tmpM;
    C = tmpC;
  end
end
result = Evaluation(C,C_Label);
end

% function [finalW] = KNN(sortIndex,W,N,k)
% finalW = zeros(N,N);
% for i = 1:N
%   finalW(i,sortIndex(i,2:k+1)) = W(i,sortIndex(i,2:k+1));
%   finalW(sortIndex(i,2:k+1),i) = W(sortIndex(i,2:k+1),i);
% end
% end
