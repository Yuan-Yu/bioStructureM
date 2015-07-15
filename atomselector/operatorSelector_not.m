function [logicIndexArray]=operatorSelector_not(keyword,PDBStructure,inputCell)
%%%%%%%%%%%%%% need %%%%%%%%%%%%%
% input:
%   keyword
%   PDBStructure
%   input1
%   input2
% return:
%   logicIndexArray
%%%%%%%%%%%%%% need %%%%%%%%%%%%%
logicIndexArray = inputCell{1} ==0;