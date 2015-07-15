function [nucleotides]=getNucleotides(PDBStructure,getORremove)
%%%%%%%%%%% need %%%%%%%%%%%%
% input:
%   PDBStructure: the object gotten from cafrompdb
%   getORremove is an logic variable. get=0,remove=1; Default:0
% return:
%   nucleotides : The Nucleotides in the PDBStructure
%%%%%%%%%%% need %%%%%%%%%%%%

if ~exist('getORremove','var')
    getORremove=0;
end


resnames=regexp({PDBStructure.resname},'(?<=^\s*)\w{1}(?=\s*$)','match');

if ~getORremove
    index = cellfun(@isempty,resnames)==0;
    nucleotides=PDBStructure(index);
else
    index = cellfun(@isempty,resnames);
    nucleotides=PDBStructure(index);
end