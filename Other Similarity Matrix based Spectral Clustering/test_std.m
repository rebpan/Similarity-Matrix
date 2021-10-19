clear
addpath([cd '/Datasets']);
addpath([cd '/Ncut']);
addpath([cd '/Evaluations']);
filename = char('jain','R15','D31','Aggregation','flame',...
  'Compound','pathbased','spiral','s1',...
  'iris','ionosphere','wine','diabetes','segmentation',...
  'glass','wdbc','wpbc'); 
% funcname = char('Standard','SelfTuning','RobustPathbased','DensitySensitive','DensityAdaptive','EpsilonNeighborhood','KNNSpectralClustering','MutualKNNSpectralClustering','TwoMST','ThreeMST','NatureNeighborSpectralClustering','FSSC','PoweredGaussianKernal','SharedNearestNeighbors');
% funcs = {@Standard,@SelfTuning,@RobustPathbased,@DensitySensitive,@DensityAdaptive,@EpsilonNeighborhood,@KNNSpectralClustering,@MutualKNNSpectralClustering,@TwoMST,@ThreeMST,@NatureNeighborSpectralClustering,@FSSC,@PoweredGaussianKernal,@SharedNearestNeighbors};

funcname = char('TwoMST','ThreeMST');
funcs = {@TwoMST,@ThreeMST};

all_results = zeros(10,2);

for currentFunc = 1:size(funcname,1)
fileID_1 = fopen(['./Results/',strtrim(funcname(currentFunc,:)),'.txt'],'w');
fileID_2 = fopen(['./Results/',strtrim(funcname(currentFunc,:)),'_STD.txt'],'w');
  for currentFile = 1:size(filename,1)
    fprintf(fileID_1,'%s\n',strtrim(filename(currentFile,:)));
    fprintf(fileID_2,'%s\n',strtrim(filename(currentFile,:)));
    for counter = 1:10
      result = funcs{currentFunc}(filename(currentFile,:));
      fprintf(fileID_1,'%.4f %.4f %.4f %.4f %.4f %.4f %.4f\n',result);
      
      all_results(counter,:) = result(1:2);
    end
    M = mean(all_results);
    S = std(all_results);
    fprintf(fileID_2,'%.4f %.4f\n%.4f %.4f\n',M,S); % mean and standard deviation
  end
fclose(fileID_1);
fclose(fileID_2);
end