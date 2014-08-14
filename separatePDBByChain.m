function [pdbCell,allChainID]=separatePDBByChain(pdb)
%%%%%%%%%%%%% need %%%%%%%%%%%%%%%%%%
% input:
%   pdb is the structure gotten from cafrompdb
% return:
%   pdbcell: the atoms in same chain will be a structure put in this cell array.
%       ex. pdbX is a two chain protein.
%           the pdbcell is { cafrompdbStructure_chain1 , cafrompdbStructure_chain2}
%   allChainID: all chainIDs
%%%%%%%%%%%%% need %%%%%%%%%%%%%%%%%%

    atomChainIDList=[pdb.subunit];
    allChainID=unique(atomChainIDList);
    numOfChain=length(allChainID);
    pdbCell=cell(1,length(numOfChain));
    for i=1:numOfChain
        pdbCell{i}=pdb(atomChainIDList==allChainID(i));
    end
end