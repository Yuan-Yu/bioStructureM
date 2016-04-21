function [geometrycenter]=getGeometrycenter(pdbStructure)
%%%%%%%%%%%% need getCoord %%%%%%%%%%%%%%
% input:
%   pdbStructure: the struture array is getten from readPDB
% reture:
%   geometrycenter: the geometrycenter of the pdb
%%%%%%%%%%%% need getCoord %%%%%%%%%%%%%%

    geometrycenter=mean(getCoord(pdbStructure),1);
end