
function C = NcutClustering(W,nbCluster)

[NcutDiscrete,~,~] = ncutW(W,nbCluster);
C = zeros(size(W,1),1);

for j=1:nbCluster,
    C(NcutDiscrete(:,j)==1) = j;
end
