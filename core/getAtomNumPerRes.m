function [atomNunPerResidue] = getAtomNumPerRes(pdbStructure)
%%%%%%%%%% need %%%%%%%%%%%%%%
% Get the number of atoms for each residue
% input:
%	pdbStructure: the structure array gotten by readPDB.
% return:
%	atomNunPerResidue: an array contain the number of atoms for each residue.
%%%%%%%%%% need %%%%%%%%%%%%%%
internalResnos = [pdbStructure.internalResno];
resNum = length(unique(internalResnos));
atomNunPerResidue = zeros(1,resNum);
tmpResNum = 0;
index =1;
lastResno = internalResnos(index);

for i =1:length(internalResnos)
    currentResno = internalResnos(i);
    if internalResnos(i) == lastResno
        tmpResNum = tmpResNum+1;
    else
        atomNunPerResidue(index) = tmpResNum;
        lastResno = currentResno;
        tmpResNum = 1;
        index = index+1;
    end
end
atomNunPerResidue(end) = tmpResNum;
