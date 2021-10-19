clear
addpath([cd '/Datasets']);
filename = char('pathbased','spiral','jain','flame','aggregation',...
  'circles','moons','varied','aniso','blobs','r15','d31');
fname = char('Pathbased','Spiral','Jain','Flame','Aggregation',...
  '2-Circles','Moons','Varied','Aniso','Blobs','R15','D31');

for i = 1:length(filename)
  X = load(['Datasets\',strtrim(filename(i,:)),'.txt']);
  C_Label = load(['Datasets\',strtrim(filename(i,:)),'_label.txt']);
  subplot(3,4,i);
  set(gca,'xtick',[]);
  set(gca,'ytick',[]);
  axis equal;
  hold on;
  C_uq = unique(C_Label);
  cm = colormap(jet(length(C_uq))); 
  for j = 1: length(C_uq)
    IDX = find(C_Label==C_uq(j));
    plot(X(IDX,1),X(IDX,2),'.','color',cm(j,:)); title([strtrim(fname(i,:))]);
  end
end