#include "mex.h"
#include "vector"
using namespace std;
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]){
    //check nubmer of arruments
    if(nrhs <3){
        mexErrMsgIdAndTxt( "setCoord:argumentsError",
                "Not enough argument.");
    }else if(nrhs >3){
        mexErrMsgIdAndTxt( "setCoord:argumentsError","Too many arguments.");
    }
    //give input a meaningful name
    const mxArray* pdbStruct = prhs[0];
    const mxArray* selectedAtoms = prhs[1];
    const mxArray* coordData = prhs[2];

    int fieldNumber = mxGetFieldNumber(pdbStruct,"coord");
    //check pdbStruct has coord field
    if(fieldNumber < 0){
        mexErrMsgIdAndTxt( "setCoord:pdbStructError","No coord field.");
    }

    //create a vector for saving the coverted indexes
    vector<int> indexes = vector<int>();
    size_t numberOfAtoms = mxGetNumberOfElements(pdbStruct);
    size_t numberOfAssign;// Total number of assigned atoms.
    //check
    if(mxIsLogical(selectedAtoms)){
        if(mxGetNumberOfElements(selectedAtoms) == numberOfAtoms ){
            indexes.reserve(256);
            bool* tmp = mxGetLogicals(selectedAtoms);
            for(int i=0;i<numberOfAtoms;i++){
                if(*(tmp+i)) indexes.push_back(i);
            }
            numberOfAssign = indexes.size();
        }else{
            mexErrMsgIdAndTxt( "setCoord:arrumentError","length of selectedAtoms(%d) and pdbStruct(%d) are not match.",
                                mxGetNumberOfElements(selectedAtoms),numberOfAtoms);
        }
    }else if(mxIsNumeric(selectedAtoms)){
        numberOfAssign = mxGetNumberOfElements(selectedAtoms);
        double* tmpIndexPtr = mxGetPr(selectedAtoms);
        int tmpIndex;
        indexes.reserve(numberOfAssign);
        // mexPrintf("%d\n",numberOfAssign);
        for(int i=0;i < numberOfAssign; i++){
            // mexPrintf("test\n",tmpIndex);
            tmpIndex = (int)*(tmpIndexPtr+i) ;
            if( tmpIndex  <= numberOfAtoms){
                indexes.push_back(tmpIndex-1);
            }else{
                mexErrMsgIdAndTxt( "setCoord:arrumentError","indexes(%d) in selectedAtoms outoff pdbStruct (%d atoms).",tmpIndex,numberOfAtoms);
            }
        }
    }

    if(numberOfAssign*3 != mxGetNumberOfElements(coordData)){
        mexErrMsgIdAndTxt( "setCoord:arrumentError","number of coordData is not match number of selectedAtoms");
    }

    double *dataPtr = mxGetPr(coordData);// get first element of coordData
    double *coords;//to save each coord array of atoms.
    bool isNby3 = mxGetN(coordData) == 3;
    for(int i=0;i < numberOfAssign;i++){
        mxArray* coordArray= mxGetFieldByNumber(pdbStruct,indexes[i],fieldNumber);
        coords = mxGetPr(coordArray);
        if(isNby3){
            *coords =  *(dataPtr+i);
            *(coords+1) =  *(dataPtr+i+numberOfAtoms*1);
            *(coords+2) =  *(dataPtr+i+numberOfAtoms*2);
        }else{
            *coords =  *(dataPtr+i*3);
            *(coords+1) =  *(dataPtr+i*3+1);
            *(coords+2) =  *(dataPtr+i*3+2);
        }
    }
    return;
}
