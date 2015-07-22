function [newCA1,newCA2]=extractSameCA(pdbStructure1,pdbStructure2,displayAlign)
%%%%%%% need %%%%%
% Input:
%   pdbStructure1: the object gotten from readPDB.
%   pdbStructure2: the object gotten from readPDB.
%	displayAlign : set 1 will display the alignment result.
%  Note:
%   Do not allow amino acid and nucleotide in same chain.  
%   The chain order should be same at each ca. 
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