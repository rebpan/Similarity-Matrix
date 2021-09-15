clear
addpath([cd '/Datasets']);
addpath([cd '/Ncut']);
addpath([cd '/Evaluations']);
filename = char('jain','R15','D31','Aggregation','flame',...
  'Compound','pathbased','spiral','s1',...
  'iris','ionosphere','wine','diabetes','segmentation',...
  'glass','wdbc','wpbc'); 
% funcname = char('Standard','SelfTuning','RobustPathbased','DensitySensitive','DensityAdaptive','EpsilonNeighborhood','KNNSpectralClustering','MutualKNNSpectralClustering','NatureNeighborSpectralClustering','FSSC','PoweredGaussianKernal','SharedNearestNeighbors');
% funcs = {@Standard,@SelfTuning,@RobustPathbased,@DensitySensitive,@DensityAdaptive,@EpsilonNeighborhood,@KNNSpectralClustering,@MutualKNNSpectralClustering,@NatureNeighborSpectralClustering,@FSSC,@PoweredGaussianKernal,@SharedNearestNeighbors};

funcname = char('Standard','SelfTuning','RobustPathbased','DensitySensitive','DensityAdaptive','EpsilonNeighborhood');
funcs = {@Standard,@SelfTuning,@RobustPathbased,@DensitySensitive,@DensityAdaptive,@EpsilonNeighborhood};

funcname = char('Standard');
funcs = {@Standard};

for currentFunc = 1:size(funcname,1)
fileID = fopen(['./Results/',strtrim(funcname(currentFunc,:)),'.txt'],'w');
  for currentFile = 1:size(filename,1)
    fprintf(fileID,'%s\n',strtrim(filename(currentFile,:)));
    for counter = 1:10
      result = funcs{currentFunc}(filename(currentFile,:));
      fprintf(fileID,'%.4f %.4f %.4f %.4f %.4f %.4f %.4f\n',result);
    end
  end
fclose(fileID);
end
