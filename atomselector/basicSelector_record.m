function [logicIndexArray]=basicSelector_record(PDBStructure,selectionCell)
%%%%%%%%%%%%%% need %%%%%%%%%%%%%
% input:
%   PDBStructure
%   selectionString
% return:
%   logicIndexArray
%%%%%%%%%%%%%% need %%%%%%%%%%%%%


logicIndexArray=ismember({PDBStructure.record},selectionCell);