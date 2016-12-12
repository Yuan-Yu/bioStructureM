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
    const mxArray* pdbStruct1 = prhs[0];
    const mxArray* pdbStruct2 = prhs[1];
    double cutOff = mxGetScalar(prhs[2]);
    double nCutOff = -cutOff; 
    double cutOffSquare = cutOff * cutOff;
    int fieldNumber1 = mxGetFieldNumber(pdbStruct1,"coord");
    int fieldNumber2 = mxGetFieldNumber(pdbStruct2,"coord");
    //check pdbStruct has coord field
    if(fieldNumber1 < 0 || fieldNumber2 < 0){
        mexErrMsgIdAndTxt( "getContactMatrix:argumentsError","No coord field.");
    }
    // get atom number
    int numberOfAtoms1 = (int)mxGetNumberOfElements(pdbStruct1);
    int numberOfAtoms2 = (int)mxGetNumberOfElements(pdbStruct2);
    //create a contactMatrix and assign it to output
    mxArray* contactMatrix = mxCreateLogicalMatrix(numberOfAtoms2, numberOfAtoms1);
    nlhs = 1;
    plhs[0] = contactMatrix;
    
    // caculate contact
    double* coord1;
    double* coord2;
    double tmpX,tmpY,tmpZ,dx,dy,dz,distance;
    int i=0;
    mxLogical* contactMatrixPtr = mxGetLogicals(contactMatrix) -1;
    for(int atomIndex1=0;atomIndex1 < numberOfAtoms1;atomIndex1++){
        coord1 = mxGetPr(mxGetFieldByNumber(pdbStruct1, atomIndex1, fieldNumber1));
        tmpX = *coord1;
        tmpY = *(coord1+1);
        tmpZ = *(coord1+2);
        for(int atomIndex2=0;atomIndex2 < numberOfAtoms2;atomIndex2++){
            contactMatrixPtr += 1;
            *contactMatrixPtr = 1;
            coord2 = mxGetPr(mxGetFieldByNumber(pdbStruct2, atomIndex2, fieldNumber2));
            dx =tmpX - *coord2;
            if(dx > cutOff || dx < nCutOff){
                *contactMatrixPtr = 0;
                continue;
            }
            dy = tmpY - *(coord2+1);
            if(dy > cutOff || dy < nCutOff){
                *contactMatrixPtr = 0;
                continue;
            }
            dz = tmpZ - *(coord2+2);
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
