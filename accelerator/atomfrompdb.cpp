#include <iostream>
#include <fstream>
#include <cstring>
#include <vector>
#include "matrix.h"
#include "mex.h"
using namespace std;

struct Atom {
    char record[7];
    int atomno;
    char atmname[6];
    char resname[5];
    char resno[5];
    char iCode[2];
    float coord[3];
    float bval;
    char subunit[2];
    float occupancy;
    char alternate[2];
    char charge[3];
    char segment[5];
    char elementSymbol[3];
    int internalResno;
};


void readFile(const char* filePath,ifstream &PDBFile){
    PDBFile.open(filePath,ifstream::in);
    if(!PDBFile.is_open()){
        mexErrMsgIdAndTxt( "AtomfromPDB:unableToOpen.","%s not found.",filePath);
    }
}

//To remove the blank
void deblank(char* str){
    int length = strlen(str);
    int start,end,i;
    for(start=0;start<length;start++){
        if(str[start]!=' '){
            break;
        }
    }
    for(end=length-1;end>=start;end--){
        if(str[end]!=' '){
            break;
        }
    }
    for(i=0;start<=end;start++,i++){
        str[i] = str[start];
    }
    str[i] ='\0';
}
void addNullStrncpy(char* copyed,const char* source,size_t size){
    strncpy(copyed,source,size);
    copyed[size] = '\0';
}
void parseATOM(const char* line,Atom& currentAtom,char* strAtomno,char* strCoord,char* strBval,char* strOccupancy){
    char record[7],atmname[6],resname[4],resno[5],iCode,subunit,alternate,charge[3],segment[5],elementSymbol[3];
    int atomno,lineLength;
    float coord[3],bval,occupancy;

    lineLength = strlen(line);
    if(strncmp(line,"ATOM",4)==0){
        addNullStrncpy(currentAtom.record,"ATOM",4);
    }else if(strncmp(line,"HETATM",6)==0 ){
        addNullStrncpy(currentAtom.record,"HETATM",6);
    }
    addNullStrncpy(strAtomno,line+6,6);
    addNullStrncpy(strCoord,line+30,24);
    addNullStrncpy(strBval,line+60,6);
    addNullStrncpy(strOccupancy,line+54,6);
    addNullStrncpy(currentAtom.atmname,line+11,5);
    deblank(currentAtom.atmname);
    addNullStrncpy(currentAtom.resname,line+17,4);
    deblank(currentAtom.resname);
    addNullStrncpy(currentAtom.resno,line+22,4);
    deblank(currentAtom.resno);
    addNullStrncpy(currentAtom.iCode,line+26,1);
    addNullStrncpy(currentAtom.subunit,line+21,1);
    addNullStrncpy(currentAtom.alternate,line+16,1);
    sscanf(strAtomno,"%d",&currentAtom.atomno);
    sscanf(strCoord,"%f %f %f",currentAtom.coord,currentAtom.coord+1,currentAtom.coord+2);
    sscanf(strBval,"%f",&currentAtom.bval);
    sscanf(strOccupancy,"%f",&currentAtom.occupancy);

    if(lineLength >= 80){
        addNullStrncpy(currentAtom.charge,line+78,2);
        deblank(currentAtom.charge);
        addNullStrncpy(currentAtom.segment,line+72,4);
        deblank(currentAtom.segment);
        addNullStrncpy(currentAtom.elementSymbol,line+76,2);
        deblank(currentAtom.elementSymbol);
    }else if(lineLength >= 78){
        *currentAtom.charge = '\0';
        addNullStrncpy(currentAtom.segment,line+72,4);
        deblank(currentAtom.segment);
        addNullStrncpy(currentAtom.elementSymbol,line+76,2);
        deblank(currentAtom.elementSymbol);
    }else if(lineLength >=76){
        *currentAtom.charge = '\0';
        *currentAtom.elementSymbol = '\0';
        addNullStrncpy(segment,line+72,4);
        deblank(currentAtom.segment);
    }else{
        *currentAtom.charge = '\0';
        *currentAtom.elementSymbol = '\0';
        *currentAtom.segment = '\0';
    }
}
void showAtomInfo(Atom currentAtom){
    cout << "record:\t"<< currentAtom.record << endl;
    cout << "atmname:\t"<< currentAtom.atmname << endl;
    cout << "resname:\t"<< currentAtom.resname << endl;
    cout << "resno:\t"<< currentAtom.resno << endl;
    cout << "subunit:\t"<< currentAtom.subunit << endl;
    cout << "atomno:\t"<< currentAtom.atomno << endl;
    cout << "segment:\t"<< currentAtom.coord[0] <<'\t' << currentAtom.coord[1] <<'\t' <<currentAtom.coord[2] << endl;
    cout << "elementSymbol:\t" << currentAtom.elementSymbol << endl;
    cout << "-------------------------------------------" <<endl;
}

vector<vector<Atom> > parse(ifstream &PDBFile,bool isNMR){
    int maxLengthLine=120 ,index = 0;
    char line[120];
    char strAtomno[7],strCoord[25],strBval[7],strOccupancy[7];
    vector<vector<Atom> > frams_ptr = vector<vector<Atom> >();
    vector<Atom> Atoms = vector<Atom>();
    Atoms.reserve(512);
    char lastResno[5]="-100";
    char lastiCode[2] = "!";
    int currentInternalResno =0;
    bool isUseENDMDL = false,isEnd = false; // prevet from geting mode number+1
    while(PDBFile.getline(line,maxLengthLine)){
        if(strncmp(line,"ATOM",4)==0 || strncmp(line,"HETATM",6)==0 ){
            Atom currentAtom;
            parseATOM(line,currentAtom,strAtomno,strCoord,strBval,strOccupancy);
            if(strncmp(currentAtom.resno,lastResno,4) || strncmp(currentAtom.iCode,lastiCode,1)){
                currentInternalResno += 1;
                addNullStrncpy(lastResno,currentAtom.resno,4);
                addNullStrncpy(lastiCode,currentAtom.iCode,1);
                currentAtom.internalResno =  currentInternalResno;
            }
            Atoms.push_back(currentAtom);
        }else if(strncmp(line,"ENDMDL",6)==0 && isNMR){
            frams_ptr.push_back(Atoms);
            Atoms = vector<Atom>();
            Atoms.reserve(512);
            isUseENDMDL = true;
            addNullStrncpy(lastResno,"-100",4);
            addNullStrncpy(lastiCode,"!",1);
            currentInternalResno = 0;
        }else if(strncmp(line,"END",3)==0 || strncmp(line,"end",3)==0 || strncmp(line,"ENDMDL",6)==0 ){
            if(!isUseENDMDL)frams_ptr.push_back(Atoms);
            isEnd = true;
            break;
        }
    }
    if(!isEnd) frams_ptr.push_back(Atoms);
    return frams_ptr;
}

void atoms2structure(const vector<Atom> &atoms,mxArray *PDBStruct){
    int resname = mxGetFieldNumber(PDBStruct, "resname");
    int record = mxGetFieldNumber(PDBStruct, "record");
    int atomno = mxGetFieldNumber(PDBStruct, "atomno");
    int atmname = mxGetFieldNumber(PDBStruct, "atmname");
    int resno = mxGetFieldNumber(PDBStruct, "resno");
    int iCode = mxGetFieldNumber(PDBStruct, "iCode");
    int coord = mxGetFieldNumber(PDBStruct,"coord");
    int bval = mxGetFieldNumber(PDBStruct, "bval");
    int subunit = mxGetFieldNumber(PDBStruct, "subunit");
    int occupancy = mxGetFieldNumber(PDBStruct, "occupancy");
    int alternate = mxGetFieldNumber(PDBStruct, "alternate");
    int charge = mxGetFieldNumber(PDBStruct, "charge");
    int segment = mxGetFieldNumber(PDBStruct, "segment");
    int elementSymbol = mxGetFieldNumber(PDBStruct, "elementSymbol");
    int internalResno = mxGetFieldNumber(PDBStruct, "internalResno");
    int numberOfAtoms = atoms.size();
    for(int i=0; i < numberOfAtoms; i++){
        mxArray *coordArray = mxCreateDoubleMatrix(3,1,mxREAL);
        double *coordData = mxGetPr(coordArray);
        coordData[0] = atoms[i].coord[0];
        coordData[1] = atoms[i].coord[1];
        coordData[2] = atoms[i].coord[2];
        mxSetFieldByNumber(PDBStruct,i,resname,mxCreateString(atoms[i].resname));
        mxSetFieldByNumber(PDBStruct,i,record,mxCreateString(atoms[i].record));
        mxSetFieldByNumber(PDBStruct,i,atomno,mxCreateDoubleScalar(atoms[i].atomno));
        mxSetFieldByNumber(PDBStruct,i,atmname,mxCreateString(atoms[i].atmname));
        mxSetFieldByNumber(PDBStruct,i,resno,mxCreateString(atoms[i].resno));
        mxSetFieldByNumber(PDBStruct,i,iCode,mxCreateString(atoms[i].iCode));
        mxSetFieldByNumber(PDBStruct,i,coord,coordArray);
        mxSetFieldByNumber(PDBStruct,i,bval,mxCreateDoubleScalar(atoms[i].bval));
        mxSetFieldByNumber(PDBStruct,i,subunit,mxCreateString(atoms[i].subunit));
        mxSetFieldByNumber(PDBStruct,i,occupancy,mxCreateDoubleScalar(atoms[i].occupancy));
        mxSetFieldByNumber(PDBStruct,i,alternate,mxCreateString(atoms[i].alternate));
        mxSetFieldByNumber(PDBStruct,i,charge,mxCreateString(atoms[i].charge));
        mxSetFieldByNumber(PDBStruct,i,segment,mxCreateString(atoms[i].segment));
        mxSetFieldByNumber(PDBStruct,i,elementSymbol,mxCreateString(atoms[i].elementSymbol));
        mxSetFieldByNumber(PDBStruct,i,internalResno,mxCreateDoubleScalar(atoms[i].internalResno));
    }
}

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]){
    const char *field_names[] = {"resname", "record", "atomno", "atmname", "resno", "iCode", "coord", "bval", "subunit",
     "occupancy", "alternate", "charge", "segment", "elementSymbol","internalResno"};
    int numberOfFields = 15;
    if (nrhs > 3) {
        mexErrMsgIdAndTxt( "AtomfromPDB:argumentsError","Too many arguments.");
    }else if(nrhs < 1){
        mexErrMsgIdAndTxt( "AtomfromPDB:argumentsError",
                "Not enough argument.");
    }
    bool isNMR = false;
    if (nrhs>1 && mxGetScalar(prhs[1])>0 )isNMR = true;
    
    size_t fileNameLength = mxGetN(prhs[0]) * sizeof(mxChar)+1;
    char* fileName;
    fileName = (char*) mxMalloc(fileNameLength);
    if(!mxGetString(prhs[0],fileName,(mwSize)fileNameLength)){
        ifstream PDBFile;
        readFile(fileName,PDBFile);
        vector<vector<Atom> > frams = parse(PDBFile,isNMR);
        if(frams.size()==1){
            size_t atomNum = frams[0].size();
            plhs[0] = mxCreateStructMatrix(1,(mwSize) atomNum,numberOfFields,field_names);
            atoms2structure(frams[0],plhs[0]);
        }else if(frams.size()>1){
            size_t NumberOfFrams = frams.size();
            plhs[0] = mxCreateCellMatrix(1,(mwSize) NumberOfFrams);
            for(int i=0; i <NumberOfFrams; i++){
                size_t atomNum = frams[i].size();
                mxArray *currentFram = mxCreateStructMatrix(1,(mwSize) atomNum,numberOfFields,field_names);
                atoms2structure(frams[i],currentFram);
                mxSetCell(plhs[0],i,currentFram);
            }
        }else if(frams.size()<1){
            mexErrMsgIdAndTxt( "AtomfromPDB:parseError","no atom inside %s.",fileName);
        }
    }
    return;
}
