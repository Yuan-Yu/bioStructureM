function [logicIndexArray]=basicSelector_z(PDBStructure,selectionCell)
%%%%%%%%%%%%%% need %%%%%%%%%%%%%
% input:
%   PDBStructure
%   selectionString
% return:
%   logicIndexArray
%%%%%%%%%%%%%% need %%%%%%%%%%%%%

coord=[PDBStructure.coord];
pdbCoord_z=coord(3,:);
selection='pdbCoord_z';
for i =1:length(selectionCell)
    tmp=regexprep(selectionCell{i},'^=','==');
    selection=strcat(selection,tmp);
end
logicIndexArray=eval(selection);