function [logicIndexArray]=basicSelector_x(PDBStructure,selectionCell)
%%%%%%%%%%%%%% need %%%%%%%%%%%%%
% input:
%   PDBStructure
%   selectionString
% return:
%   logicIndexArray
%%%%%%%%%%%%%% need %%%%%%%%%%%%%

coord=[PDBStructure.coord];
pdbCoord_x=coord(1,:);
selection='pdbCoord_x';
for i =1:length(selectionCell)
    tmp=regexprep(selectionCell{i},'^=','==');
    selection=strcat(selection,tmp);
end
logicIndexArray=eval(selection);