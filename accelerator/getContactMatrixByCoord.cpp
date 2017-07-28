#include "mex.h"
#include "matrix.h"
using namespace std;
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]){
    //check nubmer of arruments
    if(nrhs <3){
        mexErrMsgIdAndTxt( "getContactMatrix:argumentsError",
                "Not enough argument.");
    }else if(nrhs >3){
        mexErrMsgIdAndTxt( "getContactMatrix:argumentsError","Too many arguments.");
    }
    //give input a meaningful name
    const mxArray* allcoord1 = prhs[0];
    const mxArray* allcoord2 = prhs[1];
    double cutOff = mxGetScalar(prhs[2]);
    double nCutOff = -cutOff; 
    double cutOffSquare = cutOff * cutOff;
    int numberOfcol1 = (int)mxGetN(allcoord1);
    int numberOfcol2 = (int)mxGetN(allcoord2);
    //check pdbStruct has coord field
    if(numberOfcol1 != 3 || numberOfcol2 != 3){
        mexErrMsgIdAndTxt( "getContactMatrix:argumentsError","Coord should be N by 3.");
    }
    // get atom number
    int numberOfAtoms1 = (int)mxGetM(allcoord1);
    int numberOfAtoms2 = (int)mxGetM(allcoord2);
    //create a contactMatrix and assign it to output
    mxArray* contactMatrix = mxCreateLogicalMatrix(numberOfAtoms2, numberOfAtoms1);
    nlhs = 1;
    plhs[0] = contactMatrix;
    
    // caculate contact
    double* coord1 = mxGetPr(allcoord1);
    double* coord2 = mxGetPr(allcoord2);
    double tmpX,tmpY,tmpZ,dx,dy,dz,distance;
    int i=0;
    mxLogical* contactMatrixPtr = mxGetLogicals(contactMatrix) -1;
    for(int atomIndex1=0;atomIndex1 < numberOfAtoms1;atomIndex1++){
        tmpX = *(coord1+atomIndex1);
        tmpY = *(coord1+atomIndex1+numberOfAtoms1*1);
        tmpZ = *(coord1+atomIndex1+numberOfAtoms1*2);
        for(int atomIndex2=0;atomIndex2 < numberOfAtoms2;atomIndex2++){
            contactMatrixPtr += 1;
            *contactMatrixPtr = 1;
            dx =tmpX - *(coord2+atomIndex2);
            if(dx > cutOff || dx < nCutOff){
                *contactMatrixPtr = 0;
                continue;
            }
            dy = tmpY - *(coord2+atomIndex2+numberOfAtoms2*1);
            if(dy > cutOff || dy < nCutOff){
                *contactMatrixPtr = 0;
                continue;
            }
            dz = tmpZ - *(coord2+atomIndex2+numberOfAtoms2*2);
            if(dz > cutOff || dz < nCutOff){
               *contactMatrixPtr = 0;
                continue;
            }
            distance = dx*dx + dy*dy + dz*dz;
            if(distance > cutOffSquare){
                *contactMatrixPtr = 0;
            }
        }
    }
    return;
}
