function [massCenter] = getCenterOfMass(pdbStructure)
%%%%%%%%%%%%%%%%%%
% input:
%   pdbStructure
% return:
%   massCenter
%%%%%%%%%%%%%%%%%%
masses = [pdbStructure.mass]';
extandMasses = repmat(masses,1,3);
crd = getCoord(pdbStructure);
massCenter = sum(crd.*extandMasses/sum(masses,1));