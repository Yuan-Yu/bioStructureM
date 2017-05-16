function dist = getDistance(PDBStructure1,PDBStructure2,useCOM)
%%%%%%%%%%%%%%%%%%%%%%%%%
% measure the distance between the two center of PDBStructure1 and PDBStructure2.
% input:
%   PDBStructure1
%   PDBStructure2
%   useCOM (optional): use Center of Mass instead of geometrycenter (default: 0,Geometrycenter)
% return:
%   dist: the distance between the two center
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if ~exist('useCOM','var')
        useCOM = 0;
    end

    if useCOM
        vector = getCenterOfMass(PDBStructure1) - getCenterOfMass(PDBStructure2);
    else
        vector = getGeometrycenter(PDBStructure1) - getGeometrycenter(PDBStructure2);
    end
    dist = sum(vector.^2)^0.5;
end