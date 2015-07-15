function [logicIndexArray]=basicSelector_atomnum(PDBStructure,selectionCell)
%%%%%%%%%%%%%% need %%%%%%%%%%%%%
% input:
%   PDBStructure
%   selectionString
% return:
%   logicIndexArray
%%%%%%%%%%%%%% need %%%%%%%%%%%%%


atomNum=translateNunberTypeCommand(selectionCell,0);
logicIndexArray=ismember([PDBStructure.atomno],atomNum);