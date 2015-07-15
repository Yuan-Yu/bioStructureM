function [logicIndexArray]=basicSelector_HETATM(PDBStructure,selectionCell)
%%%%%%%%%%%%%% need %%%%%%%%%%%%%
% input:
%   PDBStructure
%   selectionString
% return:
%   logicIndexArray
%%%%%%%%%%%%%% need %%%%%%%%%%%%%

%parse selectionString
logicIndexArray=strcmp({PDBStructure.record},'HETATM');
% check which atom will be selection

%return logic Array