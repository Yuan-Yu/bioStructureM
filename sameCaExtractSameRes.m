function [newrefca,newca]=sameCaExtractSameRes(refca,ca,refSelectResno,refSelectChainIDs)
%%%%%%%% need %%%%%%%%%%
% input:
%   refca
%   ca
%   refResno
%   refChainIDs
% return:
%   newrefca
%   newca
%%%%%%%% need %%%%%%%%%%
    refResno=[refca.resno];
    refChain=[refca.subunit];
    refSpecialID=refResno*10000+double(refChain);
    refSelectSpecialID=[];
    for j=1:length(refSelectChainIDs)
        resno=refSelectResno{j};
        refSelectSpecialID=[refSelectSpecialID,resno*10000+double(refSelectChainIDs(j))];
    end
    index=ismember(refSpecialID,refSelectSpecialID);
    newca=ca(index);
    newrefca=refca(index);