function [PDBStructure] = setMass(PDBStructure,elementSymbol2mass)
%%%%%%%%%%%% need %%%%%%%%%%%%
%
% input:
%   PDBStructure: the structure array of pdb
%   elementSymbol2mass(option): the dict (containers.Map) of mass 
% return:
%   PDBStructure: PDBStructure has mass attribute.
%%%%%%%%%%%% need %%%%%%%%%%%%

if ~exist('elementSymbol2mass','var')
    load elementSymbol2mass.mat
end
atomNum = length(PDBStructure);

for i = 1:atomNum
    PDBStructure(i).mass =  elementSymbol2mass(PDBStructure(i).elementSymbol);
end
