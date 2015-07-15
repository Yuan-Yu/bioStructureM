function [logicIndexArray]=operatorSelector_within(keyword,PDBStructure,inputCell)
%%%%%%%%%%%%%% need %%%%%%%%%%%%%
% input:
%   keyword
%   PDBStructure
%   inputCell
% return:
%   logicIndexArray
%%%%%%%%%%%%%% need %%%%%%%%%%%%%
strCutoff=regexp(keyword,'[0-9]*\.?[0-9]*','match');
cutoff = str2double(strCutoff);
sqcutoff = cutoff^2;
if sum(inputCell{1}) ==0 ||sum(inputCell{2}) ==0
    logicIndexArray = false(1,length(inputCell{1}));
else
    subPDB1 = PDBStructure(inputCell{1});
    subPDB2 = PDBStructure(inputCell{2});
    crd1 = [subPDB1.coord];
    crd2 = [subPDB2.coord];
    [~,cNum]=size(crd2);
    [~,NumOfSubPDB1]=size(crd1);
    tmpLogical = false(1,cNum);
    MajorLogical =false(1,cNum);
    for i=1:NumOfSubPDB1
        tmpLogical(:) = (abs(crd2(1,:) -crd1(1,i)) < cutoff);
        tmpLogical(tmpLogical) = (abs(crd2(2,tmpLogical) -crd1(2,i)) < cutoff);
        tmpLogical(tmpLogical) = (abs(crd2(3,tmpLogical) -crd1(3,i)) < cutoff);
        tmpLogical(tmpLogical)=sum(bsxfun(@minus,crd2(:,tmpLogical),crd1(:,i)).^2,1) < sqcutoff;
        MajorLogical(:)=MajorLogical|tmpLogical;
    end
    logicIndexArray = inputCell{2};
    logicIndexArray(logicIndexArray)=MajorLogical(:);
end


end
