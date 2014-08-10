function [pdb]=GNM(pdb,mode,cutOff)
%%%%%%%%%%%%% need getContactMatrix.m,getPairwiseDistance.m%%%%%%%%%%%%%%%%%%
% input:
%   pdb is the structure that gotten from cafrompdb.
%   cutOff: if the distance of two atom is less than cutOff,the two atom
%       is contact to each other.
%   mode is a number the meaning is how many mode do you want.
% return:
%   pdb is the structure that contain GNM attribute.(ex pdb(indexOfAtom).GNM or pdb(indexOfAtom).GNMValue)
%   the format is like
%       pdb(indexOfAtom).GNM(modth)=the eigenvector of the n GNM mode of the atom.
%       pdb(indexOfAtom).GNMValue(modth)=the eigvalue of the n GNM mode.
%
%%%%%%%%%%%%% need getContactMatrix.m,getPairwiseDistance.m%%%%%%%%%%%%%%%%%%
if ~exist('cutOff','var')
    cutOff=7.3;
end

contactMatrix=getContactMatrix(pdb,cutOff);
[U,S]=eig(contactMatrix);
S=diag(S);

if S(1)>10^(-9)
    error('warning: the fist eigenvalue is not zero.');
end

lastMode=1+mode;
for i=1:length(pdb)
    for j=2:lastMode
        pdb(i).GNM(j-1)=U(i,j);
        pdb(i).GNMValue(j-1)=S(j);
    end
end

end
