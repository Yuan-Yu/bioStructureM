function [contactMatrix,contactNum] = getContactMatrix(pdb,cutOff)
%%%%%%%%%%% need pairwiseDistance %%%%%%%%%%%%%%%%%%%
% input:
%   pdb is the structure gotten from cafrompdb.
%   cutOff: If the distance of two atom more than the cutoff, the two atom
%       are not contact.
% return:
%   contactMatrix is the GNM format contact matrix.
%   contactNum is a vector of the contact number of each atom.
%%%%%%%%%%% need pairwiseDistance %%%%%%%%%%%%%%%%%%%
if ~exist('cutOff','var')
    cutOff=7.3;
end
numOfAtom=length(pdb);
pairwiseDistance=getPairwiseDistance(pdb,pdb);
%the diag is 0.
contactMatrix=eye(numOfAtom)-(pairwiseDistance<cutOff);
contactNum=-sum(contactMatrix,2);
contactMatrix=contactMatrix+diag(contactNum);
end
