function [logicIndexArray]=basicSelector_resid(PDBStructure,selectionCell)
%%%%%%%%%%%%%% need %%%%%%%%%%%%%
% input:
%   PDBStructure
%   selectionCell
% return:
%   logicIndexArray
%%%%%%%%%%%%%% need %%%%%%%%%%%%%

resids=translateNunberTypeCommand(selectionCell,1);

logicIndexArray=ismember({PDBStructure.resno},resids);