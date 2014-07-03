function [resno,chainIDs]=getResnoFromCA(ca)
%%%%%% need %%%%%%%%
% input:
%   ca
% return:
%   resno is a cell
%   chainIDs is a array
%%%%%% need %%%%%%%%
chainIDs=unique([ca.subunit]);
numOfCahin=length(chainIDs);
resno=cell(1,numOfCahin);
for i=1:numOfCahin
    chain=getChainFromCa(ca,chainIDs(i));
    resno{i}=[chain.resno];
end