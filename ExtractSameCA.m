function [newCA1,newCA2]=extractSameCA(ca1,ca2)
%%%%%%% need %%%%%
% input:
%   ca1
%   ca2
% return:
%   newCA1
%   newCA2
%%%%%%% need %%%%%
chainID1=unique([ca1.subunit]);
chainID2=unique([ca2.subunit]);
numOfChain=min(length(chainID1),length(chainID2));
sameChain1=cell(1,numOfChain);
sameChain2=cell(1,numOfChain);
for i=1:numOfChain
    [sameChain1{i},sameChain2{i}]=oneChainExtractSameCA(getChainFromCa(ca1,chainID1(i)),getChainFromCa(ca2,chainID2(i)));
end
newCA1=[];
newCA2=[];
for i=1:numOfChain
    newCA1=[newCA1,sameChain1{i}];
    newCA2=[newCA2,sameChain2{i}];
end