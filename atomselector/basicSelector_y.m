function [logicIndexArray]=basicSelector_y(PDBStructure,selectionCell)
%%%%%%%%%%%%%% need %%%%%%%%%%%%%
% input:
%   PDBStructure
%   selectionString
% return:
%   logicIndexArray
%%%%%%%%%%%%%% need %%%%%%%%%%%%%

coord=[PDBStructure.coord];
pdbCoord_y=coord(2,:);
selection='pdbCoord_y';
for i =1:length(selectionCell)
    tmp=regexprep(selectionCell{i},'^=','==');
    selection=strcat(selection,tmp);
end
logicIndexArray=eval(selection);