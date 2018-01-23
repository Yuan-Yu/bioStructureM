function [PCs,eigvalues]=getPrincipalAxis(pdbStructure,mass_weighted)
%%%%%%%%%%%%%%% 
% input:
%   pdbStructure
%   mass_weighted
% return:
%   PCs: The 3 principal axis of the structure.
%           [ principal_axis_1_x, principal_axis_2_x, principal_axis_3_x
%             principal_axis_1_y, principal_axis_2_y, principal_axis_3_y
%             principal_axis_1_z, principal_axis_2_z, principal_axis_3_z]
%   eigvalues: The 3 eigvalues of the PCs and same order as PCs.
%%%%%%%%%%%%%%% 
if ~exist('mass_weighted','var')
    mass_weighted = 0;
end
atomNum =length(pdbStructure);
if mass_weighted
    masses = [pdbStructure.mass]';
else
    masses = ones(atomNum,1);
end
extandMasses = repmat(masses,1,3);
crd = getCoord(pdbStructure);
massCenter = sum(crd.*extandMasses/sum(masses,1));
q = (crd - repmat(massCenter,atomNum,1)).*extandMasses;
[PCs,eigvalues] = eig(q'*q);
[eigvalues,index]= sort(diag(eigvalues),'descend');
PCs = PCs(:,index);
eigvalues = diag(eigvalues);



