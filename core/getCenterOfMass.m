function [massCenter] = getCenterOfMass(pdbStructure)
%%%%%%%%%%%%%%%%%%
% input:
%   pdbStructure
% return:
%   massCenter
%%%%%%%%%%%%%%%%%%
if ~isfield(pdbStructure,'mass')
    pdbStructure = assignMass(pdbStructure);
end
masses = [pdbStructure.mass]';
extandMasses = repmat(masses,1,3);
crd = getCoord(pdbStructure);
massCenter = sum(crd.*extandMasses/sum(masses,1),1);