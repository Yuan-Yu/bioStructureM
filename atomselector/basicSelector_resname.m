function [logicIndexArray]=basicSelector_resname(PDBStructure,selectionCell)
%%%%%%%%%%%%%% need %%%%%%%%%%%%%
% input:
%   PDBStructure
%   selectionString
% return:
%   logicIndexArray
%%%%%%%%%%%%%% need %%%%%%%%%%%%%
pdbResname={PDBStructure.resname};
%pdbResname=reshape(pdbResname,3,length(pdbResname)/3)';
logicIndexArray=ismember(pdbResname,selectionCell);