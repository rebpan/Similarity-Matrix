function result = test_CAN(filename)
X = load([strtrim(filename),'.txt']);
C_Label = load([strtrim(filename),'_label.txt']);

K = length(unique(C_Label)); % Number of clusters
N = size(X,1); 
        
[C, A, evs] = CAN(X', K);
        
result = Evaluation(C,C_Label);
end