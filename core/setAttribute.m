function [pdbStructure] = setAttribute(pdbStructure,index,fieldName,values)
%%%%%%%%%%%%%%%%%%%
% input:
%   pdbStructure
%   index: index array or logical array  
%   feildName:
%   values: this can be a singal value or value"s". Values
%       should have the same number of row as the number of atoms which are
%       assigned. The values should be a 2D array or a cell.
% return:
%   pdbStructure
%%%%%%%%%%%%%%%%%%%

% Transform logical index to index
if islogical(index)
    index = find(index);
end

[row,col]=size(index);
if row ~=1
    index = index';
end

numAtom = length(index);
[row,col] = size(values);
if  ischar(values) || (row == 1 && col == 1)
    if iscell(values)
        for i = index
            pdbStructure(i).(fieldName) = values{1};
        end
    else 
        for i = index
            pdbStructure(i).(fieldName) = values;
        end
    end
else
    if row == numAtom
        if iscell(values)
            for i = index
                pdbStructure(i).(fieldName) = values{i,:};
            end
        else 
            for i = index
                pdbStructure(i).(fieldName) = values(i,:);
            end
        end
    elseif col == numAtom
        if iscell(values)
            for i = index
                pdbStructure(i).(fieldName) = values{:,i};
            end
        else 
            for i = index
                pdbStructure(i).(fieldName) = values(:,i);
            end
        end
    else
        for i = index
                pdbStructure(i).(fieldName) = values;
        end
    end
end