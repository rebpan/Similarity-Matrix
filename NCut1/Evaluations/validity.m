%% validity index 
%% C - clustering result; C_Label - Ground truth      
function s = validity(C, C_Label, criterion)
    N = size(C,1);
    Pairs = combntns1(1:N);

    PairsV_P = C(Pairs(:,1)) == C(Pairs(:,2));
    PairsV_E = C_Label(Pairs(:,1)) == C_Label(Pairs(:,2));

    % SS - a, SD - b, DS - c, DD - d
    a = sum( PairsV_P.*PairsV_E);
    b = sum(PairsV_P.*(1-PairsV_E));
    c = sum( (1-PairsV_P).*PairsV_E);
    d =  sum((1- PairsV_P).*(1-PairsV_E));
    M = N*(N-1)/2;
    
    switch criterion
       case 1 % Rand
           s = (a+d)/M;
       case 2 % Jaccard
           s = a/(a+b+c);
       case 3 % FM
           s = sqrt( a/(a+b) * a/(a+c));
       case 4 % AR
           s =  2 * (M * a -(a+b)*(a+c)) /(M* (2 * a  +b+ c) - 2 *(a+b)*(a+c));
       case 5 %
           s = b / M;
    end
end