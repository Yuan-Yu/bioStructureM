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
    internalResnos = [PDBStructure.internalResno];
    logicIndexArray=ismember(internalResnos,internalResnos(inputCell{1}));
else
    logicIndexArray=inputCell{1};
end
