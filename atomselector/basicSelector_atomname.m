function [logicIndexArray]=basicSelector_atomname(PDBStructure,selectionCell)
%%%%%%%%%%%%%% need %%%%%%%%%%%%%
% input:
%   PDBStructure
%   selectionString
% return:
%   logicIndexArray
%%%%%%%%%%%%%% need %%%%%%%%%%%%%
selectionString = '';
for i =1:length(selectionCell)
    oneWord = regexprep(selectionCell{i},'\*','.*');
    selectionString = strcat(selectionString,'^',oneWord,'$||');
end
selectionString=regexprep(selectionString,'\|\|$','');
tmpcell=regexp({PDBStructure.atmname},selectionString,'once');
logicIndexArray=~cellfun(@isempty,tmpcell);
