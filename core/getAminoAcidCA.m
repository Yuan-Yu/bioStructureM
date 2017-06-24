function [output] = getAminoAcidCA(pdbStructure,isReturnIndex,nonAminoResWithCA)
%%%%%%%%%%%%%%%%
% Select the standard and non-standard amino acid's Ca atom. 
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
indexCa = ~cellfun(@isempty,regexp({pdbStructure.atmname},'^CA$','once'));
nonAminoSeletion = strjoin(cellfun(@(x) ['^' x '$'],nonAminoResWithCA,'UniformOutput',0),'|');
indexNonAmino = cellfun(@isempty,regexp({pdbStructure.resname},nonAminoSeletion,'once'));
selectedCA = indexCa & indexNonAmino;
if isReturnIndex
    output = selectedCA;
else
    output = pdbStructure(selectedCA);
end