function [PDBStructure] = getAtomByAlternate(PDBStructure,alternates)
%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%
% input:
%   PDBStructure: The stucture array gotten from readPDB
%   alternates: a cell contains allowed alternate strings 
% return:
%   PDBStructure: only contains the atoms that alternate code match the "alternates"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

PDBAlternates = {PDBStructure.alternate};
indexBeSelected = false(1,length(PDBAlternates));
for i = 1:length(alternates)
    indexBeSelected(:) = indexBeSelected | strcmp(PDBAlternates,alternates{i});
end
PDBStructure = PDBStructure(indexBeSelected);