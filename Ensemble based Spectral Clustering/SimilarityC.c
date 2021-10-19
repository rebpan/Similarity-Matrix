
#include "mex.h"

void Similarity(double *IDX, double *CM, mwSize idxLen, mwSize cmSize)
{
    mwSize i, j;
    for (i = 0; i < idxLen; i ++)
        for (j = i + 1; j < idxLen; j++){
            CM[(int)((IDX[j]-1) * cmSize + IDX[i])-1] = CM[(int)((IDX[j]-1) * cmSize +  IDX[i])-1] + 1;
        }
}

void SimilarityPoint(double *IDX, double *CM, double * W, mwSize idxLen, mwSize cmSize)
{
    mwSize i, j;
    for (i = 0; i < idxLen ; i ++)
        for (j = i + 1; j < idxLen; j++){
            CM[(int)((IDX[j]-1)* cmSize + IDX[i]-1)] = CM[(int)((IDX[j]-1) * cmSize +  IDX[i])-1] + W[j * idxLen + i];  
        }
}

void SimilarityCluster(double *IDX, double *CM, double * W, double stability, mwSize idxLen, mwSize cmSize)
{
    mwSize i, j;
    for (i = 0; i < idxLen; i ++)
        for (j = i + 1; j < idxLen; j++){
            CM[(int)((IDX[j]-1) * cmSize + IDX[i])-1] = CM[(int)((IDX[j]-1) * cmSize +  IDX[i])-1] + W[j * idxLen +i] * stability;  
        }
}

/* The gateway function */
void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[])
{
    double *IDX;                
    double *CM, *W, stability;              
    mwSize idxLen, cmSize;        
        
    
    //IDX, CM
    IDX = mxGetPr(prhs[0]);
    CM = mxGetPr(prhs[1]);
    if (nrhs >= 3) W = mxGetPr(prhs[2]);
    if (nrhs == 4) stability = mxGetScalar(prhs[3]);
    
    idxLen = mxGetN(prhs[0]);
    cmSize = mxGetM(prhs[1]);

    plhs[0] = prhs[1];
    if (nrhs == 2)
        Similarity(IDX, CM, idxLen, cmSize);
    else if (nrhs ==3)
    {
        SimilarityPoint(IDX, CM, W, idxLen, cmSize);
    }
    else if (nrhs ==4){
        SimilarityCluster(IDX, CM, W, stability, idxLen, cmSize);
    }

}
