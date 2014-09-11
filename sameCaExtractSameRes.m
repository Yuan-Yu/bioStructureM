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
    if strcmpi(class(refSelectResno{1}),'double')
        for i=1:length(refSelectResno)
            refSelectResno{i}=regexp(num2str(refSelectResno{i}),'\s*','split');
        end
    end
    refResno={refca.resno};
    refChain={refca.subunit};
    refSpecialID=cellfun(@(x,y) [x y],refResno,refChain,'UniformOutput',0);
%     refSpecialID=refResno*10000+double(refChain);
    refSelectSpecialID={};
    for j=1:length(refSelectChainIDs)
        resno=refSelectResno{j};
        refSelectSpecialID=[refSelectSpecialID strcat(resno,refSelectChainIDs(j))];
    end
    index=ismember(refSpecialID,refSelectSpecialID);
    newca=ca(index);
    newrefca=refca(index);