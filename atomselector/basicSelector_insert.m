function [logicIndexArray]=basicSelector_insert(PDBStructure,selectionCell)
%%%%%%%%%%%%%% need %%%%%%%%%%%%%
% input:
%   PDBStructure
%   selectionString
% return:
%   logicIndexArray
%%%%%%%%%%%%%% need %%%%%%%%%%%%%

logicIndexArray=ismember({PDBStructure.iCode},selectionCell);