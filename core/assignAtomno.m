function [pdbStructure] = assignAtomno(pdbStructure)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% reassign Atom number from 1 to number of atom
% input:
%   pdbStructure: The structure array gotten by readPDB.
% return:
%   pdbStructure: The pdb structure array that atom number be reassigned.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1 : length(pdbStructure)
    pdbStructure(i).atomno = i;
end    