function [pdbStrcture] = setAttribute(pdbStrcture,index,values)
%%%%%%%%%%%%%%%%%%%
% input:
%   pdbStrcture
%   index: index array or logical array  
%   values: this can be a singal value or value"s". Values
%       should have the same number of row as the number of atoms which are
%       assigned.
% return:
%   pdbStrcture
%%%%%%%%%%%%%%%%%%%

if islogical(index)
    index = find(index);
end

if 