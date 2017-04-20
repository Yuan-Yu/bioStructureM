function [logicIndexArray]=basicSelector_sequence(PDBStructure,selectionCell)
%%%%%%%%%%%%%% need %%%%%%%%%%%%%
% input:
%   PDBStructure
%   selectionString
% return:
%   logicIndexArray
%%%%%%%%%%%%%% need %%%%%%%%%%%%%

%parse selectionString
if length(selectionCell) ==2
    targetSeq = selectionCell{1};
    tolerance = str2double(selectionCell{2});
else
    targetSeq = selectionCell{1};
    tolerance = 0.8;
end
% check which atom will be selection
allNames = {PDBStructure.atmname};
allResnames = {PDBStructure.resname};
allInternalResnos = [PDBStructure.internalResno];
allChainIDs = [PDBStructure.subunit];

proteinIndexArray=strcmp(allNames,'CA');
proteinIndexArray(strcmp(allResnames,'CA')) = 0;


matchedInternalResnos = [];
if sum(proteinIndexArray) ~= 0
    load dict.mat
    load aa2order.mat
    load blosum62.mat
    prefectTreshod = sum(arrayfun(@(x) blosum(aa2order(x),aa2order(x)),targetSeq));
    proteinResnames = allResnames(proteinIndexArray);
    proteinChainIDs = allChainIDs(proteinIndexArray);
    proteinInternalResnos = allInternalResnos(proteinIndexArray);
    chainList = unique(proteinChainIDs);
    for chianID = chainList
        currentChainIndex = proteinChainIDs == chianID;
        currentResnames = proteinResnames(currentChainIndex);
        currentInternalResnos = proteinInternalResnos(currentChainIndex);
        try
            sequence = cellfun(@(x) dict.get(x),currentResnames);
        catch e
            throw(MException('atomSelector:SequenceTransformError','unknown amino acid code'));
        end
        alignResult = alignSeqRepeatProt(sequence,targetSeq,-4,-prefectTreshod*tolerance);
        matchPart = alignResult(2,alignResult(1,:)~='-') ~= '.';
        matchedInternalResnos = [matchedInternalResnos currentInternalResnos(matchPart)];
    end
    logicIndexArray = ismember(allInternalResnos,matchedInternalResnos);
else
    logicIndexArray = [];
end
%return logic Array