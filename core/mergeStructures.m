function [mergedStructure]=mergeStructures(varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Merge PDB Structures. This will reassign the atom index.
% input:
%   PDBStructure1
%   PDBStructure2
%       |
%       |
%   Note: inputs can be a cell of the PDBstructures. 
% return:
%   mergedStrcture : the PDB structure is merged all the input PDB Structure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numInput  = length(varargin);
numStruc = 0;
PDBStructures = {};
for i = 1:numInput
    input = varargin{i};
    if iscell(input)
        numStructureinCell = length(input);
        for indexInCell = 1:numStructureinCell
            numStruc = numStruc + 1;
            PDBStructures{numStruc} = input{indexInCell};
        end
    else
        numStruc = numStruc + 1;
        PDBStructures{numStruc} = input;
    end
end

    
atomNums = zeros(1,numStruc);
minimumFields = fieldnames(PDBStructures{1});
for i = 1:numStruc
    atomNums(i) = length(PDBStructures{i});
    minimumFields = intersect( minimumFields, fieldnames( PDBStructures{i}));
end

tmpDiffField=setdiff(fieldnames(PDBStructures{1}),minimumFields);
mergedStructure = rmfield(PDBStructures{1},tmpDiffField);
mergedStructure = orderfields(mergedStructure,minimumFields);
mergedStructure(sum(atomNums)).(minimumFields{1}) = [];

for i = 2:numStruc
    tmpDiffField=setdiff(fieldnames( PDBStructures{i}),minimumFields);
    tmpStructure = rmfield(PDBStructures{i},tmpDiffField);
    startindex = sum( atomNums(1:i-1) )+1;
    endindex = sum( atomNums(1:i) );
    mergedStructure(startindex : endindex) = orderfields(tmpStructure,minimumFields);
end
mergedStructure = assignAtomno(mergedStructure);
mergedStructure = assignInternalResno(mergedStructure);



