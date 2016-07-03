function [pdbStruct] = setCoordIP(pdbStruct,selectedAtoms,coordData)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% assign new coordinates for specific atoms.
% warning: the output veriable must be same as input veriable.
% input:
%   pdbStruct: the pdb structure array gotten from readPDB.
%   selectedAtoms: An array cantain the indexes of specific atoms which
%       assigned new coordinate.Or a logical array for specific atoms and
%       the length of the logical array need to match the number of atoms
%       of the pdbStruct.
%   coordData:
%       a coordnate vector (ether column or raw vector) like
%           atom1_x
%           atom1_y
%           atom1_z
%           atom2_x
%           atom2_y
%           atom2_z
%               |
%       OR a n by 3 array (where the n is the number of atoms)
%           atom1_x atom1_y atom1_z
%           atom2_x atom2_y atom2_z
%           atom3_x atom3_y atom3_z
%               |       |       |
% return:
%   pdbStruct: assigned pdbStruct
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    setCoordCPP(pdbStruct,selectedAtoms,coordData);
end
