function [nucleotides]=getNucleotides(PDBStructure,getORremove,nucleotideThree2One)
%%%%%%%%%%% need %%%%%%%%%%%%
% input:
%   PDBStructure: the object gotten from cafrompdb
%   getORremove is an logic variable. get=0,remove=1; Default:0
%	nucleotideThree2One: the conterners.Map for covering three to one letter
% return: 
%   nucleotides : The Nucleotides in the PDBStructure
%%%%%%%%%%% need %%%%%%%%%%%%
if ~exist('getORremove','var')
    getORremove=0;
end
if ~exist('nucleotideThree2One','var')
	load nucleotideThree2One.mat
end
	

for i = 1:length(PDBStructure)
	if nucleotideThree2One.isKey(PDBStructure(i).resname)
		PDBStructure(i).internal_resname = nucleotideThree2One(PDBStructure(i).resname);
	else
		PDBStructure(i).internal_resname = PDBStructure(i).resname;
	end
end

resnames=regexp({PDBStructure.internal_resname},'(?<=^\s*)\w{1}(?=\s*$)','match');
PDBStructure = rmfield(PDBStructure,'internal_resname');

if ~getORremove
    index = cellfun(@isempty,resnames)==0;
    nucleotides=PDBStructure(index);
else
    index = cellfun(@isempty,resnames);
    nucleotides=PDBStructure(index);
end