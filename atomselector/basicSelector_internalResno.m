function [logicIndexArray]=basicSelector_internalResno(PDBStructure,selectionCell)
%%%%%%%%%%%%%% need %%%%%%%%%%%%%
% input:
%   PDBStructure
%   selectionCell
% return:
%   logicIndexArray
%%%%%%%%%%%%%% need %%%%%%%%%%%%%

resids=translateNunberTypeCommand(selectionCell,0);

logicIndexArray=ismember([PDBStructure.internalResno],resids);
