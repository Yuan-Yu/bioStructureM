function [logicIndexArray]=operatorSelector_bychain(keyword,PDBStructure,inputCell)
%%%%%%%%%%%%%% need %%%%%%%%%%%%%
% input:
%   keyword
%   PDBStructure
%   inputCell
% return:
%   logicIndexArray
%%%%%%%%%%%%%% need %%%%%%%%%%%%%
preSelectedAtom=PDBStructure(inputCell{1});
logicIndexArray=ismember({PDBStructure.subunit},unique({preSelectedAtom.subunit}));
