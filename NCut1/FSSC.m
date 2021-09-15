function result = FSSC(filename)
X = load([strtrim(filename),'.txt']);
C_Label = load([strtrim(filename),'_label.txt']);

K = length(unique(C_Label)); % Number of clusters
N = size(X,1);

tmpW = zeros(N,N);
t = 3;

Nc = 0; ACC = 0; C = zeros(N,1);
for tmpNc = 40:10:80
  [~,U] = fcm(X,tmpNc,[2,100,1e-5,false]);
  [sortU,sortIdx] = sort(U,'descend');
  for i = 1:N-1
    for j = i+1:N
      if sortIdx(1,i) == sortIdx(1,j)
        tmpW(i,j) = 1;
      elseif intersect(sortIdx(1:t,i),sortIdx(1:t,j))
        tmpW(i,j) = max(sortU(1,i),sortU(1,j));
      else
        tmpW(i,j) = 0;
      end
      tmpW(j,i) = tmpW(i,j);
    end
  end
  tmpC = NcutClustering(tmpW,K);
  tmpACC = CA(tmpC,C_Label);
  if ACC < tmpACC
    ACC = tmpACC;
    Nc = tmpNc;
    C = tmpC;
  end
end
result = Evaluation(C,C_Label);
end
