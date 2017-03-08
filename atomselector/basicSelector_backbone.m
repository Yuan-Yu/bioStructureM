function [logicIndexArray]=basicSelector_backbone(PDBStructure,selectionCell)
%%%%%%%%%%%%%% need %%%%%%%%%%%%%
% input:
%   PDBStructure
%   selectionString
% return:
%   logicIndexArray
%%%%%%%%%%%%%% need %%%%%%%%%%%%%

%parse selectionString

% check which atom will be selection
atomNum=length(PDBStructure);
all_names = {PDBStructure.atmname};
all_resnames = {PDBStructure.resname};
logicIndexArray=strcmp(all_names,'CA');
logicIndexArray(strcmp(all_resnames,'CA')) = 0;
index = find(logicIndexArray);
startIndex = min(index)-10;
if startIndex<=0
    startIndex =1;
end
endIndex = max(index)+40;
if endIndex > atomNum
    endIndex = atomNum;
end

tmpResidueIDs=zeros(1,endIndex-startIndex+1);
current_ResidueID=1;
last_ResidueNum_iCode=[ PDBStructure(startIndex).resno  PDBStructure(startIndex).iCode];
for i = 1:endIndex-startIndex+1
    current_ResidueNum_iCode = [ PDBStructure(startIndex+i-1).resno  PDBStructure(startIndex+i-1).iCode];
    if ~strcmp(last_ResidueNum_iCode,current_ResidueNum_iCode)
        current_ResidueID =current_ResidueID+1;
        last_ResidueNum_iCode =current_ResidueNum_iCode;
    end
    tmpResidueIDs(i)=current_ResidueID;
end
logicIndexArray(startIndex:endIndex) = ismember(tmpResidueIDs,tmpResidueIDs(logicIndexArray(startIndex:endIndex)));
logicIndexArray(logicIndexArray)= ismember(all_names(logicIndexArray),{'C' 'O' 'N' 'CA'});
%return logic Array