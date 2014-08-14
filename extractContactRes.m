function [pdb1,pdb2,chainID1,resIDCell1,chainID2,resIDCell2]=extractContactRes(pdb1,pdb2,withinDistance)
%%%%%%%%%%%% need getPairwiseDistance%%%%%%%%%%%%%%%
% input:
%   pdb1 is the structure gotten from cafrompdb.
%   pdb2 is the structure gotten from cafrompdb.
%   withinDistance the 
% return:
%   pdb1 is the structure gotten from cafrompdb that just contain contact
%       residues.
%   pdb2 is the structure gotten from cafrompdb that just contain contact
%       residues.
%   chainID1: all of the chainIDs of pdb1.
%   resIDCell1: this is a cell array that each element is an array
%       containing the residues number of one chain in pdb1.
%   chainID2: all of the chainIDs of pdb2.
%   resIDCell2: this is a cell array that each element is an array
%       containing the residues number of one chain in pdb2.
%   ex. chainID1=[AB]
%       resIDCell1={[1 2 4 5],[ 2 6 7 ]}
%       The meaning is that pdb1 contain A and B chain. The contact residue
%       numbers of the chain A is 1,2,4 and 5. So, 2,6 and 7 is the contact
%       residue numbers of the chain B.
%%%%%%%%%%%% need getPairwiseDistance%%%%%%%%%%%%%%%
pairwiseDistance=getPairwiseDistance(pdb1,pdb2);
contactMatix=(pairwiseDistance<=withinDistance);
indexOfContactRes1=(sum(contactMatix)>0);
indexOfContactRes2=(sum(contactMatix,2)>0);
pdb1=pdb1(indexOfContactRes1);
pdb2=pdb2(indexOfContactRes2);
[pdbCell1,chainID1]=separatePDBByChain(pdb1);
[pdbCell2,chainID2]=separatePDBByChain(pdb2);
resIDCell1=cell(1,length(chainID1));
resIDCell2=cell(1,length(chainID2));
for i=1:length(chainID1)
    resIDCell1{i}=[pdbCell1{i}.resno];
end
for i=1:length(chainID2)
    resIDCell2{i}=[pdbCell2{i}.resno];
end

    