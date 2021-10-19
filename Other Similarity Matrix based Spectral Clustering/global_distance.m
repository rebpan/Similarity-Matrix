function dist = global_distance(D,source)
% Global distance 
% by Fanhua Shang
% Key Laboratory of Intelligent Perception and Image Understanding of Ministry of Education of China,
% Xidian University, Xi'an 710071, China.
% References: 
% [1]Fanhua Shang, Licheng Jiao, Jiarong Shi, Fei Wang, Maoguo Gong. Fast
% Affinity Propagation Clustering: A Multilevel Approach, Pattern Recognition, 45(1): 474¨C486, 2012.
% [2] Fanhua Shang, Licheng Jiao, Jiarong Shi, Maoguo Gong, Ronghua Shang.
% Fast Density-Weighted Low-Rank Approximation Spectral Clustering, 
% Data Mining and Knowledge Discovery, 23(2): 345¨C378, 2011.

dist = sqrt(PathDist(D.^2, [], source, 0));