%% Ensemble + Spect: 
%  Tow-level-refined CM based Ensemble combines with path-based 
%  transformation
% Caiming Zhong, 2014/05/08

function EnsembleSpect_C
    clc;
    addpath([cd '/Datasets']);
    addpath([cd '/Ncut']);
    warning('off', 'all');
    filename = char('pathbased','spiral','jain','flame','aggregation',...
                    'd31','r15','s1','iris','ionosphere','wine','diabetes',...
                    'segment1','glass','wdbc','wpbc');    
    Ktype = 'Fixed'; % 'Fixed' or 'randomly' K
    for i = 1: 16
        X = load(['Datasets\', strtrim(filename(i,:)), '.txt']);
        C_Label = load(['Datasets\', strtrim(filename(i,:)), '_label.txt']);   

        K = length(unique(C_Label)); % Number of clusters
        M = 100; % Number of base partitions
        It = 4; % Number of iterations of K-means
        
        [PI, ClusterNum] = BasePartitionByKmeans(X, M, It, Ktype);

        % Point-level-refined CM
        CM0 = GenCM(ClusterNum, PI, X); 
        Stability = ClusterStability(PI, CM0, ClusterNum);

        % Point-level-refined + Cluster-level-refined CM
        CM1 = GenCM(ClusterNum, PI, X, Stability);
        W = 1 - CM1 / max(CM1(:)); 
        W = 1 - PathbasedDist(W);   

        C = NcutClustering(W,K);     
        Draw(X, C);
    end
end

%% To generate based partitions by K-means
% X: data set, one row is one instance
% M: the number of base partitions
% It: the number of iterations for K-means
% Ktype: the type to generate base partitions, 'Fixed' ---sqrt(N)
% E: base partitions,one column is a partition
% ClusterNum: the number of K in each partition
function [PI, ClusterNum] = BasePartitionByKmeans(X, M, It, Ktype)
    N = size(X, 1);
    PI = zeros(N, M);
    ClusterNum = zeros(M,1);
    
    for i = 1: M
        if strcmp(Ktype,'Fixed')
            K = ceil(sqrt(N));
        else
            K = randsample(2:ceil(sqrt(N)),1);
        end
        ClusterNum(i) = K;
        opts = statset('MaxIter', It);        
        C = kmeans(X, K, 'emptyaction', 'drop', 'Options', opts);
        while length(unique(C)) ~= K
            C = kmeans(X, K, 'emptyaction', 'drop', 'Options', opts);
        end     
        PI(:, i) = C;      
    end
end

%% To evaluate the stability of cluster
% PI: partitions
% CM: the co-association matrix refined from point-level
% ClusterNum: the number of K in each partition
% Stability: stability of all clusters
function Stability = ClusterStability(PI, CM, ClusterNum)
    M = size(PI,2);  
    Stability = zeros(sum(ClusterNum),1);

    for i = 1: M
        for j = 1: ClusterNum(i)
            C = find(PI(:,i) == j);
            n = length(C);
            if n <= 1
                continue;
            end
            idx =sum(ClusterNum(1: i-1)) + j;            
            Stability(idx) = StabilityC(C', CM) / (n*(n-1)/2);            
        end
    end    
    minValue = min(Stability(:));
    maxValue = max(Stability(:));
    Stability = (Stability - minValue) / (maxValue - minValue) ;   
end

%% To generate co-association matrix
% ClusterNum: the number of K in each partition
% PI: a base partition
% X: data set
% Stability: 

function CM = GenCM(ClusterNum, PI, X, Stability)
    CM = zeros(size(PI,1));
    clusterNo  = size(PI, 2);      
    
    for i = 1: clusterNo
        C = PI(:,i);
        for j = 1: ClusterNum(i)
            IDX = find(C==j);
            if length(IDX) <=1 
                continue;
            end              
            if nargin == 2 % Original CM
                CM = Similarity(IDX, CM);
            elseif nargin == 3 % Point-level-refined CM
                CM = Similarity(IDX, CM, X);
            else % Point-level-refined + Point-level-refined CM
                idx = sum(ClusterNum(1: i-1)) + j;               
                CM = Similarity(IDX, CM, X, Stability(idx));
            end
        end
    end    
    CM = CM + CM';
end

%% Pairwise similarity
% IDX: indexes of points of a base cluster w.r.t. X
% X: data set
% CM: co-association matrix
% stability: stability of a base cluster
function CM = Similarity(IDX, CM, X, stability)
    if nargin < 3 %original CM
        CM = SimilarityC(IDX',CM);
    else
        W = squareform(pdist(X(IDX,:))); 
        W = 1 - W/max(W(:));      
        if nargin == 4 % two-level-refined CM
            CM = SimilarityC(IDX',CM, W, stability);             
        else % one-level-refined CM
            CM = SimilarityC(IDX',CM, W); 
        end
    end
end


