function [pdb1,pdb2]=extractContactRes(pdb1,pdb2,withinDistance)
%%%%%%%%%%%% need getPairwiseDistance%%%%%%%%%%%%%%%
% input:
%   pdb1 is the structure gotten from cafrompdb.
%   pdb2 is the structure gotten from cafrompdb.
%   withinDistance 
% return:
%   pdb1 is the structure gotten from cafrompdb that just contain contact
%       residues.
%   pdb2 is the structure gotten from cafrompdb that just contain contact
%       residues.
%%%%%%%%%%%% need getPairwiseDistance%%%%%%%%%%%%%%%
pairwiseDistance=getPairwiseDistance(pdb1,pdb2);
contactMatix=(pairwiseDistance<=withinDistance);
indexOfContactRes1=(sum(contactMatix)>0);
indexOfContactRes2=(sum(contactMatix,2)>0);
pdb1=pdb1(indexOfContactRes1);
pdb2=pdb2(indexOfContactRes2);