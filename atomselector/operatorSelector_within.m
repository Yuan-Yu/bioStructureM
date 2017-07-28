function [logicIndexArray]=operatorSelector_within(keyword,PDBStructure,inputCell)
%%%%%%%%%%%%%% need %%%%%%%%%%%%%
% input:
%   keyword
%   PDBStructure
%   inputCell
% return:
%   logicIndexArray
%%%%%%%%%%%%%% need %%%%%%%%%%%%%
strCutoff=regexp(keyword,'[0-9]*\.?[0-9]*','match');
cutoff = str2double(strCutoff);
sqcutoff = cutoff^2;
if sum(inputCell{1}) ==0 ||sum(inputCell{2}) ==0
    logicIndexArray = false(1,length(inputCell{1}));
else
    subPDB1 = PDBStructure(inputCell{1});
    subPDB2 = PDBStructure(inputCell{2});
    contactMatrix = getContactMatrix(subPDB1,subPDB2,cutoff);
    MajorLogical = sum(contactMatrix,2) > 0;
    logicIndexArray = inputCell{2};
    logicIndexArray(logicIndexArray)=MajorLogical(:);
end


end

