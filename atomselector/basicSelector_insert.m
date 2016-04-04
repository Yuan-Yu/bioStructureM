function [logicIndexArray]=basicSelector_insert(PDBStructure,selectionCell)
%%%%%%%%%%%%%% need %%%%%%%%%%%%%
% input:
%   PDBStructure
%   selectionString
% return:
%   logicIndexArray
%%%%%%%%%%%%%% need %%%%%%%%%%%%%
selectionCell = regexprep(selectionCell,'\\s',' ');
logicIndexArray=ismember({PDBStructure.iCode},selectionCell);