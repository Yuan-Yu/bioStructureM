function [logicIndexArray]=basicSelector_water(PDBStructure,selectionCell)
%%%%%%%%%%%%%% need %%%%%%%%%%%%%
% input:
%   PDBStructure
%   selectionString
% return:
%   logicIndexArray
%%%%%%%%%%%%%% need %%%%%%%%%%%%%

%parse selectionString
allResname={PDBStructure.resname};
% check which atom will be selection
logicIndexArray=ismember(allResname,{'H2O' 'HH0' 'OHH' 'HOH' 'OH2' 'SOL' 'WAT' 'TIP' 'TIP2' 'TIP3' 'TIP4'});
%return logic Array