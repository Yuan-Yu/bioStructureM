function [PDBStructure] = assignMass(PDBStructure,elementSymbol2mass)
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
    try
        PDBStructure(i).mass =  elementSymbol2mass(PDBStructure(i).elementSymbol);
    catch e
        if strcmp(e.identifier,'MATLAB:Containers:Map:NoKey')
            warning('useful_fuc:UnknownAtomName','Unknown atom name "%s" at atom %d : poorly assign the mass to 0',PDBStructure(i).atmname,PDBStructure(i).atomno);
            PDBStructure(i).mass = 0;
        else
            rethrow(e);
        end
    end
end
