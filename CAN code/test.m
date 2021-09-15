clear
addpath([cd '/Datasets']);
addpath([cd '/Evaluations']);
addpath([cd '/funs']);
filename = char('pathbased','spiral','jain','flame','aggregation',...
  'circles','moons','varied','aniso','blobs','r15','d31','s1',...
  'iris','ionosphere','wine','diabetes','segmentation',...
  'glass','wdbc','wpbc'); 

funcname = char('CAN');
funcs = {@test_CAN};

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