function [logicIndexArray]=basicSelector_chain(PDBStructure,selectionCell)
%%%%%%%%%%%%%% need %%%%%%%%%%%%%
% input:
%   PDBStructure
%   selectionString
% return:
%   logicIndexArray
%%%%%%%%%%%%%% need %%%%%%%%%%%%%
selectionCell = regexprep(selectionCell,'\\s',' ');
logicIndexArray=ismember({PDBStructure.subunit},selectionCell);
