function [sequence,seletedChains] = getSequence(pdbStructure,seletedChains,dict)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% extract amino acid sequence from pdb
% input:
%   pdbStructure: the structure array gotten by readPDB.
%   seletedChains (optional): a char array contain the chain ID which would be extrated.
%   dict (optional): a java dictionary for mapping three letters to one letter
%   nonAminoResWithCA: a cell contains the residue name of non-amino acid
%       group with CA atoms. ex. CA (Calcium)
% return:
%   seletedChains: return original seletedChains,if seletedChains is given. Otherwise, return
%         all the chain ids in pdb structure.
%   sequence: a cell array. The order of sequce would respect chian id
%           array.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tmpPDB = getAminoAcidCA(pdbStructure);

if isempty(tmpPDB)
    seletedChains = '';
    sequence = {};
    warning('This is not a protein PDB.');
    return
end
if ~exist('dict','var')
    load dict.mat
end
if ~exist('seletedChains','var')
    seletedChains = unique([tmpPDB.subunit],'stable');
end


ResNames = {tmpPDB.resname};
chainIDs = [tmpPDB.subunit];
numChain = length(seletedChains);
sequence = cell(1,numChain);
for i = 1:numChain
    chainID = seletedChains(i);
    try
        sequence{i} = cellfun(@(x) dict.get(x),ResNames(regexp(chainIDs,chainID)));
    catch e
        errorIndex = str2double(regexp(e.message,'(?<=at index )[0-9]*(?=,)','match'));
        currentChainResnames = ResNames(regexp(chainIDs,chainID));
       throw(MException('BiostructureM:SequenceThansform',['Unknown residue name: ' currentChainResnames{errorIndex}]));
    end
end


