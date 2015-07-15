function [logicIndexArray]=basicSelector_chain(PDBStructure,selectionCell)
%%%%%%%%%%%%%% need %%%%%%%%%%%%%
% input:
%   PDBStructure
%   selectionString
% return:
%   logicIndexArray
%%%%%%%%%%%%%% need %%%%%%%%%%%%%

logicIndexArray=ismember({PDBStructure.subunit},selectionCell);
