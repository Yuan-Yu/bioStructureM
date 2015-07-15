function [logicIndexArray]=operatorSelector_byres(keyword,PDBStructure,inputCell)
%%%%%%%%%%%%%% need %%%%%%%%%%%%%
% input:
%   keyword
%   PDBStructure
%   inputCell
% return:
%   logicIndexArray
%%%%%%%%%%%%%% need %%%%%%%%%%%%%
if sum(inputCell{1})~=0
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
    logicIndexArray=ismember(tmpResidueIDs,tmpResidueIDs(inputCell{1}));
else
    logicIndexArray=inputCell{1};
end
