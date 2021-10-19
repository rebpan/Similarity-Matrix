
#include "mex.h"
double Stability(double *IDX, double *CM,  mwSize idxLen, mwSize cmSize)
{
    mwSize i, j;
    double sum = 0;

    for (i = 0; i < idxLen; i ++){
        for (j = i + 1; j < idxLen; j++){
           sum += CM[(int)((IDX[j]-1)* cmSize + IDX[i] - 1)];
         
        }
    }
    return sum;
}

/* The gateway function */
void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[])
{
    double *IDX;                
    double *CM;          
    mwSize idxLen, cmSize;        
    double *out;              
    
    //IDX, CM
    IDX = mxGetPr(prhs[0]);
    CM = mxGetPr(prhs[1]);

    idxLen = mxGetN(prhs[0]);
    cmSize = mxGetM(prhs[1]);
    
    plhs[0] = mxCreateDoubleMatrix(1,1,mxREAL);
    out=mxGetPr(plhs[0]);
    *out = Stability(IDX, CM, idxLen, cmSize);
}
