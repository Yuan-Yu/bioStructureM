function [movedStructure]=moveStructure(pdbStructure,T,R)
%%%%%%%%%%%%%%%%% need getCoordfromca %%%%%%%%%%%%%%%%%%%
% input:
%   pdbStructure: The stucture array gotten from readPDB.
%   T: Translation vector
%   R: Rotation matrix
%%%%%%%%%%%%%%%%% need getCoordfromca %%%%%%%%%%%%%%%%%%%
if ~exist('R','var')
    R=eye(3);
end
numAtom=length(pdbStructure);
originalCrd=getCoordfromca(pdbStructure);
movedCrd=originalCrd*R+repmat(T,numAtom,1);
movedStructure=refreshCoordToCA(pdbStructure,movedCrd);