function [structure]=readPDB(pdbName,checkMissing,pdbType)
%%%%%%%%%%%%%%%% need cafrompdb,getAtomByAtomName,getBondLengths%%%%%%%%%%%%%%%%%%
% input:
%   pdbName: The name of the pdb file
%   checkMissing: The value of this is 0 or 1. Setting 0 meams that do not check missing residues.
%   pdbType: 'X-ray' or 'NMR'. (Default is X-ray).
% return:
%   structure is a structure array. 
%		The structure contain attribute below
%                                 resname
%                                 atmname
%                                 resno
%                                 coord
%                                 bval
%                                 subunit
%                                 record
%                                 atomno
%                                 occupancy
%                                 segment
%                                 elementSymbol
%                                 alternate
%                                 charge
%%%%%%%%%%%%%%%% need cafrompdb,getAtomByAtomName,getBondLengths%%%%%%%%%%%%%%%%%%
if ~exist('pdbType','var')
    pdbType='X-ray';
end
if ~exist('checkMissing','var')
    checkMissing=0;
end

structure=cafrompdb(pdbName,pdbType);

if checkMissing
	chains=separatePDBByChain(structure);
	for chainIndex=1:length(chains)
		bonds=getBondLengths(getAtomByAtomName(chains{chainIndex},'CA'));
		if ~isempty(find(bonds>4.3,1))
			error(['The ' pdbName ' have some missing residues']);
		end
	end
end
    