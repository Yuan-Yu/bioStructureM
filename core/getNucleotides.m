function [nucleotides]= getNucleotides(pdbStructure,getORremove,islogical,nucleotideThree2One)
%%%%%%%%%%% need %%%%%%%%%%%%
% input:
%   PDBStructure: the object gotten from cafrompdb
%   getORremove is an logic variable. get=0,remove=1; Default:0
%   islogical: if 0 return a pdb structure array,Default:0
%	nucleotideThree2One: the conterners.Map for covering three to one letter
% return: 
%   nucleotides : The Nucleotides in the PDBStructure or index
%%%%%%%%%%% need %%%%%%%%%%%%
    if ~exist('nucleotideThree2One','var')
        load nucleotideThree2One.mat
    end
    if ~exist('getORremove','var')
        getORremove = 0;
    end
    if ~exist('islogical','var')
        islogical = 0;
    end
    resNames = {pdbStructure.resname};
    nucleotidesResNames = nucleotideThree2One.keys;
    internalResnos = [pdbStructure.internalResno];
    [~,ia, ic] = unique(internalResnos);
    nucleotidesIndex = cellfun(@(x) any(strcmp(x,nucleotidesResNames)),resNames(ia));
    nucleotidesIndex = nucleotidesIndex(ic);
    
    if getORremove
        nucleotidesIndex = ~nucleotidesIndex;
    end
    if islogical
        nucleotides = nucleotidesIndex;
    else
        nucleotides = pdbStructure(nucleotidesIndex);
    end
end