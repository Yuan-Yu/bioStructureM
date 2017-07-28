function [contactMatrix] = getContactMatrixByCoord(coord1,coord2,cutOff)
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input:
%   coord1: a double array has N by 3
%   coord2: a double array has N by 3.
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
[numAtoms,~]=size(coord1);
[numAtom2,~]=size(coord2);
pairwiseDistance=Inf(numAtom2,numAtoms);

for i=1:numAtoms
    dRi=coord2-repmat(coord1(i,:),numAtom2,1);
    pairwiseDistance(:,i)=sqrt(sum(dRi.^2,2));
end
contactMatrix = pairwiseDistance < cutOff;