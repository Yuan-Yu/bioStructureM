function [output] = getAminoAcid(pdbStructure,isReturnIndex,nonAminoResWithCA)
%%%%%%%%%%%%%%%%
% Select the standard and non-standard amino acid. 
% input:
%   PDBStructure
%   isReturnIndex (optional) : defind return type. 1 = logical array, 0 = pdbstructure
%       Default: 0.
% return:
%   output
%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ~exist('isReturnIndex','var')
    isReturnIndex = 0;
end
if ~exist('nonAminoResWithCA','var')
    load nonAminoResWithCA.mat
end
selectedCA = getAminoAcidCA(pdbStructure,1,nonAminoResWithCA);
internalResnos = [pdbStructure.internalResno];
selected = ismember(internalResnos,internalResnos(selectedCA));
if isReturnIndex
    output = selected;
else
    output = pdbStructure(selected);
end