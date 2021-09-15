function result = NatureNeighborSpectralClustering(filename)
X = load([strtrim(filename),'.txt']);
C_Label = load([strtrim(filename),'_label.txt']);

K = length(unique(C_Label)); % Number of clusters
N = size(X,1);

Dist = squareform(pdist(X));

sigma = max(Dist(:));
tmp = Dist.^2/sigma;
A = exp(-tmp);

NaN = NaturalNeighbor1(X,N);
G = zeros(N,N);
for j = 1:N
  G(j,NaN{j}) = 1;
  G(NaN{j},j) = G(j,NaN{j});
end
W = A.*G;
C = NcutClustering(W,K);

result = Evaluation(C,C_Label);
end

function NaN = NaturalNeighbor1(X,N)
r = 1;
NaN = cell(N,1);

W = squareform(pdist(X));
[~, IX] = sort(W, 2);
s = -1;

while true
  for x_i = 1: N
%             for j = 2: r + 1
%                 x_j = IX(x_i, j); % NN
%                 if W(x_j, x_i) <= W(x_j, IX(x_j, r + 1)) % RNN
%                     NaN{x_i} = union(NaN{x_i}, x_j);
%                 end
%             end
    x_j = IX(x_i, 2:r+1);
    for x_k = x_j
      if W(x_k, x_i) <= W(x_k, IX(x_k, r + 1))
        NaN{x_i} = union(NaN{x_i}, x_k);
      end
    end
  end
  s1 = sum(cellfun(@isempty, NaN));
  if s1 == s
    lambda = r;
    break;
  end
  s = s1;
  r = r + 1;           
end
end
