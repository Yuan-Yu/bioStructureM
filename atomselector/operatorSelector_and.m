function [logicIndexArray]=operatorSelector_and(keyword,PDBStructure,inputCell)
%%%%%%%%%%%%%% need %%%%%%%%%%%%%
% input:
%   keyword
%   PDBStructure
%   inputCell
% return:
%   logicIndexArray
%%%%%%%%%%%%%% need %%%%%%%%%%%%%

logicIndexArray = inputCell{1} & inputCell{2};