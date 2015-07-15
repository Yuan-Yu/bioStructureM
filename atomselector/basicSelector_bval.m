function [logicIndexArray]=basicSelector_bval(PDBStructure,selectionCell)
%%%%%%%%%%%%%% need %%%%%%%%%%%%%
% input:
%   PDBStructure
%   selectionString
% return:
%   logicIndexArray
%%%%%%%%%%%%%% need %%%%%%%%%%%%%

bval=[PDBStructure.bval];
selection='bval';
for i =1:length(selectionCell)
    tmp=regexprep(selectionCell{i},'^=','==');
    selection=strcat(selection,tmp);
end
logicIndexArray=eval(selection);