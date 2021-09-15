function result = PoweredGaussianKernal(filename)
X = load([strtrim(filename),'.txt']);
C_Label = load([strtrim(filename),'_label.txt']);
K = length(unique(C_Label)); % Number of clusters

N = size(X,1);
Dist = squareform(pdist(X));
minDist = max(Dist,[],2);
for i = 1:N
    for j = 1:N
        if i ~= j
            if minDist(i) > Dist(i,j)
                minDist(i) = Dist(i,j);
            end
        end
    end
end
beta = max(minDist);

c = 5; %step
gamma = 1;
tmp = (Dist.^2/beta).^gamma;
A = exp(-tmp);
J = sum(A,2);

for m = 1:4
  gamma_next = c*m;
  tmp_next = (Dist.^2/beta).^gamma_next;
  A_next = exp(-tmp_next);
  J_next = sum(A_next,2);
  rho = corr(J,J_next);
  if rho >= 0.97
    break
  else
    gamma = gamma_next;
    J = J_next;
  end
end

tmp = (Dist.^2/beta).^gamma;
W = exp(-tmp);

C = NcutClustering(W,K);
result = Evaluation(C,C_Label);
end
