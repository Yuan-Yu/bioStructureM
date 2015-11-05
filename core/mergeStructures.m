function [mergedStructure]=mergeStructures(varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% merge PDB Structures, 
% input:
%   PDBStructure1:
%   PDBStructure2
%       |
%       |
% return:
%   mergedStrcture : the PDB structure is merged all the input PDB Structure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numStruc  = length(varargin);
atomNums = zeros(1,numStruc);
minimumFields = fieldnames(varargin{1});

for i = 1:numStruc
    atomNums(i) = length(varargin{i});
    minimumFields = intersect( minimumFields, fieldnames( varargin{i}));
end

tmpDiffField=setdiff(fieldnames(varargin{1}),minimumFields);
mergedStructure = rmfield(varargin{1},tmpDiffField);
mergedStructure = orderfields(mergedStructure,minimumFields);
mergedStructure(sum(atomNums)).(minimumFields{1}) = [];

for i = 2:numStruc
    tmpDiffField=setdiff(fieldnames( varargin{i}),minimumFields);
    tmpStructure = rmfield(varargin{i},tmpDiffField);
    startindex = sum( atomNums(1:i-1) )+1;
    endindex = sum( atomNums(1:i) );
    mergedStructure(startindex : endindex) = orderfields(tmpStructure,minimumFields);
end
mergedStructure = assignAtomno(mergedStructure);
mergedStructure = assignInternalResno(mergedStructure);



