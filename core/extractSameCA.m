function [newCA1,newCA2]=extractSameCA(pdbStructure1,pdbStructure2,displayAlign)
%%%%%%% need %%%%%
% Input:
%   pdbStructure1: the object gotten from readPDB.
%   pdbStructure2: the object gotten from readPDB.
%	displayAlign : set 1 will display the alignment result.
%  Note:
%   Do not allow amino acid and nucleotide in same chain.  
%   The chain IDs will not be checked, so pdbStructure1 and pdbStructure2 should have exactly the same chain order.
%   Additional chains in one pdbStructure but not in the other should be
%   placed at the end of the pdbStructure, and will be removed
%   automatically
%   Ex:
%   Chain of pdbStructure1: ABDEFGCIJ
%   Chain of pdbStructure2: ABDEFG--- 
% Return:
%   newCA1 : same or similar element 
%   newCA2 : same or similar element 
%%%%%%% need %%%%%
    if ~exist('displayAlign','var')
        displayAlign=0;
    end

    chainID1=unique([pdbStructure1.subunit],'stable');
    chainID2=unique([pdbStructure2.subunit],'stable');
    numOfChain=min(length(chainID1),length(chainID2));
    sameChain1=cell(1,numOfChain);
    sameChain2=cell(1,numOfChain);
    pdbStructure1 = getTmpResID(pdbStructure1);
    pdbStructure2 = getTmpResID(pdbStructure2);
    for i=1:numOfChain

        tmpChain1=getChainFromCa(pdbStructure1,chainID1(i));
        tmpChain2=getChainFromCa(pdbStructure2,chainID2(i));
        isAmino= isempty(regexp(tmpChain1(1).resname,'(?<=^\s*)\w{1}(?=\s*$)','ONCE'));
        if isAmino
            [sameChain1{i},sameChain2{i},StrX,StrY]=oneChainExtractSameCA(tmpChain1,tmpChain2);
            if displayAlign 
                display([chainID1(i) '  :']);
                display([StrX;StrY]);
            end
        else
            [sameChain1{i},sameChain2{i},Alignment]=oneChainExtractSameNucleotides(tmpChain1,tmpChain2);
            if displayAlign
                display([chainID1(i) '  :' ]);
                display([Alignment(1,:)]);
                display([Alignment(2,:)]);
            end
        end
    end
    newCA1=[];
    newCA2=[];
    for i=1:numOfChain
        newCA1=[newCA1,sameChain1{i}];
        newCA2=[newCA2,sameChain2{i}];
    end
    newCA1 = rmfield(newCA1,'tmpResID');
    newCA2 = rmfield(newCA2,'tmpResID');
end
function PDBStructure=getTmpResID(PDBStructure)
    current_ResidueID=1;
    last_ResidueNum_iCode=[ PDBStructure(1).resno  PDBStructure(1).iCode];
    for i = 1:length(PDBStructure)
        current_ResidueNum_iCode = [ PDBStructure(i).resno  PDBStructure(i).iCode];
        if ~strcmp(last_ResidueNum_iCode,current_ResidueNum_iCode)
            current_ResidueID =current_ResidueID+1;
            last_ResidueNum_iCode =current_ResidueNum_iCode;
        end
        PDBStructure(i).tmpResID=current_ResidueID;
    end
end