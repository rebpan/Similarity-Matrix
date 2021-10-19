function PathBasedDisimilarity = PathbasedDist(W,x);

Pairs = minimumSpanningTree(W); %%%%   MST

% Pairs0 = [];
% Pairs = FastMST0801_M(x, Pairs0);   %   FastMST 

% compute path based distance and geodesic distance
PathBasedDisimilarity = pathGeodesic(Pairs, W);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% compute path based distance and geodesic distance simultaneously
function PathBased = pathGeodesic(Pairs, W)

PathBased = zeros(size(W,1), size(W,1));
% generate subtrees: one leaf node, one subtree, which just contains the 
% first node with a degree greater than 2

% 1. collect leaf nodes and store into LeafIndex
%   Degrees        Entrances       PathIndices   Path
% +---+---+    +----------------   +---+---+  +-------------  
% | 1 | 1 | -> |2                  | 1 | 2 |  |2 3
% | 2 | 2 |    |1 3                | 5 | 2 |  |4 3
% | 3 | 4 |    |2 4 9 6            | 8 | 3 |  |7 6 3
% | 4 | 2 |    |3 5                | 9 | 1 |  |3
% | 5 | 1 |    |4                  +---+---+  +-------------
% | 6 | 2 |    |7 3
% +---+---+    +----------------
%

Degrees = zeros(size(W, 1), 2);
Entrances = zeros(size(W, 1), size(W, 1));

for i = 1: size(W, 1)
    Degrees(i, 1) = i;
end;

for i = 1: size(Pairs, 1)   
    Degrees(Pairs(i,1), 2) = Degrees(Pairs(i,1), 2) + 1;
    Degrees(Pairs(i,2), 2) = Degrees(Pairs(i,2), 2) + 1;
    Entrances(Pairs(i, 1), Degrees(Pairs(i,1), 2)) = Pairs(i, 2);
    Entrances(Pairs(i, 2), Degrees(Pairs(i,2), 2)) = Pairs(i, 1);
end;

Path = zeros(1, size(W,1));
for i = 1: size(Degrees, 1)
    if Degrees(i, 2) == 1
        break;
    end;
end;

cursor = 1;
Path(cursor) = i;

Degrees = [Degrees, ones(size(Degrees, 1),1), zeros(size(Degrees, 1),1)];
Branches =  Degrees(Path(cursor),:);
cursor = cursor + 1;

while true
    if Entrances(Branches(1, 1), Branches(1, 3)) ~= Branches(1, 4)
        % insert a new node into Path
        Path(cursor) = Entrances(Branches(1, 1), Branches(1, 3));
    
        % new brabches
        Degrees(Path(cursor), 4) = Branches(1, 1);
        Branches = [Branches', Degrees(Path(cursor),:)']';
    
        % path based 
        for i = 1: cursor - 1
            if PathBased(Path(i), Degrees(Path(cursor), 4)) > W(Degrees(Path(cursor), 4), Path(cursor))
                PathBased(Path(i), Path(cursor)) = PathBased(Path(i), Degrees(Path(cursor), 4));              
            else
                PathBased(Path(i), Path(cursor)) = W(Degrees(Path(cursor), 4), Path(cursor));
            end;
            PathBased(Path(cursor), Path(i)) = PathBased(Path(i), Path(cursor));     
        end;
        cursor = cursor + 1; 
    end;
    % modify the first row of Branches
    Branches(1, 3) = Branches(1, 3) + 1;
    if Branches(1, 3) > Branches(1, 2)
        Branches = Branches(2:size(Branches, 1),:);
    end;
   
    if size(Branches, 1) == 0
        break;
    end;      
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Kruskal's algorithm 
function Pairs = minimumSpanningTree(W) 

% the third column of path is the representative element flag
Pairs = zeros(size(W, 1) - 1, 3);
D = zeros(size(W, 1) * (size(W, 1)  - 1) / 2, 1);
I = zeros(size(D,1), 2);
m = 1;
n = 1;

for i = 1: size(D,1)

    I(i, 1) = m + 1;
    I(i, 2) = n;
    D(i) = W(m+ 1, n);
    
    if n == m
        m = m + 1;
        n = 1;
    else
        n = n + 1;
    end;
end;

D = [D, I];
D = sortrows(D);

numOfPairsIn = 0;
for i = 1: size(D, 1)
    rep1 = repElement(Pairs, D(i, 2));
    rep2 = repElement(Pairs, D(i, 3));
    
    if rep1 ~= rep2 || (rep1 < 0 && rep2 < 0)
        numOfPairsIn = numOfPairsIn + 1;
        Pairs(numOfPairsIn, 1) = D(i, 2);
        Pairs(numOfPairsIn, 2) = D(i, 3);
        
        if rep1 < 0 && rep2 <0
            Pairs(numOfPairsIn, 3) = D(i, 2);
        elseif rep1 < 0 && rep2 > 0
            Pairs(numOfPairsIn, 3) = rep2;
        elseif rep1 > 0 && rep2 < 0
            Pairs(numOfPairsIn, 3) = rep1;
        else                                % if both rep1 and rep2 are greater than 0
            Pairs(numOfPairsIn, 3) = rep1;
            for j = 1: size(Pairs, 1)        % combine two subtrees 
                if Pairs(j,3) == rep2
                    Pairs(j,3) = rep1;
                end;
            end;
        end;
    end;
    
    if numOfPairsIn >= size(W, 1) - 1
        Pairs(:,3) = 0;
        break;
    end;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% determine the representative element
function rep = repElement(Pairs, node)
rep = -1;
for i = 1: size(Pairs, 1)
    if Pairs(i, 1) == node || Pairs(i, 2) == node
        rep = Pairs(i, 3);
        return;
    end;
end;
