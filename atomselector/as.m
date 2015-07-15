function [selectedAtoms]=as(selectionString,PDBStructure,islogic)
%%%%%%%%%%% need commandParser,OperateCommand%%%%%%%%%%%
% To select atom from pdb Structure array by selection language
%
% input:
%   selectionString: the selection command string semirlar to VMD type.
%   PDBStructure: the structure array gotten by readPDB.
%   islogic (option): default is 0
% return:
%   selectedAtoms: if the islogic is 0:
%                   an structure array which is same format as  PDBStructure
%                   but contain the selected atoms only
%                  if the islogic is 1:
%                   an logical array can be applied to PDBStructure.
%
%%%%%%%%%%% need %%%%%%%%%%%
if ~exist('islogic','var')
    islogic = 0;
end
try
    transformedCommands=commandParser(selectionString,PDBStructure);
    selectedAtoms=operateCommand(transformedCommands,PDBStructure);
    if islogic ==0
        selectedAtoms = PDBStructure(selectedAtoms);
    end
catch error
    throw(MException('atomSelector:SelectionError',['Selection Syntax Error\n' error.message]));
end
end
