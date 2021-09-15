clear
addpath([cd '/Datasets']);
addpath([cd '/Ncut']);
addpath([cd '/Evaluations']);
filename = char('jain','R15','D31','Aggregation','flame',...
  'Compound','pathbased','spiral','s1',...
  'iris','ionosphere','wine','diabetes','segmentation',...
  'glass','wdbc','wpbc'); 
% funcname = char('Standard','SelfTuning','RobustPathbased','DensitySensitive','DensityAdaptive','SharedNearestNeighbors','EpsilonNeighborhood','KNNSpectralClustering','MutualKNNSpectralClustering','NatureNeighborSpectralClustering','FSSC','PoweredGaussianKernal');
% funcs = {@Standard,@SelfTuning,@RobustPathbased,@DensitySensitive,@DensityAdaptive,@SharedNearestNeighbors,@EpsilonNeighborhood,@KNNSpectralClustering,@MutualKNNSpectralClustering,@NatureNeighborSpectralClustering,@FSSC,@PoweredGaussianKernal};

funcname = char('EnsembleSpect');
funcs = {@EnsembleSpect};

for currentFunc = 1:size(funcname,1)
fileID = fopen(['./Results/',strtrim(funcname(currentFunc,:)),'.txt'],'w');
  for currentFile = 1:length(filename)
    fprintf(fileID,'%s\n',strtrim(filename(currentFile,:)));
    for counter = 1:10
      result = funcs{currentFunc}(filename(currentFile,:));
      fprintf(fileID,'%.4f %.4f %.4f %.4f %.4f %.4f %.4f\n',result);
    end
  end
fclose(fileID);
end
