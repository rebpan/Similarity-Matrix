function Pairs = combntns1(A)
n = length(A);
Pairs = zeros(n*(n-1)/2,2);
id = 1;
for i = 1: n-1
    for j = i +1: n
        Pairs(id, 1) = A(i);
        Pairs(id, 2) = A(j);
        id = id + 1;
    end
end