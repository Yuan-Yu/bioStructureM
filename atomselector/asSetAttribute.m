function [pdbStructure] =  asSetAttribute(selectionString,pdbStructure,fieldName,values)
%%%%%%%%%%%%%%%%%%%
% input:
%   selectionString: the selection command string semirlar to VMD type.
%   pdbStructure: the structure array gotten by readPDB.
%   feildName:
%   values: this can be a singal value or value"s". Values
%       should have the same number of row as the number of atoms which are
%       assigned. The values should be a 2D array or a cell.
% return:
%   pdbStructure: pdb structure is assigned values.
%%%%%%%%%%%%%%%%%%%
index = as(selectionString,pdbStructure,1);
pdbStructure = setAttribute(pdbStructure,index,fieldName,values);