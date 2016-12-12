function [contactMatrix] = getContactMatrix(pdb1,pdb2,cutOff)
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input:
%   pdb1: the structure gotten from readPDB.
%   pdb2: the structure gotten from readPDB.
%   cutOff: If the distance of two atom more than the cutoff, the two atom
%       are not contact.
% return:
%   contactMatrix
%       the format of dmatrix is like
%            pdb1_atom1    pdb1_atom2    pdb1_atom3------
% pdb2_atom1 iscontact11   iscontact21   iscontact31------
% pdb2_atom2 iscontact12   iscontact22   iscontact32------
% pdb2_atom3 iscontact13   iscontact23   iscontact33------
%       |       |             |            |
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pairwiseDistance= getPairwiseDistance(pdb1,pdb2);
contactMatrix = pairwiseDistance < cutOff;
