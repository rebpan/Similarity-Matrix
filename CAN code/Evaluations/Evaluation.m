function [result] = Evaluation(C,C_Label)
    ACC = CA(C,C_Label);
    NMI = evalmutual(C_Label,C);
    validity_Rand = validity(C,C_Label,1);
    validity_Jaccard = validity(C,C_Label,2);
    validity_FM = validity(C,C_Label,3);
    validity_AR = validity(C,C_Label,4);
    validity_5 = validity(C,C_Label,5);
    result = [ACC,NMI,validity_Rand,validity_Jaccard,validity_FM,validity_AR,validity_5];
end