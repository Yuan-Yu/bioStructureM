function [logicIndexArray]=basicSelector_all(PDBStructure,selectionCell)
%%%%%%%%%%%%%% need %%%%%%%%%%%%%
% input:
%   PDBStructure
%   selectionString
% return:
%   logicIndexArray
%%%%%%%%%%%%%% need %%%%%%%%%%%%%

%parse selectionString

% check which atom will be selection
logicIndexArray=true(1,length(PDBStructure));
%return logic Array