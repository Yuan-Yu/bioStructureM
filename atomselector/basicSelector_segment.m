function [logicIndexArray]=basicSelector_segment(PDBStructure,selectionCell)
%%%%%%%%%%%%%% need %%%%%%%%%%%%%
% input:
%   PDBStructure
%   selectionString
% return:
%   logicIndexArray
%%%%%%%%%%%%%% need %%%%%%%%%%%%%
logicIndexArray=ismember({PDBStructure.segment},selectionCell);