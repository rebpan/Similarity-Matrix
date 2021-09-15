folder_now = pwd;  addpath([folder_now, '/funs']);

load('matlab.mat')

[la, A, evs] = CAN(mousePointCoords', 3);

G = graph(A);

sparseG= adjacency(G);
fullG = full(sparseG);
plot(mousePointCoords(:,1),mousePointCoords(:,2),'.'); hold on;
color1 = [0, 0.4470, 0.7410];
for i = 1:60
  for j = 1:60
    if fullG(i,j) ~= 0
      plot([mousePointCoords(i,1);mousePointCoords(j,1)],[mousePointCoords(i,2);mousePointCoords(j,2)],'Color',color1); hold on;
    end
  end
end