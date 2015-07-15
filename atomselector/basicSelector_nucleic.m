function [logicIndexArray]=basicSelector_nucleic(PDBStructure,selectionCell)
%%%%%%%%%%%%%% need %%%%%%%%%%%%%
% input:
%   PDBStructure
%   selectionString
% return:
%   logicIndexArray
%%%%%%%%%%%%%% need %%%%%%%%%%%%%

%parse selectionString

% check which atom will be selection

% 'O3''' 'C3''' 'C4''' 'C5'''...
%     'O3*' 'C3*' 'C4*' 'C5*' 'O5*
atomNum=length(PDBStructure);
tmpResidueIDs=zeros(1,length(PDBStructure));
current_ResidueID=1;
last_ResidueNum_iCode=[ PDBStructure(1).resno  PDBStructure(1).iCode];
for i = 1:atomNum
    current_ResidueNum_iCode = [ PDBStructure(i).resno  PDBStructure(i).iCode];
    if ~strcmp(last_ResidueNum_iCode,current_ResidueNum_iCode)
        current_ResidueID =current_ResidueID+1;
        last_ResidueNum_iCode =current_ResidueNum_iCode;
    end
    tmpResidueIDs(i)=current_ResidueID;
end
allAtomName={PDBStructure.atmname};
OP_logicIndexArray=ismember(allAtomName,{'P' 'OP1' 'OP2'});
other_logicIndexArray=ismember(allAtomName,{'O3''' 'C3''' 'C4''' 'C5''' 'O5''' 'O3*' 'C3*' 'C4*' 'C5*' 'O5*'});
resIDs = 1:tmpResidueIDs(end);
OPResID_logicIndexArray=histc(tmpResidueIDs(OP_logicIndexArray),resIDs)>=3;
other_logicIndexArray=histc(tmpResidueIDs(other_logicIndexArray),resIDs)>=4;
selectedResidueIDs=resIDs(OPResID_logicIndexArray & other_logicIndexArray);
% check terminal
theResNoPhosphate=resIDs(xor(other_logicIndexArray,OPResID_logicIndexArray));
terminalResIDs=theResNoPhosphate(ismember(theResNoPhosphate+1,selectedResidueIDs) | ismember(theResNoPhosphate-1,selectedResidueIDs));
logicIndexArray=ismember(tmpResidueIDs,[selectedResidueIDs,terminalResIDs]);
%return logic Array